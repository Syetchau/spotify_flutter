abstract class HomeAuthState {}

// Idle - Default
class AuthInitial extends HomeAuthState {}

// App is ready, finished splash
class AuthAppReady extends HomeAuthState {}

// Loading
class AuthLoading extends HomeAuthState {}

// User authenticated
class Authenticated extends HomeAuthState {}

// User not authenticate
class Unauthenticated extends HomeAuthState {
  final String errorMessage;
  Unauthenticated({required this.errorMessage});
}

// User perform sign out success
class SignOutSuccess extends HomeAuthState {}

// User perform sign out error
class SignOutError extends HomeAuthState {
  final String errorMessage;
  SignOutError({required this.errorMessage});
}