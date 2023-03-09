import 'dart:async';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';

import 'package:grassroots_app/firebase_options.dart';

import 'package:grassroots_app/universals/variables.dart';
import 'package:grassroots_app/universals/theme.dart';

import 'package:grassroots_app/pages/initial/welcome.dart';
import 'package:grassroots_app/pages/initial/sign_up.dart';
import 'package:grassroots_app/pages/initial/login.dart';

import 'package:grassroots_app/pages/home/home.dart';
import 'package:grassroots_app/pages/settings/settings.dart';

import 'package:grassroots_app/pages/today/add_day_plan/add_day_plan.dart';
import 'package:grassroots_app/pages/today/add_moods/add_moods.dart';
import 'package:grassroots_app/pages/today/add_notes/add_notes.dart';

import 'package:grassroots_app/services/themeModeNotifierService/theme_mode_notifier_service.dart';

enum SampleItem { itemOne, itemTwo, itemThree }

void main() async {
  WidgetsBinding? widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    ChangeNotifierProvider<ThemeModeNotifierService>(
      create: (
        BuildContext? context,
      ) =>
          ThemeModeNotifierService(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
  });

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  late StreamSubscription<User?> user;

  @override
  void initState() {
    user = FirebaseAuth.instance.authStateChanges().listen(
          (
            User? firebaseUser,
          ) {},
        );

    FlutterNativeSplash.remove();

    super.initState();
  }

  @override
  void dispose() {
    user.cancel();

    super.dispose();
  }

  @override
  Widget build(
    BuildContext? context,
  ) {
    return Consumer<ThemeModeNotifierService>(
      builder: (
        BuildContext? context,
        ThemeModeNotifierService? theme,
        Widget? a,
      ) {
        globalThemeModeNotifier = theme;

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Grassroots',
          theme: lightTheme!,
          darkTheme: darkTheme!,
          themeMode: theme!.getThemeMode(),
          scrollBehavior: const MaterialScrollBehavior().copyWith(
            dragDevices: {
              PointerDeviceKind.mouse,
              PointerDeviceKind.touch,
              PointerDeviceKind.stylus,
              PointerDeviceKind.trackpad,
            },
          ),
          initialRoute:
              FirebaseAuth.instance.currentUser == null ? '/welcome' : '/home',
          routes: {
            // '/': (
            //   BuildContext? context,
            // ) =>
            //     initNavigate()!,
            '/welcome': (
              BuildContext? context,
            ) =>
                const GrassrootsWelcome(),
            '/sign_up': (
              BuildContext? context,
            ) =>
                const GrassrootsSignUp(),
            '/login': (
              BuildContext? context,
            ) =>
                const GrassrootsLogin(),
            '/home': (
              BuildContext? context,
            ) =>
                const GrassrootsHome(),
            '/settings': (
              BuildContext? context,
            ) =>
                const GrassrootsSettings(),
            '/today/add_day_plan': (
              BuildContext? context,
            ) =>
                const GrassrootsTodayAddDayPlan(),
            '/today/add_notes': (
              BuildContext? context,
            ) =>
                const GrassrootsTodayAddNotes(),
            '/today/add_moods': (
              BuildContext? context,
            ) =>
                const GrassrootsTodayAddMoods(),
          },
        );
      },
    );
  }
}
