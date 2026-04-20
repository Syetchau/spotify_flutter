import 'package:dartz/dartz.dart';
import 'package:spotify/data/models/auth/create_user_request.dart';
import 'package:spotify/data/models/auth/sign_in_user_request.dart';

abstract class AuthRepository {
  Future<Either> signUp(CreateUserRequest request);
  Future<Either> signIn(SignInUserRequest request);
  Future<Either> signInWithGoogle();
  Future<Either> signInWithFacebook();
  Future<Either> signOut();
}