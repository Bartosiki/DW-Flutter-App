import 'package:dw_flutter_app/exceptions/reauth_required_exception.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../model/auth_result.dart';

class Authenticator {
  const Authenticator();

  String? get userId => FirebaseAuth.instance.currentUser?.uid;
  String? get displayName => FirebaseAuth.instance.currentUser?.displayName;
  String? get email => FirebaseAuth.instance.currentUser?.email;
  Future<String?> get userIdToken async =>
      await FirebaseAuth.instance.currentUser?.getIdToken();

  bool get isAlreadySignedIn => userId != null;
  bool get isAnonymous =>
      FirebaseAuth.instance.currentUser?.isAnonymous ?? false;

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }

  Future<AuthResult> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    final signInAccount = await googleSignIn.signIn();
    if (signInAccount == null) {
      return AuthResult.aborted;
    }
    final googleAuth = await signInAccount.authentication;
    final oauthCredentials = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    try {
      await FirebaseAuth.instance.signInWithCredential(oauthCredentials);
      return AuthResult.success;
    } catch (e) {
      return AuthResult.failure;
    }
  }

  Future<AuthResult> signInWithApple() async {
    try {
      final isAvailable = await SignInWithApple.isAvailable();
      if (!isAvailable) {
        return AuthResult.failure;
      }

      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      if (appleCredential.identityToken == null) {
        return AuthResult.aborted;
      }

      final oauthCredential = OAuthProvider('apple.com').credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(oauthCredential);
      final firebaseUser = userCredential.user;

      if (firebaseUser != null) {
        if (appleCredential.givenName != null &&
            appleCredential.familyName != null) {
          final displayName =
              '${appleCredential.givenName} ${appleCredential.familyName}'
                  .trim();

          if (firebaseUser.displayName == null ||
              firebaseUser.displayName!.isEmpty) {
            await firebaseUser.updateDisplayName(displayName);
          }
        }

        return AuthResult.success;
      }

      return AuthResult.failure;
    } on SignInWithAppleAuthorizationException catch (e) {
      switch (e.code) {
        case AuthorizationErrorCode.canceled:
          return AuthResult.aborted;
        case AuthorizationErrorCode.failed:
        case AuthorizationErrorCode.invalidResponse:
        case AuthorizationErrorCode.notHandled:
        case AuthorizationErrorCode.unknown:
          return AuthResult.failure;
        case AuthorizationErrorCode.notInteractive:
          return AuthResult.failure;
      }
    } catch (e) {
      return AuthResult.failure;
    }
  }

  Future<AuthResult> signInAnonymously() async {
    try {
      await FirebaseAuth.instance.signInAnonymously();
      return AuthResult.anonymous;
    } catch (e) {
      return AuthResult.failure;
    }
  }

  Future<void> deleteAccount() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.delete();
      }
    } on FirebaseAuthException {
      throw const ReauthRequiredException();
    } catch (e) {
      throw const ReauthRequiredException();
    }
  }

  Future<bool> reauthenticateWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final signInAccount = await googleSignIn.signIn();
      if (signInAccount == null) {
        return false;
      }

      final googleAuth = await signInAccount.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.currentUser
          ?.reauthenticateWithCredential(credential);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> reauthenticateWithApple() async {
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final oauthCredential = OAuthProvider('apple.com').credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      await FirebaseAuth.instance.currentUser
          ?.reauthenticateWithCredential(oauthCredential);
      return true;
    } catch (e) {
      return false;
    }
  }
}
