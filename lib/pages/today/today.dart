import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GrassrootsToday extends StatefulWidget {
  const GrassrootsToday({super.key});

  @override
  State<GrassrootsToday> createState() => _GrassrootsTodayState();
}

class _GrassrootsTodayState extends State<GrassrootsToday> {
  @override
  Widget build(
    BuildContext? context,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: Hero(
          tag: "title",
          child: Text(
            "Today",
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
      drawer: Drawer(
        backgroundColor: Theme.of(
          context,
        ).colorScheme.onBackground,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              child: Center(
                child: Text(
                  "Grassroots",
                ),
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.settings,
              ),
              title: const Text(
                "Settings",
              ),
              onTap: () {
                Navigator.pop(
                  context,
                );

                Navigator.pushNamed(
                  context,
                  "/settings",
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Welcome, ${FirebaseAuth.instance.currentUser!.displayName}!",
              style: Theme.of(
                context,
              ).textTheme.titleLarge!,
            ),
            const SizedBox(
              height: 20,
            ),
            Card(
              child: <Widget>() {
                SharedPreferences.getInstance().then(
                  (
                    SharedPreferences? prefs,
                  ) {
                    if (prefs!.getBool(
                      'isDayPlanned',
                    )!) {
                      return Text(
                        "You have already planned your day!",
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium,
                      );
                    } else {
                      return ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            "/today/add_day_plan",
                          );
                        },
                        child: const Text(
                          "Plan Your Day",
                        ),
                      );
                    }
                  },
                );

                return const CircularProgressIndicator.adaptive();
              }(),
            ),
          ],
        ),
      ),
    );
  }
}
