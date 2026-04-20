import 'package:dartz/dartz.dart';
import 'package:spotify/data/models/auth/create_user_request.dart';
import 'package:spotify/data/models/auth/sign_in_user_request.dart';
import 'package:spotify/data/sources/auth/auth_firebase_service.dart';
import 'package:spotify/domain/repository/auth/auth_repository.dart';
import '../../../service/service_locator.dart';

class AuthRepositoryImpl extends AuthRepository {

  @override
  Future<Either> signIn(SignInUserRequest request) async {
    return await service<AuthFirebaseService>().signIn(request);
  }

  @override
  Future<Either> signUp(CreateUserRequest request) async {
    return await service<AuthFirebaseService>().signUp(request);
  }

  @override
  Future<Either> signInWithFacebook() async {
    return await service<AuthFirebaseService>().signInWithFacebook();
  }

  @override
  Future<Either> signInWithGoogle() async {
    return await service<AuthFirebaseService>().signInWithGoogle();
  }

  @override
  Future<Either> signOut() async {
    return await service<AuthFirebaseService>().signOut();
  }
}