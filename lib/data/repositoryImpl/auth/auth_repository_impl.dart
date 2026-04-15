import 'package:dartz/dartz.dart';
import 'package:spotify/data/models/auth/create_user_request.dart';
import 'package:spotify/data/sources/auth/auth_firebase_service.dart';
import 'package:spotify/domain/repository/auth/auth_repository.dart';
import '../../../service/service_locator.dart';

class AuthRepositoryImpl extends AuthRepository {

  @override
  Future<void> signIn() async {
    // TODO:
  }

  @override
  Future<Either> signUp(CreateUserRequest request) async {
    return await service<AuthFirebaseService>().signUp(request);
  }
}