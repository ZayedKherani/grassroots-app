import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:grassroots_app/pages/calendar/calendar.dart';
import 'package:grassroots_app/pages/notes/notes.dart';
import 'package:grassroots_app/pages/support/support.dart';
import 'package:grassroots_app/pages/today/today.dart';
import 'package:grassroots_app/pages/settings/settings.dart';

class GrassrootsHome extends StatefulWidget {
  const GrassrootsHome({
    super.key,
  });

  @override
  State<GrassrootsHome> createState() => _GrassrootsHomeState();
}

class _GrassrootsHomeState extends State<GrassrootsHome> {
  String? userEmail;

  static const List<Widget?> _pages = [
    GrassrootsToday(),
    GrassrootsCalendar(),
    GrassrootsNotes(),
    GrassrootsSupport(),
    GrassrootsSettings(),
  ];

  int? _activePageIndex = 0;

  @override
  Widget build(BuildContext? context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (
          BuildContext? context,
          AsyncSnapshot<User?>? snapshot,
        ) {
          if (snapshot!.hasData) {
            return _pages[_activePageIndex!]!;
          } else {
            return const CircularProgressIndicator.adaptive();
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.today,
            ),
            label: 'Today',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.calendar_today,
            ),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.notes,
            ),
            label: 'Notes',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.support,
            ),
            label: 'Support',
          ),
        ],
        currentIndex: _activePageIndex!,
        selectedItemColor: Theme.of(
          context!,
        ).colorScheme.secondary,
        onTap: (
          int? index,
        ) {
          setState(
            () {
              _activePageIndex = index!;
            },
          );
        },
      ),
    );
  }
}
