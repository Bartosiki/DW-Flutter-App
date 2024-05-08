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
  static const String camera = 'Camera';
  static const String map = 'Map';
  static const String assistant = 'Assistant';
  static const String profile = 'Profile';
  static const String yourTasks = 'Your tasks';
  static const String standings = 'Standings';
  static const String error = 'Error';
  static const String empty = 'Empty';
  static const String standingsCardPoints = 'Points';
  static String youHaveXPoints(int points) {
    return 'You have $points points';
  }
  static const String taskScreenDescription = 'Task screen description Task screen description Task screen description';
  static const String firstFloor = 'First Floor';
  static const String groundFloor = 'Ground Floor';
  static const String standingsScreenDescription = 'The person who scores the highest amount of points wins. In case of ex aequo the person who finished faster wins';
  const Strings._();
}