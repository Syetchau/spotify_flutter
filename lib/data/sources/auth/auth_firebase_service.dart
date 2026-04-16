import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify/data/models/auth/create_user_request.dart';
import 'package:spotify/data/models/auth/sign_in_user_request.dart';

abstract class AuthFirebaseService {

  Future<Either> signUp(CreateUserRequest request);

  Future<Either> signIn(SignInUserRequest request);
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
}