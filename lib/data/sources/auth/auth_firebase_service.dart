import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify/data/models/auth/create_user_request.dart';

abstract class AuthFirebaseService {

  Future<Either> signUp(CreateUserRequest request);

  Future<void> signIn();
}

class AuthFirebaseServiceImpl extends AuthFirebaseService {

  @override
  Future<void> signIn() async {

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

      if (e.code == 'weak-password') {
        message = 'The password provided is too weak';
      } else if (e.code == 'email-already-in-use') {
        message = 'An account already existed';
      }

      return Left(message);
      }
  }
}