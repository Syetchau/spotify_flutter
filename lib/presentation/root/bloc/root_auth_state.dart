abstract class RootAuthState {}

// Idle - Default
class AuthInitial extends RootAuthState {}

// App is ready, finished splash
class AuthAppReady extends RootAuthState {}

// Loading
class AuthLoading extends RootAuthState {}

// User authenticated
class Authenticated extends RootAuthState {}

// User not authenticate
class Unauthenticated extends RootAuthState {
  final String errorMessage;
  Unauthenticated({required this.errorMessage});
}

// User perform sign out success
class SignOutSuccess extends RootAuthState {}

// User perform sign out error
class SignOutError extends RootAuthState {
  final String errorMessage;
  SignOutError({required this.errorMessage});
}