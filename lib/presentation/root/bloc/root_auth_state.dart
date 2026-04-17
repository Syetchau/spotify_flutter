abstract class RootAuthState {}

class AuthInitial extends RootAuthState {}

class AuthLoading extends RootAuthState {}

class Authenticated extends RootAuthState {}

class Unauthenticated extends RootAuthState {
  final String errorMessage;
  Unauthenticated({required this.errorMessage});
}