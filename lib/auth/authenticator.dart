import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'model/auth_result.dart';

class Authenticator {
  const Authenticator();

  String? get userId => FirebaseAuth.instance.currentUser?.uid;
  String? get displayName => FirebaseAuth.instance.currentUser?.displayName;
  String? get email => FirebaseAuth.instance.currentUser?.email;

  bool get isAlreadySignedIn => userId != null;

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

  Future<String?> getUserIdToken() async {
    return await FirebaseAuth.instance.currentUser?.getIdToken();
  }

  Future<AuthResult> signInAnonymously() async {
    return AuthResult.success;
  }
}
