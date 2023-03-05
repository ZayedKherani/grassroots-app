import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:grassroots_app/universals/variables.dart';
import 'package:grassroots_app/models/dayPlan/day_plan.dart';
import 'package:grassroots_app/models/dayPlan/day_plans.dart';
import 'package:grassroots_app/services/dayPlanService/day_plan_service.dart';
import 'package:grassroots_app/services/jsonService/json_encode_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  setUp(
    () => globalDayPlans = DayPlans(),
  );

  test(
    'DayPlanService.getDayPlans',
    () async {
      expect(
        await DayPlanService.getDayPlans(
          getFromStorage: false,
        ),
        isA<DayPlans>(),
      );
    },
  );

  test(
    'DayPlanService.addDayPlan',
    () async {
      DayPlans? dayPlans = await DayPlanService.getDayPlans(
        getFromStorage: false,
      );

      int? dayPlansListLengthBeforeAdd = dayPlans!.dayPlansList!.length;

      await DayPlanService.addDayPlan(
        dayPlan: DayPlan(
          title: 'Test Day Plan',
          isComplete: false,
        ),
      );

      int? dayPlansListLengthAfterAdd = dayPlans.dayPlansList!.length;

      expect(
        dayPlansListLengthAfterAdd,
        dayPlansListLengthBeforeAdd + 1,
      );
    },
  );

  test(
    'DayPlanService.updateDayPlanTitle',
    () async {
      DayPlans? dayPlans = await DayPlanService.getDayPlans(
        getFromStorage: false,
      );

      await dayPlans!.addDayPlan(
        dayPlanToAdd: DayPlan(
          title: 'Test Day Plan',
          isComplete: false,
        ),
      );

      String? dayPlanTitleBeforeUpdate = dayPlans.dayPlansList!.first!.title;

      await DayPlanService.updateDayPlanTitle(
        dayPlan: dayPlans.dayPlansList!.first!,
        newDayPlayTitle: 'Test Day Plan Updated',
      );

      String? dayPlanTitleAfterUpdate = dayPlans.dayPlansList!.first!.title;

      expect(
        dayPlanTitleAfterUpdate,
        isNot(dayPlanTitleBeforeUpdate),
      );
    },
  );

  group(
    'DayPlanService.deleteDayPlan',
    () {
      group(
        'DayPlanService.deleteDayPlan global',
        () {
          setUp(
            () {
              globalDayPlans = DayPlans();
            },
          );

          test(
            'DayPlanService.deleteDayPlanByDayPlan',
            () async {
              DayPlans? dayPlans = await DayPlanService.getDayPlans(
                getFromStorage: false,
              );

              await DayPlanService.addDayPlan(
                dayPlan: DayPlan(
                  title: 'Test Day Plan',
                  isComplete: false,
                ),
              );

              await DayPlanService.addDayPlan(
                dayPlan: DayPlan(
                  title: 'Test Day Plan 2',
                  isComplete: false,
                ),
              );

              int? dayPlansListLengthBeforeDelete =
                  dayPlans!.dayPlansList!.length;

              dayPlans = await DayPlanService.deleteDayPlan(
                dayPlan: dayPlans.dayPlansList!.first,
              );

              int? dayPlansListLengthAfterDelete =
                  dayPlans!.dayPlansList!.length;

              expect(
                dayPlansListLengthAfterDelete,
                dayPlansListLengthBeforeDelete - 1,
              );
            },
          );

          test(
            'DayPlanService.deleteDayPlanByTitle',
            () async {
              DayPlans? dayPlans = await DayPlanService.getDayPlans(
                getFromStorage: false,
              );

              await DayPlanService.addDayPlan(
                dayPlan: DayPlan(
                  title: 'Test Day Plan',
                  isComplete: false,
                ),
              );

              await DayPlanService.addDayPlan(
                dayPlan: DayPlan(
                  title: 'Test Day Plan 2',
                  isComplete: false,
                ),
              );

              int? dayPlansListLengthBeforeDelete =
                  dayPlans!.dayPlansList!.length;

              dayPlans = await DayPlanService.deleteDayPlan(
                title: 'Test Day Plan',
              );

              int? dayPlansListLengthAfterDelete =
                  dayPlans!.dayPlansList!.length;

              expect(
                dayPlansListLengthAfterDelete,
                dayPlansListLengthBeforeDelete - 1,
              );
            },
          );

          test(
            'DayPlanService.deleteDayPlanById',
            () async {
              DayPlans? dayPlans = await DayPlanService.getDayPlans(
                getFromStorage: false,
              );

              await DayPlanService.addDayPlan(
                dayPlan: DayPlan(
                  id: '1234',
                  title: 'Test Day Plan',
                  isComplete: false,
                ),
              );

              await DayPlanService.addDayPlan(
                dayPlan: DayPlan(
                  id: '5678',
                  title: 'Test Day Plan 2',
                  isComplete: false,
                ),
              );

              int? dayPlansListLengthBeforeDelete =
                  dayPlans!.dayPlansList!.length;

              dayPlans = await DayPlanService.deleteDayPlan(
                id: dayPlans.dayPlansList!.first!.id,
              );

              int? dayPlansListLengthAfterDelete =
                  dayPlans!.dayPlansList!.length;

              expect(
                dayPlansListLengthAfterDelete,
                dayPlansListLengthBeforeDelete - 1,
              );
            },
          );
        },
      );

      group(
        'DayPlanService.deleteDayPlan dateOfPlans',
        () {
          test(
            'DayPlanService.deleteDayPlanByDayPlan',
            () async {
              SharedPreferences.setMockInitialValues(
                {
                  'dateOfPlans${DateTime.now().year}${DateTime.now().month}${DateTime.now().day}':
                      (await JsonEncodeService.encode(
                    {
                      'id': null,
                      'dayPlansList': [
                        {
                          'id': '1234',
                          'title': 'Test Day Plan',
                          'isComplete': false,
                        },
                        {
                          'id': '5678',
                          'title': 'Test Day Plan 2',
                          'isComplete': false,
                        },
                      ],
                      'dayOfPlans': DateTime.now().toIso8601String(),
                    },
                  ))!,
                },
              );

              DayPlans? dayPlans = await DayPlanService.getDayPlans(
                getFromStorage: true,
                dateOfPlans: DateTime.now(),
              );

              int? dayPlansListLengthBeforeDelete =
                  dayPlans!.dayPlansList!.length;

              dayPlans = await DayPlanService.deleteDayPlan(
                dayPlan: dayPlans.dayPlansList!.first,
                dateOfPlans: DateTime.now(),
              );

              int? dayPlansListLengthAfterDelete =
                  dayPlans!.dayPlansList!.length;

              expect(
                dayPlansListLengthAfterDelete,
                dayPlansListLengthBeforeDelete - 1,
              );
            },
          );

          test(
            'DayPlanService.deleteDayPlanByTitle',
            () async {
              SharedPreferences.setMockInitialValues(
                {
                  'dateOfPlans${DateTime.now().year}${DateTime.now().month}${DateTime.now().day}':
                      (await JsonEncodeService.encode(
                    {
                      'id': null,
                      'dayPlansList': [
                        {
                          'id': '1234',
                          'title': 'Test Day Plan',
                          'isComplete': false,
                        },
                        {
                          'id': '5678',
                          'title': 'Test Day Plan 2',
                          'isComplete': false,
                        },
                      ],
                      'dayOfPlans': DateTime.now().toIso8601String(),
                    },
                  ))!,
                },
              );

              DayPlans? dayPlans = await DayPlanService.getDayPlans(
                getFromStorage: true,
                dateOfPlans: DateTime.now(),
              );

              int? dayPlansListLengthBeforeDelete =
                  dayPlans!.dayPlansList!.length;

              dayPlans = await DayPlanService.deleteDayPlan(
                title: 'Test Day Plan',
                dateOfPlans: DateTime.now(),
              );

              int? dayPlansListLengthAfterDelete =
                  dayPlans!.dayPlansList!.length;

              expect(
                dayPlansListLengthAfterDelete,
                dayPlansListLengthBeforeDelete - 1,
              );
            },
          );

          test(
            'DayPlanService.deleteDayPlanById',
            () async {
              SharedPreferences.setMockInitialValues(
                {
                  'dateOfPlans${DateTime.now().year}${DateTime.now().month}${DateTime.now().day}':
                      (await JsonEncodeService.encode(
                    {
                      'id': null,
                      'dayPlansList': [
                        {
                          'id': '1234',
                          'title': 'Test Day Plan',
                          'isComplete': false,
                        },
                        {
                          'id': '5678',
                          'title': 'Test Day Plan 2',
                          'isComplete': false,
                        },
                      ],
                      'dayOfPlans': DateTime.now().toIso8601String(),
                    },
                  ))!,
                },
              );

              DayPlans? dayPlans = await DayPlanService.getDayPlans(
                getFromStorage: true,
                dateOfPlans: DateTime.now(),
              );

              int? dayPlansListLengthBeforeDelete =
                  dayPlans!.dayPlansList!.length;

              dayPlans = await DayPlanService.deleteDayPlan(
                id: '1234',
                dateOfPlans: DateTime.now(),
              );

              int? dayPlansListLengthAfterDelete =
                  dayPlans!.dayPlansList!.length;

              expect(
                dayPlansListLengthAfterDelete,
                dayPlansListLengthBeforeDelete - 1,
              );
            },
          );
        },
      );
    },
  );

  test(
    'DayPlanService.toggleDayPlanCompletion',
    () async {
      DayPlans? dayPlans = await DayPlanService.getDayPlans(
        getFromStorage: false,
      );

      await DayPlanService.addDayPlan(
        dayPlan: DayPlan(
          id: '1234',
          title: 'Test Day Plan',
          isComplete: false,
        ),
      );

      await DayPlanService.toggleDayPlanCompletion(
        dayPlan: dayPlans!.dayPlansList!.first,
      );

      expect(
        dayPlans.dayPlansList!.first!.isComplete,
        true,
      );
    },
  );

  test(
    'DayPlanService.writeDayPlansToStorage',
    () async {
      SharedPreferences.setMockInitialValues(
        {},
      );

      DayPlans? dayPlans = await DayPlanService.getDayPlans(
        getFromStorage: false,
      );

      await DayPlanService.addDayPlan(
        dayPlan: DayPlan(
          id: '1234',
          title: 'Test Day Plan',
          isComplete: false,
        ),
      );

      await DayPlanService.writeDayPlansToStorage(
        dayPlans: dayPlans!,
      );

      bool? keyContainResult = await SharedPreferences.getInstance().then(
        (
          SharedPreferences? prefs,
        ) {
          return prefs!.containsKey(
            'dateOfPlans${DateTime.now().year}${DateTime.now().month}${DateTime.now().day}',
          );
        },
      );

      expect(
        keyContainResult,
        true,
      );

      String? stringContainResult = await SharedPreferences.getInstance().then(
        (
          SharedPreferences? prefs,
        ) {
          return prefs!.getString(
            'dateOfPlans${DateTime.now().year}${DateTime.now().month}${DateTime.now().day}',
          );
        },
      );

      expect(
        stringContainResult,
        isNotNull,
      );

      expect(
        stringContainResult,
        isNot(
          '',
        ),
      );

      expect(
        stringContainResult,
        (await JsonEncodeService.encode(
          {
            'id': null,
            'dayPlansList': [
              {
                'id': '1234',
                'title': 'Test Day Plan',
                'isComplete': false,
              },
            ],
            'dayOfPlans': dayPlans.dayOfPlans!.toIso8601String(),
          },
        ))!,
      );

      bool? boolContainResult = await SharedPreferences.getInstance().then(
        (
          SharedPreferences? prefs,
        ) {
          return prefs?.getBool(
            'isDayPlanned',
          );
        },
      );

      expect(
        boolContainResult,
        true,
      );

      DateTime? dateTimeContainResult =
          await SharedPreferences.getInstance().then(
        (
          SharedPreferences? prefs,
        ) {
          return DateTime.parse(
            prefs?.getString(
                  'isDayPlannedDateTime',
                ) ??
                '',
          );
        },
      );

      expect(
        dateTimeContainResult,
        isNotNull,
      );

      expect(
        dateTimeContainResult,
        isNot(
          '',
        ),
      );

      expect(
        dateTimeContainResult,
        dayPlans.dayOfPlans,
      );

      List<String?>? dayplanDatesStrings =
          await SharedPreferences.getInstance().then(
        (
          SharedPreferences? prefs,
        ) {
          return prefs?.getStringList(
            'dayPlanDates',
          );
        },
      );

      expect(
        dayplanDatesStrings,
        isNotNull,
      );

      expect(
        dayplanDatesStrings,
        isNot(
          '',
        ),
      );

      if (dayplanDatesStrings != null) {
        for (String? dayPlanDateString in dayplanDatesStrings) {
          expect(
            dayPlanDateString,
            isNotNull,
          );

          expect(
            dayPlanDateString,
            isNot(
              '',
            ),
          );

          expect(
            dayPlans.dayOfPlans!.isAtSameMomentAs(
              DateTime.parse(
                dayPlanDateString!,
              ),
            ),
            true,
          );
        }
      }

      expect(
        dayPlanDates!.length,
        1,
      );
    },
  );
}
