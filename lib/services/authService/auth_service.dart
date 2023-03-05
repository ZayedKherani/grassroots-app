import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

UserCredential? userCredential;

class AuthService {
  Future<UserCredential?>? signInWithGoogle({
    GoogleSignIn? alternateGoogleSignIn,
    FirebaseAuth? alternateFirebaseAuth,
  }) async {
    try {
      GoogleSignInAccount? gUser;

      if (alternateGoogleSignIn == null) {
        gUser = await GoogleSignIn(
          scopes: [
            'email',
          ],
        ).signIn();
      } else {
        gUser = await alternateGoogleSignIn.signIn();
      }

      final GoogleSignInAuthentication gAuth = await gUser!.authentication;

      final OAuthCredential gCredential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      if (alternateFirebaseAuth == null) {
        userCredential = await FirebaseAuth.instance.signInWithCredential(
          gCredential,
        );
      } else {
        userCredential = await alternateFirebaseAuth.signInWithCredential(
          gCredential,
        );
      }

      return userCredential;
    } on PlatformException {
      return null;
    }
  }

  Future<UserCredential?> signOut({
    GoogleSignIn? alternateGoogleSignIn,
    UserCredential? alternateUserCredential,
  }) async {
    if (alternateUserCredential != null) {
      return null;
    }

    if (userCredential != null) {
      if (alternateGoogleSignIn == null) {
        await GoogleSignIn().signOut();
      } else {}

      userCredential = null;

      return userCredential;
    }

    return null;
  }
}
