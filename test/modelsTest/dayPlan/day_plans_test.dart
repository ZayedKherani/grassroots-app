import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:grassroots_app/models/dayPlan/day_plan.dart';
import 'package:grassroots_app/models/dayPlan/day_plans.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  group(
    'DayPlans.toJson',
    () {
      group(
        'DayPlans_DateTime_Self_Create',
        () {
          DayPlans? dayPlans = DayPlans();

          test(
            'DayPlans.toJson with No DayPlan',
            () {
              expect(
                dayPlans.toJson(),
                {
                  'id': null,
                  'dayPlansList': [],
                  'dayOfPlans': DateTime(
                    DateTime.now().year,
                    DateTime.now().month,
                    DateTime.now().day,
                  ).toIso8601String(),
                },
              );
            },
          );

          test(
            'DayPlans.toJson with One DayPlan',
            () {
              dayPlans.addDayPlan(
                dayPlanToAdd: DayPlan(
                  title: "Test Day Plan",
                  isComplete: false,
                ),
              );

              expect(
                dayPlans.toJson(),
                {
                  'id': null,
                  'dayPlansList': [
                    {
                      'id': null,
                      'dayPlanName': 'Test Day Plan',
                      'isComplete': false,
                    },
                  ],
                  'dayOfPlans': DateTime(
                    DateTime.now().year,
                    DateTime.now().month,
                    DateTime.now().day,
                  ).toIso8601String(),
                },
              );
            },
          );

          test(
            'DayPlans.toJson with Multiple DayPlan',
            () {
              dayPlans.addDayPlan(
                dayPlanToAdd: DayPlan(
                  title: "Test Day Plan 2",
                  isComplete: false,
                ),
              );

              expect(
                dayPlans.toJson(),
                {
                  'id': null,
                  'dayPlansList': [
                    {
                      'id': null,
                      'dayPlanName': 'Test Day Plan',
                      'isComplete': false,
                    },
                    {
                      'id': null,
                      'dayPlanName': 'Test Day Plan 2',
                      'isComplete': false,
                    },
                  ],
                  'dayOfPlans': DateTime(
                    DateTime.now().year,
                    DateTime.now().month,
                    DateTime.now().day,
                  ).toIso8601String(),
                },
              );
            },
          );
        },
      );

      group(
        'DayPlans_DateTime_Passed',
        () {
          DayPlans? dayPlans = DayPlans(
            dayOfPlans: DateTime(
              DateTime.now().year,
              DateTime.now().month,
              DateTime.now().day,
            ),
          );

          test(
            'DayPlans.toJson with No DayPlan',
            () {
              expect(
                dayPlans.toJson(),
                {
                  'id': null,
                  'dayPlansList': [],
                  'dayOfPlans': DateTime(
                    DateTime.now().year,
                    DateTime.now().month,
                    DateTime.now().day,
                  ).toIso8601String(),
                },
              );
            },
          );

          test(
            'DayPlans.toJson with One DayPlan',
            () {
              dayPlans.addDayPlan(
                dayPlanToAdd: DayPlan(
                  title: "Test Day Plan",
                  isComplete: false,
                ),
              );

              expect(
                dayPlans.toJson(),
                {
                  'id': null,
                  'dayPlansList': [
                    {
                      'id': null,
                      'dayPlanName': 'Test Day Plan',
                      'isComplete': false,
                    },
                  ],
                  'dayOfPlans': DateTime(
                    DateTime.now().year,
                    DateTime.now().month,
                    DateTime.now().day,
                  ).toIso8601String(),
                },
              );
            },
          );

          test(
            'DayPlans.toJson with Multiple DayPlan',
            () {
              dayPlans.addDayPlan(
                dayPlanToAdd: DayPlan(
                  title: "Test Day Plan 2",
                  isComplete: false,
                ),
              );

              expect(
                dayPlans.toJson(),
                {
                  'id': null,
                  'dayPlansList': [
                    {
                      'id': null,
                      'dayPlanName': 'Test Day Plan',
                      'isComplete': false,
                    },
                    {
                      'id': null,
                      'dayPlanName': 'Test Day Plan 2',
                      'isComplete': false,
                    },
                  ],
                  'dayOfPlans': DateTime(
                    DateTime.now().year,
                    DateTime.now().month,
                    DateTime.now().day,
                  ).toIso8601String(),
                },
              );
            },
          );
        },
      );
    },
  );

  group(
    'DayPlans.fromJson',
    () {
      test(
        'DayPlans.fromJson with null DayPlan',
        () {
          expect(
            DayPlans.fromJson(
              {
                'id': null,
                'dayPlansList': null,
                'dayOfPlans': DateTime.now().toIso8601String(),
              },
            ).toJson(),
            DayPlans().toJson(),
          );
        },
      );

      test(
        'DayPlans.fromJson with No DayPlan',
        () {
          expect(
            DayPlans.fromJson(
              {
                'id': null,
                'dayPlansList': [],
                'dayOfPlans': DateTime.now().toIso8601String(),
              },
            ).toJson(),
            DayPlans().toJson(),
          );
        },
      );

      test(
        'DayPlans.fromJson with One DayPlan',
        () {
          DayPlans dayPlans = DayPlans();

          dayPlans.addDayPlan(
            dayPlanToAdd: DayPlan(
              title: "Test Day Plan",
              isComplete: false,
            ),
          );

          expect(
            DayPlans.fromJson(
              {
                'id': null,
                'dayPlansList': [
                  {
                    'id': null,
                    'dayPlanName': 'Test Day Plan',
                    'isComplete': false,
                  }
                ],
                'dayOfPlans': DateTime.now().toIso8601String(),
              },
            ).toJson(),
            dayPlans.toJson(),
          );
        },
      );

      test(
        'DayPlans.fromJson with Multiple DayPlan',
        () {
          DayPlans dayPlans = DayPlans();

          dayPlans.addDayPlan(
            dayPlanToAdd: DayPlan(
              title: "Test Day Plan",
              isComplete: false,
            ),
          );

          dayPlans.addDayPlan(
            dayPlanToAdd: DayPlan(
              title: "Test Day Plan 2",
              isComplete: false,
            ),
          );

          expect(
            DayPlans.fromJson(
              {
                'id': null,
                'dayPlansList': [
                  {
                    'id': null,
                    'dayPlanName': 'Test Day Plan',
                    'isComplete': false,
                  },
                  {
                    'id': null,
                    'dayPlanName': 'Test Day Plan 2',
                    'isComplete': false,
                  },
                ],
                'dayOfPlans': DateTime.now().toIso8601String(),
              },
            ).toJson(),
            dayPlans.toJson(),
          );
        },
      );
    },
  );

  group(
    'DayPlans.fromDateOfPlans',
    () {
      test(
        'DayPlans.fromDateOfPlans with null DayPlan',
        () async {
          SharedPreferences.setMockInitialValues(
            {
              'dateOfPlans${DateTime.now().year}${DateTime.now().month}${DateTime.now().day}':
                  jsonEncode(
                {
                  'id': null,
                  'dayOfPlans': DateTime.now().toIso8601String(),
                },
              ),
            },
          );

          expect(
            await DayPlans.fromDateOfPlans(
              dateOfPlans: DateTime.now(),
            ).then(
              (
                DayPlans? dayPlansActual,
              ) =>
                  dayPlansActual!.toJson(),
            ),
            DayPlans().toJson(),
          );
        },
      );

      test(
        'DayPlans.fromDateOfPlans with No DayPlan',
        () async {
          SharedPreferences.setMockInitialValues(
            {
              'dateOfPlans${DateTime.now().year}${DateTime.now().month}${DateTime.now().day}':
                  jsonEncode(
                {
                  'id': null,
                  'dayPlansList': [],
                  'dayOfPlans': DateTime.now().toIso8601String(),
                },
              ),
            },
          );

          expect(
            await DayPlans.fromDateOfPlans(
              dateOfPlans: DateTime.now(),
            ).then(
              (
                DayPlans? dayPlansActual,
              ) =>
                  dayPlansActual!.toJson(),
            ),
            DayPlans().toJson(),
          );
        },
      );

      test(
        'DayPlans.fromDateOfPlans with One DayPlan',
        () async {
          DayPlans dayPlans = DayPlans();

          dayPlans.addDayPlan(
            dayPlanToAdd: DayPlan(
              title: "Test Day Plan",
              isComplete: false,
            ),
          );

          SharedPreferences.setMockInitialValues(
            {
              'dateOfPlans${DateTime.now().year}${DateTime.now().month}${DateTime.now().day}':
                  jsonEncode(
                {
                  'id': null,
                  'dayPlansList': [
                    {
                      'id': null,
                      'dayPlanName': 'Test Day Plan',
                      'isComplete': false,
                    },
                  ],
                  'dayOfPlans': DateTime.now().toIso8601String(),
                },
              ),
            },
          );

          expect(
            await DayPlans.fromDateOfPlans(
              dateOfPlans: DateTime.now(),
            ).then(
              (
                DayPlans? dayPlansActual,
              ) =>
                  dayPlansActual!.toJson(),
            ),
            dayPlans.toJson(),
          );
        },
      );

      test(
        'DayPlans.fromDateOfPlans with Multiple DayPlan',
        () async {
          DayPlans dayPlans = DayPlans();

          dayPlans.addDayPlan(
            dayPlanToAdd: DayPlan(
              title: "Test Day Plan",
              isComplete: false,
            ),
          );

          dayPlans.addDayPlan(
            dayPlanToAdd: DayPlan(
              title: "Test Day Plan 2",
              isComplete: false,
            ),
          );

          SharedPreferences.setMockInitialValues(
            {
              'dateOfPlans${DateTime.now().year}${DateTime.now().month}${DateTime.now().day}':
                  jsonEncode(
                {
                  'id': null,
                  'dayPlansList': [
                    {
                      'id': null,
                      'dayPlanName': 'Test Day Plan',
                      'isComplete': false,
                    },
                    {
                      'id': null,
                      'dayPlanName': 'Test Day Plan 2',
                      'isComplete': false,
                    },
                  ],
                  'dayOfPlans': DateTime.now().toIso8601String(),
                },
              ),
            },
          );

          expect(
            await DayPlans.fromDateOfPlans(
              dateOfPlans: DateTime.now(),
            ).then(
              (
                DayPlans? dayPlansActual,
              ) =>
                  dayPlansActual!.toJson(),
            ),
            dayPlans.toJson(),
          );
        },
      );
    },
  );
}
