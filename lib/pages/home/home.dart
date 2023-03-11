import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:grassroots_app/models/json/dayPlan/day_plan.dart';
import 'package:grassroots_app/models/json/dayPlan/day_plans.dart';
import 'package:grassroots_app/services/jsonService/json_decode_service.dart';
import 'package:grassroots_app/models/dayPlan/day_plans.dart';
import 'package:grassroots_app/pages/calendar/calendar.dart';
import 'package:grassroots_app/pages/notes/notes.dart';
import 'package:grassroots_app/pages/support/support.dart';
import 'package:grassroots_app/pages/today/today.dart';
import 'package:grassroots_app/universals/variables.dart';

class GrassrootsHome extends StatefulWidget {
  const GrassrootsHome({
    super.key,
  });

  @override
  State<GrassrootsHome> createState() => _GrassrootsHomeState();
}

class _GrassrootsHomeState extends State<GrassrootsHome> {
  SharedPreferences? prefs;

  static const List<Widget?> _pages = [
    GrassrootsToday(),
    GrassrootsNotes(),
    GrassrootsCalendar(),
    GrassrootsSupport(),
  ];

  int? _activePageIndex = 0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (
        Duration? timeStamp,
      ) async {
        prefs = await SharedPreferences.getInstance();
        if (globalDayPlans == null) {
          if (prefs!.getBool(
                'isDayPlanned',
              ) ??
              false) {
            DateTime? isDayPlannedDateTime = DateTime.parse(
              prefs!.getString(
                    'isDayPlannedDateTime',
                  ) ??
                  '2020-01-01T00:00:00.000000',
            );

            if (isDayPlannedDateTime.year != DateTime.now().year ||
                isDayPlannedDateTime.month != DateTime.now().month ||
                isDayPlannedDateTime.day != DateTime.now().day) {
              await prefs!.setBool(
                'isDayPlanned',
                false,
              );

              setState(
                () {
                  globalDayPlans = DayPlans(
                    dayOfPlans: DateTime.now(),
                  );
                },
              );
            } else {
              JsonDayPlans? jsonDayPlans =
                  await JsonDecodeService.decodeDayPlans(
                prefs!.getString(
                  'dateOfPlans${DateTime.now().year}${DateTime.now().month}${DateTime.now().day}',
                )!,
              );

              setState(
                () {
                  globalDayPlans = DayPlans.fromJson(
                    {
                      'id': jsonDayPlans!.id,
                      'dayPlansList': jsonDayPlans.dayPlansList!
                          .map(
                            (
                              JsonDayPlan? jsonDayPlan,
                            ) =>
                                jsonDayPlan!.toJson(),
                          )
                          .toList(),
                      'dayOfPlans': jsonDayPlans.dayOfPlans!,
                    },
                  );
                },
              );
            }
          } else {
            setState(
              () {
                globalDayPlans = DayPlans(
                  dayOfPlans: DateTime.now(),
                );
              },
            );
          }
        }
      },
    );

    super.initState();
  }

  @override
  Widget build(
    BuildContext? context,
  ) {
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
              Icons.notes,
            ),
            label: 'Notes',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.calendar_today,
            ),
            label: 'Calendar',
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
