abstract class SignUpState {}

class SignUpDefault extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpSuccess extends SignUpState {}

class SignUpError extends SignUpState {
  final String errorMessage;

  SignUpError({required this.errorMessage});
}