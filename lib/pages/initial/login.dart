import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vector_graphics/vector_graphics.dart';

import 'package:grassroots_app/pages/initial/welcome.dart';
import 'package:grassroots_app/components/square_tile.dart';
import 'package:grassroots_app/services/authService/auth_service.dart';

class GrassrootsLogin extends StatefulWidget {
  const GrassrootsLogin({
    super.key,
  });

  @override
  State<GrassrootsLogin> createState() => _GrassrootsLoginState();
}

class _GrassrootsLoginState extends State<GrassrootsLogin> {
  GlobalKey<FormState>? formKey = GlobalKey<FormState>();
  GlobalKey<FormState>? emailFormKey = GlobalKey<FormState>();
  GlobalKey<FormState>? resetPasswordFormKey = GlobalKey<FormState>();

  bool? passwordObscure = true;

  String? loginButtonHeroTag = "loginButton";

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
            'Grassroots Login',
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
        builder: (BuildContext? context, AsyncSnapshot<User?>? snapshot) {
          return Scrollbar(
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
                            'assets/images/login.svg.vec',
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
                              Form(
                                key: emailFormKey,
                                child: SizedBox(
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
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        textInputAction: TextInputAction.next,
                                        onSaved: (String? email) {},
                                        validator: (String? email) {
                                          if (email!.trim().isEmpty) {
                                            return "Email is required";
                                          }
                                          if (!email.trim().contains("@")) {
                                            return "Email is invalid";
                                          }
                                          if (error != null &&
                                              (error!.code ==
                                                      'user-not-found' ||
                                                  error!.code ==
                                                      'wrong-password')) {
                                            return "Incorrect Email Or Password";
                                          }
                                          return null;
                                        },
                                      ),
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
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      textInputAction: TextInputAction.next,
                                      onSaved: (String? password) {},
                                      validator: (String? password) {
                                        if (password!.trim().isEmpty) {
                                          return "Password Is Required";
                                        }
                                        if (password.trim().length < 8) {
                                          return "Password Is Too Short";
                                        }
                                        if (error != null &&
                                            (error!.code == 'wrong-password' ||
                                                error!.code ==
                                                    'user-not-found')) {
                                          error = null;

                                          return "Incorrect Email Or Password";
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
                                  tag: loginButtonHeroTag!,
                                  child: Material(
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        if (formKey!.currentState!.validate() &&
                                            emailFormKey!.currentState!
                                                .validate()) {
                                          try {
                                            showDialog(
                                              context: context,
                                              builder: (
                                                BuildContext? context,
                                              ) =>
                                                  const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                              barrierDismissible: false,
                                            );

                                            await FirebaseAuth.instance
                                                .signInWithEmailAndPassword(
                                              email: emailController!.text,
                                              password:
                                                  passwordController!.text,
                                            );

                                            if (context.mounted) {}

                                            emailController!.clear();
                                            passwordController!.clear();
                                            confirmPasswordController!.clear();

                                            passwordObscure = true;

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

                                                formKey!.currentState!
                                                    .validate();
                                                emailFormKey!.currentState!
                                                    .validate();
                                              },
                                            );
                                          }
                                        }
                                      },
                                      style: Theme.of(
                                        context!,
                                      ).elevatedButtonTheme.style,
                                      child: const Text(
                                        "LOGIN",
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  const Spacer(),
                                  TextButton(
                                    onPressed: () async {
                                      try {
                                        await showDialog(
                                          context: context,
                                          builder: (BuildContext? context) =>
                                              SimpleDialog(
                                            title: const Text(
                                              "Reset Password",
                                            ),
                                            children: [
                                              Form(
                                                key: resetPasswordFormKey,
                                                child: TextFormField(
                                                  controller: emailController,
                                                  decoration:
                                                      const InputDecoration(
                                                    labelText: "Email",
                                                    prefixIcon: Icon(
                                                      Icons.email_outlined,
                                                    ),
                                                  ),
                                                  keyboardType: TextInputType
                                                      .emailAddress,
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  onSaved: (String? email) {},
                                                  validator: (String? email) {
                                                    if (email!.trim().isEmpty) {
                                                      return "Email is required";
                                                    }
                                                    if (!email
                                                        .trim()
                                                        .contains("@")) {
                                                      return "Email is invalid";
                                                    }
                                                    if (error != null &&
                                                        error!.code ==
                                                            "user-not-found") {
                                                      return "Email not found";
                                                    }
                                                    return null;
                                                  },
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                  10,
                                                  0,
                                                  10,
                                                  0,
                                                ),
                                                child: ElevatedButton(
                                                  onPressed: () async {
                                                    if (resetPasswordFormKey!
                                                        .currentState!
                                                        .validate()) {
                                                      try {
                                                        showDialog(
                                                          context: context,
                                                          builder: (BuildContext?
                                                                  context) =>
                                                              const Center(
                                                            child:
                                                                CircularProgressIndicator(),
                                                          ),
                                                          barrierDismissible:
                                                              false,
                                                        );

                                                        await FirebaseAuth
                                                            .instance
                                                            .sendPasswordResetEmail(
                                                          email:
                                                              emailController!
                                                                  .text,
                                                        );

                                                        if (context.mounted) {}

                                                        Navigator.pop(
                                                          context,
                                                        );

                                                        Navigator.pop(
                                                          context,
                                                        );

                                                        ScaffoldMessenger.of(
                                                          context,
                                                        ).showSnackBar(
                                                          const SnackBar(
                                                            content: Text(
                                                              "Password Reset Email Sent",
                                                            ),
                                                          ),
                                                        );
                                                      } on FirebaseAuthException catch (firebaseAuthException) {
                                                        setState(
                                                          () {
                                                            error =
                                                                firebaseAuthException;

                                                            resetPasswordFormKey!
                                                                .currentState!
                                                                .validate();
                                                          },
                                                        );
                                                      }
                                                    }
                                                  },
                                                  style: Theme.of(
                                                    context!,
                                                  ).elevatedButtonTheme.style,
                                                  child: const Text(
                                                    "SEND",
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      } on FirebaseAuthException catch (firebaseAuthException) {
                                        error = firebaseAuthException;
                                      }
                                    },
                                    child: Text(
                                      "Forgot Password?",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                  ),
                                ],
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
                          "Don't have an account?",
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium,
                        ),
                      ),
                      Hero(
                        tag: "signUpLoginSwitchButton",
                        child: TextButton(
                          onPressed: () {
                            setState(
                              () {
                                loginButtonHeroTag = "signUpButton";
                              },
                            );

                            Navigator.pushReplacementNamed(
                              context,
                              '/sign_up',
                            );
                          },
                          child: const Text(
                            "Sign Up",
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
                              builder: (
                                BuildContext? context,
                              ) =>
                                  const Center(
                                child: CircularProgressIndicator(),
                              ),
                              barrierDismissible: false,
                            );

                            UserCredential? userCredential =
                                await AuthService().signInWithGoogle();

                            if (context.mounted) {}

                            if (userCredential == null) {
                              Navigator.pop(
                                context,
                              );

                              return;
                            }

                            emailController!.clear();
                            passwordController!.clear();
                            confirmPasswordController!.clear();

                            passwordObscure = true;

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
          );
        },
      ),
    );
  }
}
