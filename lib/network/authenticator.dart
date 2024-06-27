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
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );
      await FirebaseAuth.instance.signInWithCredential(oauthCredential);
      return AuthResult.success;
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
}
