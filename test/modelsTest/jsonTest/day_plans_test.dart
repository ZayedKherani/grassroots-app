import 'package:flutter_test/flutter_test.dart';

import 'package:grassroots_app/models/json/day_plans.dart';
import 'package:grassroots_app/models/json/day_plan.dart';

void main() {
  group(
    'JsonDayPlans.toJson',
    () {
      final JsonDayPlans jsonDayPlans = JsonDayPlans(
        dayPlansList: [],
        dayOfPlans: DateTime.now(),
      );

      test(
        'JsonDayPlans.toJson with No JsonDayPlan',
        () async {
          expect(
            jsonDayPlans.toJson(),
            {
              'id': null,
              'dayPlansList': [],
              'dayOfPlans': jsonDayPlans.dayOfPlans,
            },
          );
        },
      );

      test(
        'JsonDayPlans.toJson with One JsonDayPlan',
        () async {
          jsonDayPlans.dayPlansList?.add(
            JsonDayPlan(
              title: 'Test Day Plan',
              isComplete: false,
            ),
          );

          expect(
            jsonDayPlans.toJson(),
            {
              'id': null,
              'dayPlansList': [
                {
                  'id': null,
                  'title': 'Test Day Plan',
                  'isComplete': false,
                },
              ],
              'dayOfPlans': jsonDayPlans.dayOfPlans,
            },
          );
        },
      );

      test(
        'JsonDayPlans.toJson with Two JsonDayPlans',
        () async {
          jsonDayPlans.dayPlansList?.add(
            JsonDayPlan(
              title: 'Test Day Plan 2',
              isComplete: true,
            ),
          );

          expect(
            jsonDayPlans.toJson(),
            {
              'id': null,
              'dayPlansList': [
                {
                  'id': null,
                  'title': 'Test Day Plan',
                  'isComplete': false,
                },
                {
                  'id': null,
                  'title': 'Test Day Plan 2',
                  'isComplete': true,
                },
              ],
              'dayOfPlans': jsonDayPlans.dayOfPlans,
            },
          );
        },
      );
    },
  );

  group(
    'JsonDayPlans.fromJson',
    () {
      test(
        'JsonDayPlans.fromJson with No JsonDayPlan',
        () async {
          final JsonDayPlans jsonDayPlans = JsonDayPlans.fromJson(
            {
              'id': null,
              'dayPlansList': [],
              'dayOfPlans': DateTime.now(),
            },
          );

          expect(
            jsonDayPlans.toJson(),
            {
              'id': null,
              'dayPlansList': [],
              'dayOfPlans': jsonDayPlans.dayOfPlans,
            },
          );
        },
      );

      test(
        'JsonDayPlans.fromJson with One JsonDayPlan',
        () async {
          final JsonDayPlans jsonDayPlans = JsonDayPlans.fromJson(
            {
              'id': null,
              'dayPlansList': [
                {
                  'id': null,
                  'title': 'Test Day Plan',
                  'isComplete': false,
                },
              ],
              'dayOfPlans': DateTime.now(),
            },
          );

          expect(
            jsonDayPlans.toJson(),
            {
              'id': null,
              'dayPlansList': [
                {
                  'id': null,
                  'title': 'Test Day Plan',
                  'isComplete': false,
                },
              ],
              'dayOfPlans': jsonDayPlans.dayOfPlans,
            },
          );
        },
      );

      test(
        'JsonDayPlans.fromJson with Two JsonDayPlans',
        () async {
          final JsonDayPlans jsonDayPlans = JsonDayPlans.fromJson(
            {
              'id': null,
              'dayPlansList': [
                {
                  'id': null,
                  'title': 'Test Day Plan',
                  'isComplete': false,
                },
                {
                  'id': null,
                  'title': 'Test Day Plan 2',
                  'isComplete': true,
                },
              ],
              'dayOfPlans': DateTime.now(),
            },
          );

          expect(
            jsonDayPlans.toJson(),
            {
              'id': null,
              'dayPlansList': [
                {
                  'id': null,
                  'title': 'Test Day Plan',
                  'isComplete': false,
                },
                {
                  'id': null,
                  'title': 'Test Day Plan 2',
                  'isComplete': true,
                },
              ],
              'dayOfPlans': jsonDayPlans.dayOfPlans,
            },
          );
        },
      );
    },
  );
}
