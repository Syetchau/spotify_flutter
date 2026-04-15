import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/presentation/auth/bloc/sign_up_state.dart';
import '../../../data/models/auth/create_user_request.dart';
import '../../../domain/usecases/auth/sign_up_use_case.dart';
import '../../../service/service_locator.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpDefault());

  void signUp({required CreateUserRequest params}) async {
    emit(SignUpLoading());

    var result = await service<SignUpUseCase>().call(params: params);

    result.fold(
          (left) => emit(SignUpError(errorMessage: left)),
          (right) => emit(SignUpSuccess()),
    );
  }
}