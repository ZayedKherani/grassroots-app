import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vector_graphics/vector_graphics.dart';

import 'package:grassroots_app/pages/initial/welcome.dart';
import 'package:grassroots_app/components/square_tile.dart';
import 'package:grassroots_app/services/authService/auth_service.dart';

class GrassrootsSignUp extends StatefulWidget {
  const GrassrootsSignUp({
    super.key,
  });

  @override
  State<GrassrootsSignUp> createState() => _GrassrootsSignUpState();
}

class _GrassrootsSignUpState extends State<GrassrootsSignUp> {
  GlobalKey<FormState>? formKey = GlobalKey<FormState>();

  bool? passwordObscure = true;
  bool? confirmPasswordObscure = true;

  String? signUpButtonHeroTag = "signUpButton";

  FirebaseAuthException? error;

  ScrollController? scrollController = ScrollController();

  @override
  Widget build(
    BuildContext? context,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: Hero(
          tag: "title",
          child: Text(
            'Grassroots Sign Up',
            style: Theme.of(
              context!,
            ).textTheme.titleLarge!,
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(
          context,
        ).colorScheme.background,
      ),
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (
          BuildContext? context,
          AsyncSnapshot<User?>? snapshot,
        ) =>
            Scrollbar(
          controller: scrollController,
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: const [
                    Spacer(),
                    Expanded(
                      flex: 8,
                      child: SvgPicture(
                        AssetBytesLoader(
                          'assets/images/sign_up.svg.vec',
                        ),
                      ),
                    ),
                    Spacer(),
                  ],
                ),
                const SizedBox(
                  height: 64,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Spacer(),
                    Expanded(
                      flex: 8,
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: Hero(
                                tag: "emailField",
                                child: Material(
                                  child: TextFormField(
                                    controller: emailController,
                                    decoration: const InputDecoration(
                                      labelText: "Email",
                                      prefixIcon: Icon(
                                        Icons.email_outlined,
                                      ),
                                    ),
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.next,
                                    onSaved: (String? email) {},
                                    validator: (String? email) {
                                      if (email!.trim().isEmpty) {
                                        return "Email is required";
                                      }
                                      if ((!email.trim().contains("@")) ||
                                          (error != null &&
                                              error!.code == "invalid-email")) {
                                        return "Email is invalid";
                                      }
                                      if (error != null &&
                                          error!.code ==
                                              "email-already-in-use") {
                                        error = null;

                                        return "Email is already in use";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: Hero(
                                tag: "passwordField",
                                child: Material(
                                  child: TextFormField(
                                    controller: passwordController,
                                    decoration: InputDecoration(
                                      labelText: "Password",
                                      prefixIcon: const Icon(
                                        Icons.lock_outline,
                                      ),
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(
                                            () {
                                              passwordObscure =
                                                  !passwordObscure!;
                                            },
                                          );
                                        },
                                        icon: const Icon(
                                          Icons.remove_red_eye_outlined,
                                        ),
                                      ),
                                    ),
                                    keyboardType: TextInputType.visiblePassword,
                                    textInputAction: TextInputAction.next,
                                    onSaved: (String? password) {},
                                    validator: (String? password) {
                                      if (password!.trim().isEmpty) {
                                        return "Password is required";
                                      }
                                      if (password.trim().length < 8) {
                                        return "Password is too short";
                                      }
                                      if (password.trim() !=
                                          confirmPasswordController!.text
                                              .trim()) {
                                        return "Passwords do not match";
                                      }
                                      if (error != null &&
                                          error!.code == "weak-password") {
                                        error = null;

                                        return "Password is too weak";
                                      }
                                      return null;
                                    },
                                    obscureText: passwordObscure!,
                                    enableSuggestions: false,
                                    autocorrect: false,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: Hero(
                                tag: "confirmPasswordField",
                                child: Material(
                                  child: TextFormField(
                                    controller: confirmPasswordController,
                                    decoration: InputDecoration(
                                      labelText: "Confirm Password",
                                      prefixIcon: const Icon(
                                        Icons.lock_outline,
                                      ),
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(
                                            () {
                                              confirmPasswordObscure =
                                                  !confirmPasswordObscure!;
                                            },
                                          );
                                        },
                                        icon: const Icon(
                                          Icons.remove_red_eye_outlined,
                                        ),
                                      ),
                                    ),
                                    keyboardType: TextInputType.visiblePassword,
                                    textInputAction: TextInputAction.next,
                                    onSaved: (String? confirmPassword) {},
                                    validator: (String? confirmPassword) {
                                      if (confirmPassword!.trim() !=
                                          passwordController!.text.trim()) {
                                        return "Passwords do not match";
                                      }
                                      return null;
                                    },
                                    obscureText: confirmPasswordObscure!,
                                    enableSuggestions: false,
                                    autocorrect: false,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: Hero(
                                tag: signUpButtonHeroTag!,
                                child: Material(
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      if (formKey!.currentState!.validate()) {
                                        try {
                                          showDialog(
                                            context: context!,
                                            builder: (BuildContext? context) =>
                                                const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                            barrierDismissible: false,
                                          );

                                          await FirebaseAuth.instance
                                              .createUserWithEmailAndPassword(
                                            email: emailController!.text,
                                            password:
                                                confirmPasswordController!.text,
                                          );

                                          await FirebaseAuth
                                              .instance.currentUser!
                                              .sendEmailVerification();

                                          if (context.mounted) {}

                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                "Verification email sent",
                                              ),
                                            ),
                                          );

                                          // await FirebaseAuth.instance.signOut();

                                          // await FirebaseAuth.instance
                                          //     .signInWithEmailAndPassword(
                                          //   email: emailController!.text,
                                          //   password:
                                          //       confirmPasswordController!.text,
                                          // );

                                          emailController!.clear();
                                          passwordController!.clear();
                                          confirmPasswordController!.clear();

                                          passwordObscure = true;
                                          confirmPasswordObscure = true;

                                          Navigator.pop(
                                            context,
                                          );

                                          Navigator.pop(
                                            context,
                                          );

                                          Navigator.pushReplacementNamed(
                                            context,
                                            '/home',
                                          );
                                        } on FirebaseAuthException catch (firebaseAuthException) {
                                          setState(
                                            () {
                                              error = firebaseAuthException;

                                              formKey!.currentState!.validate();
                                            },
                                          );
                                        }
                                      }
                                    },
                                    child: const Text(
                                      "SIGN UP",
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Hero(
                      tag: "signUpLoginSwitchText",
                      child: Text(
                        "Already have an account?",
                        style: Theme.of(
                          context!,
                        ).textTheme.bodyMedium!,
                      ),
                    ),
                    Hero(
                      tag: "signUpLoginSwitchButton",
                      child: TextButton(
                        onPressed: () {
                          setState(
                            () {
                              signUpButtonHeroTag = "loginButton";
                            },
                          );

                          Navigator.pushReplacementNamed(
                            context,
                            '/login',
                          );
                        },
                        child: const Text(
                          "Sign In",
                        ),
                      ),
                    ),
                  ],
                ),
                Hero(
                  tag: "signUpLoginSwitchDivider",
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          flex: 5,
                          child: Divider(
                            thickness: 1,
                            color: Theme.of(
                              context,
                            ).colorScheme.secondary,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          child: Text(
                            "OR CONTINUE WITH",
                            style: Theme.of(
                              context,
                            ).textTheme.bodyMedium,
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Divider(
                            thickness: 1,
                            color: Theme.of(
                              context,
                            ).colorScheme.secondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Hero(
                      tag: "googleButton",
                      child: SquareTile(
                        onTap: () async {
                          showDialog(
                            context: context,
                            builder: (BuildContext? context) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            barrierDismissible: false,
                          );

                          await AuthService().signInWithGoogle();

                          if (context.mounted) {}

                          emailController!.clear();
                          passwordController!.clear();
                          confirmPasswordController!.clear();

                          passwordObscure = true;
                          confirmPasswordObscure = true;

                          Navigator.pop(
                            context,
                          );

                          Navigator.pop(
                            context,
                          );

                          Navigator.pushReplacementNamed(
                            context,
                            '/home',
                          );
                        },
                        imagePath: 'assets/images/google.png',
                      ),
                    ),
                    // TODO: Add Apple Sign In
                    // const SizedBox(
                    //   width: 10,
                    // ),
                    // Hero(
                    //   tag: "appleButton",
                    //   child: SquareTile(
                    //     onTap: () {},
                    //     imagePath: 'assets/images/apple.png',
                    //   ),
                    // ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
