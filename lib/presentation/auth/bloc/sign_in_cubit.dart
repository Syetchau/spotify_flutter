import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/data/models/auth/sign_in_user_request.dart';
import 'package:spotify/presentation/auth/bloc/sign_in_state.dart';
import '../../../domain/usecases/auth/sign_in_use_case.dart';
import '../../../service/service_locator.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInDefault());

  void signIn({required SignInUserRequest params}) async {
    emit(SignInLoading());

    var result = await service<SignInUseCase>().call(params: params);

    result.fold(
          (left) => emit(SignInError(errorMessage: left)),
          (right) => emit(SignInSuccess()),
    );
  }
}