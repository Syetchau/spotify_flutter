import 'package:dartz/dartz.dart';
import '../../../core/usecase/use_case.dart';
import '../../../service/service_locator.dart';
import '../../repository/auth/auth_repository.dart';

class SignInWithFacebookUseCase implements UseCase<Either, dynamic> {

  @override
  Future<Either> call({params}) async {
    return service<AuthRepository>().signInWithFacebook();
  }
}