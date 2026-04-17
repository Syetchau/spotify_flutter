import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:spotify/data/models/auth/create_user_request.dart';
import 'package:spotify/data/models/auth/sign_in_user_request.dart';

abstract class AuthFirebaseService {

  Future<Either> signUp(CreateUserRequest request);

  Future<Either> signIn(SignInUserRequest request);

  Future<Either> signInWithGoogle();

  Future<Either> signInWithFacebook();
}

class AuthFirebaseServiceImpl extends AuthFirebaseService {

  @override
  Future<Either> signIn(SignInUserRequest request) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: request.email,
          password: request.password
      );

      return const Right('Sign In Successful');

    } on FirebaseAuthException catch (e) {
      String message = '';

      switch (e.code) {
        case 'invalid-email': message = 'No user found for that email.';
        case 'invalid-credential': message = 'Wrong password provided for that user.';
        case 'operation-not-allowed':message = 'Email/password accounts are not enabled.';
        case 'network-request-failed': message = 'Please check your internet connection.';
        default: message = e.message ?? 'An unknown authentication error occurred.';
      }
      return Left(message);
    }
  }

  @override
  Future<Either> signUp(CreateUserRequest request) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: request.email,
          password: request.password
      );

      return const Right('Sign Up was Successful');

    } on FirebaseAuthException catch (e) {
      String message = '';

      switch (e.code) {
        case 'weak-password': message = 'The password provided is too weak';
        case 'email-already-in-use': message = 'An account already exists for that email.';
        case 'invalid-email': message = 'The email address is not valid.';
        case 'operation-not-allowed':message = 'Email/password accounts are not enabled.';
        case 'network-request-failed': message = 'Please check your internet connection.';
        default: message = e.message ?? 'An unknown authentication error occurred.';
      }
      return Left(message);
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

     if (googleUser == null) return const Left('Sign in cancelled');

     // Obtain token
     final auth = googleUser.authentication;

     // Create Firebase Credential
     final AuthCredential credential = GoogleAuthProvider.credential(
       accessToken: auth.idToken,
       idToken: auth.idToken,
     );

     // Sign in to Firebase
     await FirebaseAuth.instance.signInWithCredential(credential);

     return const Right('Google Sign In Successful');

    } on FirebaseAuthException catch (e) {
      return Left(e.message ?? 'An error occurred during Google Sign In');
    } catch (e) {
      return const Left('An unexpected error occurred');
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
        await FirebaseAuth.instance.signInWithCredential(credential);

        return const Right('Facebook Sign In Successful');
      } else if (result.status == LoginStatus.cancelled) {
        return const Left('Facebook login was cancelled by the user');
      } else {
        return Left(result.message ?? 'Facebook login failed');
      }
    } on FirebaseAuthException catch (e) {
      return Left(e.message ?? 'An error occurred during Facebook Sign In');
    } catch (e) {
      return const Left('An unexpected error occurred');
    }
  }
}