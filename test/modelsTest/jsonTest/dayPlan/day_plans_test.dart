import 'package:flutter_test/flutter_test.dart';
import 'package:grassroots_app/models/dayPlan/notes/notes.dart';

import 'package:grassroots_app/models/json/dayPlan/day_plans.dart';
import 'package:grassroots_app/models/json/dayPlan/day_plan.dart';
import 'package:grassroots_app/models/json/dayPlan/notes/notes.dart';

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
              isTodayExpanded: false,
              notes: JsonNotes(
                jsonNotesList: [],
              ),
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
                  'isTodayExpanded': false,
                  'notes': jsonDayPlans.dayPlansList!.first!.notes!.toJson(),
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
              isTodayExpanded: false,
              notes: JsonNotes(
                jsonNotesList: [],
              ),
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
                  'isTodayExpanded': false,
                  'notes': jsonDayPlans.dayPlansList!.first!.notes!.toJson(),
                },
                {
                  'id': null,
                  'title': 'Test Day Plan 2',
                  'isComplete': true,
                  'isTodayExpanded': false,
                  'notes': jsonDayPlans.dayPlansList!.last!.notes!.toJson(),
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
                  'isTodayExpanded': false,
                  'notes': Notes().toJson(),
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
                  'isTodayExpanded': false,
                  'notes': jsonDayPlans.dayPlansList!.first!.notes!.toJson(),
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
                  'isTodayExpanded': false,
                  'notes': Notes().toJson(),
                },
                {
                  'id': null,
                  'title': 'Test Day Plan 2',
                  'isComplete': true,
                  'isTodayExpanded': false,
                  'notes': Notes().toJson(),
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
                  'isTodayExpanded': false,
                  'notes': jsonDayPlans.dayPlansList!.first!.notes!.toJson(),
                },
                {
                  'id': null,
                  'title': 'Test Day Plan 2',
                  'isComplete': true,
                  'isTodayExpanded': false,
                  'notes': jsonDayPlans.dayPlansList!.last!.notes!.toJson(),
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
