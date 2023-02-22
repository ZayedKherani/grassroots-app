import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

UserCredential? userCredential;

class AuthService {
  Future<UserCredential?>? signInWithGoogle() async {
    try {
      GoogleSignInAccount? gUser = await GoogleSignIn(
        scopes: [
          'email',
        ],
      ).signIn();

      final GoogleSignInAuthentication gAuth = await gUser!.authentication;

      final OAuthCredential gCredential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      userCredential = await FirebaseAuth.instance.signInWithCredential(
        gCredential,
      );

      return userCredential;
    } on PlatformException {
      return null;
    }
  }

  Future<void> signOut() async {
    if (userCredential != null) {
      await GoogleSignIn().signOut();
    }

    userCredential = null;
  }
}
