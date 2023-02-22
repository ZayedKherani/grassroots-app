import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vector_graphics/vector_graphics.dart';

TextEditingController? emailController = TextEditingController();
TextEditingController? passwordController = TextEditingController();
TextEditingController? confirmPasswordController = TextEditingController();

class GrassrootsWelcome extends StatefulWidget {
  const GrassrootsWelcome({super.key});

  @override
  State<GrassrootsWelcome> createState() => _GrassrootsWelcomeState();
}

class _GrassrootsWelcomeState extends State<GrassrootsWelcome> {
  @override
  Widget build(
    BuildContext? context,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: Hero(
          tag: "title",
          child: Text(
            'Grassroots',
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
      body: Column(
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
                    'assets/images/welcome.svg.vec',
                  ),
                ),
              ),
              Spacer(),
            ],
          ),
          const SizedBox(
            height: 128,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              const Spacer(),
              Expanded(
                flex: 8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Hero(
                        tag: "loginButton",
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              '/login',
                            );
                          },
                          child: const Text(
                            "LOGIN",
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
                        tag: "signUpButton",
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              '/sign_up',
                            );
                          },
                          child: const Text(
                            "SIGN UP",
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
            ],
          ),
        ],
      ),
    );
  }
}
