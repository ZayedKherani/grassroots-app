import 'package:shared_preferences/shared_preferences.dart';

import 'package:grassroots_app/models/json/day_plan.dart';
import 'package:grassroots_app/models/json/day_plans.dart';
import 'package:grassroots_app/services/jsonService/json_decode_service.dart';
import 'package:grassroots_app/models/dayPlan/day_plan.dart';

class DayPlans {
  String? get id => _id!;
  String? _id;

  List<DayPlan?>? dayPlansList = [];

  DateTime? get dayOfPlans => _dayOfPlans!;
  DateTime? _dayOfPlans;

  Future<void> addDayPlan({
    required DayPlan? dayPlanToAdd,
  }) async {
    dayPlansList!.add(
      dayPlanToAdd!,
    );
  }

  Future<void> updateDayPlan({
    required DayPlan? dayPlanToUpdate,
    String? newDayPlayTitle,
    bool? isComplete,
  }) async {
    if (newDayPlayTitle != null) {
      dayPlanToUpdate!.title = newDayPlayTitle;
    }

    if (isComplete != null) {
      dayPlanToUpdate!.isComplete = isComplete;
    }
  }

  Future<void> deleteDayPlanByDayPlan({
    required DayPlan? dayPlanToDelete,
  }) async {
    dayPlansList!.removeWhere(
      (
        DayPlan? dayPlan,
      ) =>
          dayPlan!.title == dayPlanToDelete!.title &&
          dayPlan.isComplete == dayPlanToDelete.isComplete,
    );
  }

  Future<void> deteleDayPlanByTitle({
    required String? title,
  }) async {
    dayPlansList!.removeWhere(
      (
        DayPlan? dayPlan,
      ) =>
          dayPlan!.title == title,
    );
  }

  Future<void> deleteDayPlanById({
    required String? id,
  }) async {
    dayPlansList!.removeWhere(
      (
        DayPlan? dayPlan,
      ) =>
          dayPlan!.id == id,
    );
  }

  DayPlans({
    String? id,
    DateTime? dayOfPlans,
  }) {
    _id = id;
    _dayOfPlans = dayOfPlans == null
        ? DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
          )
        : DateTime(
            dayOfPlans.year,
            dayOfPlans.month,
            dayOfPlans.day,
          );
  }

  Map<String?, dynamic>? toJson() => {
        'id': _id,
        'dayPlansList': dayPlansList!
            .map(
              (
                DayPlan? dayPlanFromList,
              ) =>
                  dayPlanFromList!.toJson(),
            )
            .toList(),
        'dayOfPlans': _dayOfPlans!.toIso8601String(),
      };

  static Future<DayPlans> fromDateOfPlans({
    required DateTime? dateOfPlans,
  }) async {
    JsonDayPlans? jsonDayPlans;

    await SharedPreferences.getInstance().then(
      (
        SharedPreferences? prefs,
      ) async {
        jsonDayPlans = await JsonDecodeService.decode(
          prefs!.getString(
            'dateOfPlans${dateOfPlans!.year}${dateOfPlans.month}${dateOfPlans.day}',
          )!,
        );
      },
    );

    return DayPlans.fromJson(
      {
        'id': jsonDayPlans?.id,
        'dayPlansList': jsonDayPlans?.dayPlansList!
            .map(
              (
                JsonDayPlan? jsonDayPlan,
              ) =>
                  jsonDayPlan!.toJson(),
            )
            .toList(),
        'dayOfPlans': jsonDayPlans?.dayOfPlans!,
      },
    );
  }

  factory DayPlans.fromJson(
    Map<String?, dynamic>? json,
  ) {
    List<DayPlan?>? dayPlansList = [];

    if (json?['dayPlansList'] != null && json?['dayPlansList'].length > 0) {
      for (int i = 0; i < json?['dayPlansList']!.length; i++) {
        if (json?['dayPlansList'][i].runtimeType == JsonDayPlan) {
          json?['dayPlansList'][i] = {
            'id': json['dayPlansList'][i].id,
            'title': json['dayPlansList'][i].title,
            'isComplete': json['dayPlansList'][i].isComplete,
          };
        }

        dayPlansList.add(
          DayPlan.fromJson(
            {
              'id': json?['dayPlansList'][i]['id'],
              'title': json?['dayPlansList'][i]['title'],
              'isComplete': json?['dayPlansList'][i]['isComplete'],
            },
          ),
        );
      }
    }

    final DayPlans dayPlans = DayPlans(
      dayOfPlans: () {
        if (json?['dayOfPlans'].runtimeType == String) {
          return DateTime.parse(
            json?['dayOfPlans'],
          );
        } else {
          return DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
          );
        }
      }(),
    );

    for (DayPlan? dayPlan in dayPlansList) {
      dayPlans.addDayPlan(
        dayPlanToAdd: dayPlan!,
      );
    }

    dayPlans._id = json?['id'];

    return dayPlans;
  }
}
