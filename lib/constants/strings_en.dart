import 'package:dw_flutter_app/constants/strings.dart';
import 'package:flutter/foundation.dart';

@immutable
class StringsEn extends Strings {
  static const StringsEn en = StringsEn._();

  const StringsEn._()
      : super(
          appName: 'EEIA Faculty Day',
          signUpToTakePartInOurEvent: 'Sign up to take part in our event!',
          continueWithGoogle: 'Continue with Google',
          continueWithApple: 'Continue with Apple',
          bySigningUpYouAgreeToOur: 'By signing up you agree to our ',
          termsOfService: 'Terms of Service ',
          andConfirmThatYouHaveReadOur: 'and confirm that you have read our ',
          privacyPolicy: 'Privacy Policy ',
          toLearnMoreAboutHowWeUseYourData:
              'to learn more about how we use your data.',
          deleteProfile1: "Are you sure you want to delete your profile?",
          deleteProfile2: "This action cannot be undone.",
          profileCancelDelete: "Cancel",
          profileDelete: "Delete",
          profileDeleteButton: "Delete Profile",
          profileDeleteConfirmation: "Delete Profile",
          profileDeleteFailed: "Failed to delete profile",
          profileDeleteSuccess: "Profile deleted successfully.",
          home: 'Home',
          tasks: 'Tasks',
          events: 'Events',
          jobs: 'Job offers',
          scanner: 'Scanner',
          map: 'Map',
          salary: 'Salary',
          jobDescription: 'Job description',
          viewOffer: 'View offer',
          salaryUndisclosed: 'Salary undisclosed',
          assistant: 'Assistant',
          profile: 'Profile',
          yourTasks: 'Your tasks',
          standings: 'Standings',
          error: 'Error',
          empty: 'Empty',
          standingsCardPoints: 'Points',
          darkMode: 'Dark mode',
          logOut: 'Log out',
          notifications: 'Notifications',
          youHaveXPoints: 'You have %d points',
          register: 'Register',
          eventScreenDescription:
              'The calendar shows all events that will take place during EEIA Faculty Day on %s.',
          jobsScreenDescription:
              'The job offers from our partners are waiting for you!',
          taskScreenDescription:
              'Scan QR codes and complete tasks! Fantastic prizes are waiting for you!',
          firstFloor: 'First Floor',
          groundFloor: 'Ground Floor',
          standingsScreenDescription:
              'The person who scores the highest amount of points wins. In case of ex aequo the person who finished faster wins.',
          cameraPermissionWasDenied:
              'Camera permission was denied, please enable it in app settings to scan QR codes',
          openSettings: 'Open settings',
          taskFinishedSuccessfullyWithPoints:
              'Task "%s" finished successfully, you have earned %d points',
          errorPleaseLogOutAndTryAgain: 'Error, please log out and try again',
          thisQrCodeIsNotValidPleaseTryAgain:
              'This QR code is not valid, please try again',
          thisTaskHasAlreadyBeenCompleted:
              'This task has already been completed',
          unknownErrorPleaseTryAgain: 'Unknown error, please try again',
          assistantError: 'There was an error. Please try again later.',
          noMapImagesError: 'No map images found.',
          errorLoadingMapImages: 'Error loading map images',
          settingsTitle: 'Settings',
          accountDetailsTitle: 'Account details',
          timeLeft: 'TIME LEFT',
          yourPlace: 'YOUR PLACE',
          finishedTasks: 'Finished tasks',
          gainedPoints: 'Gained points',
          welcome: 'Welcome',
          winner: 'Congratulations!\n You are the winner!',
          patronsTitle: 'Patrons',
          partnersTitle: 'Partners',
          you: 'You',
          selectedLanguage: 'Language',
          sortBy: 'Sort by',
          orderBy: 'Order by',
          points: 'Points',
          name: 'Name',
          assistantWelcomeMessage:
              'Hello! I am your EEIA Faculty Day assistant. How can I help you today? 🚀\nI can provide you with information about the event, help you with tasks, and answer your questions. Feel free to ask me anything!',
          availableOnlyForLoggedUsers:
              'This content is available only for logged users.',
          signInWithGoogleOrApple: 'Sign in with Google or Apple',
          signIn: 'Sign in',
          orContinueAsGuest: 'or continue as a guest',
          registrationLinkError: 'Registration link error, find us on Facebook',
          deletingProfile: 'Deleting profile...',
          reauthNeeded: 'Reauthentication needed',
          reauthNeededDescription:
              'To perform this action, you need to reauthenticate.',
          managementTitle: 'Manage your profile',
        );
}
