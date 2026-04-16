abstract class SignInState {}

class SignInDefault extends SignInState {}

class SignInLoading extends SignInState {}

class SignInSuccess extends SignInState {}

class SignInError extends SignInState {
  final String errorMessage;

  SignInError({required this.errorMessage});
}