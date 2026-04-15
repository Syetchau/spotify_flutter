import 'package:dartz/dartz.dart';
import 'package:spotify/core/usecase/use_case.dart';
import 'package:spotify/data/models/auth/create_user_request.dart';
import 'package:spotify/domain/repository/auth/auth_repository.dart';
import '../../../service/service_locator.dart';

class SignUpUseCase implements UseCase<Either,CreateUserRequest> {

  @override
  Future<Either> call({CreateUserRequest? params}) async {
    return service<AuthRepository>().signUp(params!);
  }
}