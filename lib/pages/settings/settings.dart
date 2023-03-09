import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:grassroots_app/universals/variables.dart';

import 'package:grassroots_app/services/authService/auth_service.dart';

class GrassrootsSettings extends StatefulWidget {
  const GrassrootsSettings({
    super.key,
  });

  @override
  State<GrassrootsSettings> createState() => _GrassrootsSettingsState();
}

class _GrassrootsSettingsState extends State<GrassrootsSettings> {
  @override
  Widget build(
    BuildContext? context,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: Hero(
          tag: "title",
          child: Text(
            'Settings',
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
      body: Padding(
        padding: const EdgeInsets.fromLTRB(
          20,
          0,
          20,
          0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  RadioListTile(
                    value: 0,
                    groupValue: appThemeSettingsInt,
                    onChanged: (int? value) {
                      setState(
                        () {
                          appThemeSettingsInt = value!;

                          globalThemeModeNotifier!.setThemeMode(
                            ThemeMode.light,
                          );
                        },
                      );
                    },
                    title: const Text(
                      'Light',
                    ),
                  ),
                  RadioListTile(
                    value: 1,
                    groupValue: appThemeSettingsInt,
                    onChanged: (int? value) {
                      setState(
                        () {
                          appThemeSettingsInt = value!;

                          globalThemeModeNotifier!.setThemeMode(
                            ThemeMode.dark,
                          );
                        },
                      );
                    },
                    title: const Text(
                      'Dark',
                    ),
                  ),
                  RadioListTile(
                    value: 2,
                    groupValue: appThemeSettingsInt,
                    onChanged: (int? value) {
                      setState(
                        () {
                          appThemeSettingsInt = value!;

                          globalThemeModeNotifier!.setThemeMode(
                            ThemeMode.system,
                          );
                        },
                      );
                    },
                    title: const Text(
                      'System',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Card(
              child: ListTile(
                leading: Icon(
                  Icons.info_outline,
                  color: Theme.of(
                    context,
                  ).colorScheme.primary,
                ),
                title: Text(
                  "About",
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(
                          context,
                        ).colorScheme.primary,
                      ),
                ),
                onTap: () async {
                  await showDialog(
                    context: context,
                    builder: (
                      BuildContext? context,
                    ) =>
                        AlertDialog(
                      title: const Text(
                        "Grassroots",
                      ),
                      // show app version
                      content: const Text(
                        "Version 1.0.0",
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(
                              context,
                            ).push(
                              MaterialPageRoute<void>(
                                builder: (
                                  BuildContext? context,
                                ) =>
                                    Theme(
                                  data: Theme.of(
                                    context!,
                                  ).copyWith(
                                    cardColor: Theme.of(
                                      context,
                                    ).colorScheme.background,
                                    appBarTheme: AppBarTheme(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.background,
                                    ),
                                  ),
                                  child: LicensePage(
                                    applicationVersion: '1.0.0',
                                    applicationLegalese:
                                        '© 2023 Yusuf Ksaibati Media Vision',
                                    applicationName: 'Grassroots',
                                    applicationIcon: Image.asset(
                                      'assets/icons/logo-transparent.png',
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          child: Text(
                            "View Licenses",
                            style: Theme.of(
                              context!,
                            ).textTheme.bodyMedium!.copyWith(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.primary,
                                ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(
                              context,
                            );
                          },
                          child: Text(
                            "Close",
                            style: Theme.of(
                              context,
                            ).textTheme.bodyMedium!.copyWith(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.primary,
                                ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Card(
              child: ListTile(
                leading: Icon(
                  Icons.logout,
                  color: Theme.of(
                    context,
                  ).colorScheme.error,
                ),
                title: Text(
                  "Sign Out",
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(
                          context,
                        ).colorScheme.error,
                      ),
                ),
                onTap: () async {
                  await showDialog(
                    context: context,
                    builder: (
                      BuildContext? context,
                    ) =>
                        AlertDialog(
                      title: const Text(
                        "Sign Out",
                      ),
                      content: const Text(
                        "Are you sure you want to sign out?",
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(
                              context!,
                            );
                          },
                          child: const Text(
                            "Cancel",
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            await FirebaseAuth.instance.signOut();

                            AuthService().signOut();

                            if (context.mounted) {}

                            Navigator.pop(
                              context,
                            );

                            Navigator.popUntil(
                              context,
                              ModalRoute.withName(
                                '/today',
                              ),
                            );

                            Navigator.pushReplacementNamed(
                              context,
                              '/welcome',
                            );
                          },
                          child: Text(
                            "Sign Out",
                            style: Theme.of(
                              context!,
                            ).textTheme.bodyMedium!.copyWith(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.error,
                                ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Card(
              child: ListTile(
                leading: Icon(
                  Icons.delete,
                  color: Theme.of(
                    context,
                  ).colorScheme.error,
                ),
                title: Text(
                  "Reset All Settings",
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(
                          context,
                        ).colorScheme.error,
                      ),
                ),
                onTap: () async {
                  await showDialog(
                    context: context,
                    builder: (
                      BuildContext? context,
                    ) =>
                        AlertDialog(
                      title: const Text(
                        "Reset All Settings",
                      ),
                      content: const Text(
                        "Are you sure you want to reset all settings?",
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(
                              context!,
                            );
                          },
                          child: const Text(
                            "Cancel",
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            await SharedPreferences.getInstance().then(
                              (
                                SharedPreferences? prefs,
                              ) async {
                                await prefs!.clear();
                              },
                            );

                            globalDayPlans = null;
                            dayPlanDates = null;

                            await FirebaseAuth.instance.signOut();

                            AuthService().signOut();

                            if (context.mounted) {}

                            Navigator.pop(
                              context,
                            );

                            Navigator.popUntil(
                              context,
                              ModalRoute.withName(
                                '/today',
                              ),
                            );

                            Navigator.pushReplacementNamed(
                              context,
                              '/welcome',
                            );
                          },
                          child: Text(
                            "Reset",
                            style: Theme.of(
                              context!,
                            ).textTheme.bodyMedium!.copyWith(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.error,
                                ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Card(
              child: ListTile(
                leading: Icon(
                  Icons.delete,
                  color: Theme.of(
                    context,
                  ).colorScheme.error,
                ),
                title: Text(
                  "Reset All Shared Preferences",
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(
                          context,
                        ).colorScheme.error,
                      ),
                ),
                onTap: () async {
                  await showDialog(
                    context: context,
                    builder: (
                      BuildContext? context,
                    ) =>
                        AlertDialog(
                      title: const Text(
                        "Reset All Shared Preferences",
                      ),
                      content: const Text(
                        "Are you sure you want to reset all shared preferences?",
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(
                              context!,
                            );
                          },
                          child: const Text(
                            "Cancel",
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            await SharedPreferences.getInstance().then(
                              (
                                SharedPreferences? prefs,
                              ) async {
                                await prefs!.clear();
                              },
                            );

                            globalDayPlans = null;
                            dayPlanDates = null;

                            if (context.mounted) {}

                            Navigator.pop(
                              context,
                            );

                            ScaffoldMessenger.of(
                              context,
                            ).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "All shared preferences have been reset.",
                                ),
                              ),
                            );
                          },
                          child: Text(
                            "Reset",
                            style: Theme.of(
                              context!,
                            ).textTheme.bodyMedium!.copyWith(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.error,
                                ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
