import 'package:dartz/dartz.dart';
import 'package:spotify/core/usecase/use_case.dart';
import '../../../data/models/auth/sign_in_user_request.dart';
import '../../../service/service_locator.dart';
import '../../repository/auth/auth_repository.dart';

class SignInUseCase implements UseCase<Either, SignInUserRequest> {

  @override
  Future<Either> call({SignInUserRequest? params}) async {
    return service<AuthRepository>().signIn(params!);
  }
}