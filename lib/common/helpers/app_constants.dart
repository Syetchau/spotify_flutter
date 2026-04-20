class AppConstants {
  AppConstants._();
}

abstract class FirebaseConstants {
  static const String usersCollection = 'Users';
  static const String fieldName = 'name';
  static const String fieldEmail = 'email';
  static const String fieldCreatedAt = 'createdAt';
  static const String fieldLastLogin = 'lastLogin';

  static const String signUpSuccess = 'Sign Up was Successful.';
  static const String signInSuccess = 'Sign In Successful.';
  static const String googleSignInSuccess = 'Google Sign In Successful.';
  static const String googleSignInFailed = 'Google Sign In Failed.';
  static const String facebookSignInSuccess = 'Facebook Sign In Successful.';
  static const String facebookSignInFailed = 'Facebook Sign In failed.';
  static const String facebookSignInCancelled = 'Facebook Sign In was cancelled by the user.';
  static const String errorUnexpected = 'An unexpected error occurred.';
  static const String errorGoogleSignIn = 'An error occurred during Google Sign In.';
  static const String errorFacebookSignIn = 'An error occurred during Facebook Sign In.';
  static const String signOutSuccess = 'Sign Out was Successful.';
  static const String signOutFailed = 'Sign Out Failed';

  static const String providerGoogle = 'google.com';
  static const String providerFacebook = 'facebook.com';
}

abstract class ExceptionConstants {
  static const String weakPassword = 'weak-password';
  static const String weakPasswordDesc = 'The password provided is too weak.';
  static const String emailAlreadyInUse = 'email-already-in-use';
  static const String emailAlreadyInUseDesc = 'An account already exists for that email.';
  static const String invalidEmail = 'invalid-email';
  static const String invalidEmailDesc = 'The email address is not valid.';
  static const String invalidCredential= 'invalid-credential';
  static const String invalidCredentialDesc = 'Wrong credentials provided.';
  static const String userNotFound = 'user-not-found';
  static const String userNotFoundDesc = 'No user found for that email.';
  static const String wrongPassword = 'wrong-password';
  static const String wrongPasswordDesc = 'Wrong password provided.';
  static const String networkRequestFailed = 'network-request-failed';
  static const String networkRequestFailedDesc = 'Please check your internet connection.';
  static const String unknownErrorOccur = 'An unknown error occurred.';
}