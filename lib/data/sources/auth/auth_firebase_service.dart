import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:spotify/data/models/auth/create_user_request.dart';
import 'package:spotify/data/models/auth/sign_in_user_request.dart';
import '../../../common/helpers/app_constants.dart';

abstract class AuthFirebaseService {
  Future<Either> signUp(CreateUserRequest request);
  Future<Either> signIn(SignInUserRequest request);
  Future<Either> signInWithGoogle();
  Future<Either> signInWithFacebook();
  Future<Either> signOut();
}

class AuthFirebaseServiceImpl extends AuthFirebaseService {

  @override
  Future<Either> signUp(CreateUserRequest request) async {
    try {
      var data = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: request.email,
          password: request.password
      );

      await FirebaseFirestore.instance
          .collection(FirebaseConstants.usersCollection)
          .doc(data.user?.uid)
          .set({
             FirebaseConstants.fieldName: request.username,
             FirebaseConstants.fieldEmail: request.email,
             FirebaseConstants.fieldCreatedAt: FieldValue.serverTimestamp(),
             FirebaseConstants.fieldLastLogin: FieldValue.serverTimestamp()
          });

      return const Right(FirebaseConstants.signUpSuccess);

    } on FirebaseAuthException catch (e) {
      return Left(_handleAuthException(e));
    } catch (e) {
      return const Left(FirebaseConstants.errorUnexpected);
    }
  }

  @override
  Future<Either> signIn(SignInUserRequest request) async {
    try {
      final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: request.email,
          password: request.password
      );

      // Update last login timestamp
      await FirebaseFirestore.instance
          .collection(FirebaseConstants.usersCollection)
          .doc(userCredential.user?.uid)
          .update({ FirebaseConstants.fieldLastLogin: FieldValue.serverTimestamp() });

      return const Right(FirebaseConstants.signInSuccess);

    } on FirebaseAuthException catch (e) {
      return Left(_handleAuthException(e));
    } catch (e) {
      return const Left(FirebaseConstants.errorUnexpected);
    }
  }

  @override
  Future<Either> signInWithGoogle() async {
    try {
     final GoogleSignIn googleSignIn = GoogleSignIn.instance;

     // Init
     await googleSignIn.initialize();

     // Authentication
     GoogleSignInAccount? googleUser;
     if (googleSignIn.supportsAuthenticate()) {
       googleUser = await googleSignIn.authenticate();
     }

     if (googleUser == null) return const Left(FirebaseConstants.googleSignInFailed);

     // Obtain token
     final auth = googleUser.authentication;

     // Create Firebase Credential
     final AuthCredential credential = GoogleAuthProvider.credential(
       accessToken: auth.idToken,
       idToken: auth.idToken,
     );

     // Sign in to Firebase
     final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

     // Sync data
     await _upsertUserData(userCredential.user);

     return const Right(FirebaseConstants.googleSignInSuccess);

    } on FirebaseAuthException catch (e) {
      return Left(e.message ?? FirebaseConstants.errorGoogleSignIn);
    } catch (e) {
      return const Left(FirebaseConstants.errorUnexpected);
    }
  }

  @override
  Future<Either> signInWithFacebook() async {
    try {

      // Trigger the Facebook Login dialog
      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status == LoginStatus.success) {
        // Retrieve the Access Token
        final AccessToken accessToken = result.accessToken!;

        // Create a Firebase Credential using the Facebook token
        final OAuthCredential credential = FacebookAuthProvider.credential(accessToken.tokenString);

        // Authenticate with Firebase
        final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

        // Sync data
        await _upsertUserData(userCredential.user);

        return const Right(FirebaseConstants.facebookSignInSuccess);

      } else if (result.status == LoginStatus.cancelled) {
        return const Left(FirebaseConstants.facebookSignInCancelled);
      } else {
        return Left(result.message ?? FirebaseConstants.facebookSignInFailed);
      }
    } on FirebaseAuthException catch (e) {
      return Left(e.message ?? FirebaseConstants.errorFacebookSignIn);
    } catch (e) {
      return const Left(FirebaseConstants.errorUnexpected);
    }
  }

  Future<void> _upsertUserData(User? user, {String? customName}) async {
    if (user == null) return;

    final userDoc = FirebaseFirestore.instance
        .collection(FirebaseConstants.usersCollection)
        .doc(user.uid);

    // Check if the document exists once to make a logical decision
    final docSnapshot = await userDoc.get();

    if (!docSnapshot.exists) {
      // New User
      await userDoc.set({
        FirebaseConstants.fieldName: customName ?? user.displayName ?? 'New User',
        FirebaseConstants.fieldEmail: user.email,
        FirebaseConstants.fieldCreatedAt: FieldValue.serverTimestamp(),
        FirebaseConstants.fieldLastLogin: FieldValue.serverTimestamp(),
      });
    } else {
      // Returning User: Only update login time
      await userDoc.update({ FirebaseConstants.fieldLastLogin: FieldValue.serverTimestamp() });
    }
  }

  @override
  Future<Either> signOut() async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Identify which providers are linked to this account
        // This is like checking the 'providerData' list in Android's FirebaseUser
        final providers = user.providerData.map((info) => info.providerId).toList();

        // Conditionally sign out from specific social providers
        if (providers.contains(FirebaseConstants.providerGoogle)) await GoogleSignIn.instance.signOut();
        if (providers.contains(FirebaseConstants.providerFacebook)) await FacebookAuth.instance.logOut();
      }

      // Finally, sign out from the Firebase
      await FirebaseAuth.instance.signOut();

      return const Right(FirebaseConstants.signOutSuccess);
    } catch (e) {
      return Left('${FirebaseConstants.signOutFailed}: ${e.toString()}');
    }
  }

  String _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case ExceptionConstants.weakPassword: return ExceptionConstants.weakPasswordDesc;
      case ExceptionConstants.emailAlreadyInUse: return ExceptionConstants.emailAlreadyInUseDesc;
      case ExceptionConstants.invalidEmail: return ExceptionConstants.invalidEmailDesc;
      case ExceptionConstants.invalidCredential: return ExceptionConstants.invalidCredentialDesc;
      case ExceptionConstants.userNotFound: return ExceptionConstants.userNotFoundDesc;
      case ExceptionConstants.wrongPassword: return ExceptionConstants.wrongPasswordDesc;
      case ExceptionConstants.networkRequestFailed: return ExceptionConstants.networkRequestFailedDesc;
      default: return e.message ?? ExceptionConstants.unknownErrorOccur;
    }
  }
}