import 'package:flutter/foundation.dart';

@immutable
class Strings {
  static const String appName = 'Dzień Wydziału EEIA';
  static const String signUpToTakePartInOurEvent =
      'Sign up to take part in our event!';
  static const String continueWithGoogle = 'Continue with Google';
  static const String continueWithApple = 'Continue with Apple';
  static const String bySigningUpYouAgreeToOur =
      'By signing up you agree to our ';
  static const String termsOfService = 'Terms of Service ';
  static const String andConfirmThatYouHaveReadOur =
      'and confirm that you have read our ';
  static const String privacyPolicy = 'Privacy Policy ';
  static const String toLearnMoreAboutHowWeUseYourData =
      'to learn more about how we use your data.';
  static const String calendar = 'Calendar';
  static const String tasks = 'Tasks';
  static const String scanner = 'Scanner';
  static const String map = 'Map';
  static const String assistant = 'Assistant';
  static const String profile = 'Profile';
  static const String yourTasks = 'Your tasks';
  static const String standings = 'Standings';
  static const String error = 'Error';
  static const String empty = 'Empty';
  static const String standingsCardPoints = 'Points';
  static const String darkMode = 'Dark mode';
  static const String logOut = 'Log out';
  static String youHaveXPoints(int points) {
    return 'You have $points points';
  }

  static const String taskScreenDescription =
      'Task screen description Task screen description Task screen description';
  static const String firstFloor = 'First Floor';
  static const String groundFloor = 'Ground Floor';
  static const String standingsScreenDescription =
      'The person who scores the highest amount of points wins. In case of ex aequo the person who finished faster wins';
  static const String cameraPermissionWasDenied =
      'Camera permission was denied, please enable it in app settings to scan QR codes';
  static const String openSettings = 'Open settings';
  static const String taskFinishedSuccessfullyWithPoints =
      'Task "%s" finished successfully, you have earned %d points';
  static const String errorPleaseLogOutAndTryAgain =
      'Error, please log out and try again';
  static const String thisQrCodeIsNotValidPleaseTryAgain =
      'This QR code is not valid, please try again';
  static const String thisTaskHasAlreadyBeenCompleted =
      'This task has already been completed';
  static const String unknownErrorPleaseTryAgain =
      'Unknown error, please try again';
  const Strings._();
}
