import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in_mocks/google_sign_in_mocks.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';

import 'package:grassroots_app/services/authService/auth_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  test(
    'AuthService.signInWithGoogle()',
    () async {
      final googleSignIn = MockGoogleSignIn();

      final MockUser user = MockUser(
        isAnonymous: false,
        uid: '123',
        email: 'test@gmail.com',
        displayName: 'Test User',
      );

      final UserCredential? signinAccount =
          await AuthService().signInWithGoogle(
        alternateGoogleSignIn: googleSignIn,
        alternateFirebaseAuth: MockFirebaseAuth(
          mockUser: user,
        ),
      );

      expect(
        signinAccount,
        isNotNull,
      );

      expect(
        signinAccount!.user,
        isNotNull,
      );

      expect(
        signinAccount.user!.uid,
        user.uid,
      );

      expect(
        signinAccount.user!.email,
        user.email,
      );

      expect(
        signinAccount.user!.displayName,
        user.displayName,
      );

      expect(
        signinAccount.user!.isAnonymous,
        user.isAnonymous,
      );
    },
  );

  test(
    'AuthService.signOut()',
    () async {
      final googleSignIn = MockGoogleSignIn();

      final MockUser user = MockUser(
        isAnonymous: false,
        uid: '123',
        email: 'test@gmail.com',
        displayName: 'Test User',
      );

      UserCredential? signinAccount = await AuthService().signInWithGoogle(
        alternateGoogleSignIn: googleSignIn,
        alternateFirebaseAuth: MockFirebaseAuth(
          mockUser: user,
        ),
      );

      expect(
        signinAccount,
        isNotNull,
      );

      expect(
        signinAccount!.user,
        isNotNull,
      );

      expect(
        signinAccount.user!.uid,
        user.uid,
      );

      expect(
        signinAccount.user!.email,
        user.email,
      );

      expect(
        signinAccount.user!.displayName,
        user.displayName,
      );

      expect(
        signinAccount.user!.isAnonymous,
        user.isAnonymous,
      );

      signinAccount = await AuthService().signOut(
        alternateGoogleSignIn: googleSignIn,
        alternateUserCredential: signinAccount,
      );

      expect(
        signinAccount,
        isNull,
      );
    },
  );
}
