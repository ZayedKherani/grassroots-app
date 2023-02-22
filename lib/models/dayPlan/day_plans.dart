import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:grassroots_app/models/dayPlan/day_plan.dart';

class DayPlans {
  String? get id => _id!;
  String? _id;

  List<DayPlan?>? dayPlansList = [];

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
    dayPlansList!.remove(
      dayPlanToDelete,
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

  Map<String?, dynamic>? toJson() {
    List<Map<String?, dynamic>?>? dayPlansListConverted = dayPlansList!
        .map(
          (
            DayPlan? dayPlanFromList,
          ) =>
              dayPlanFromList!.toJson(),
        )
        .toList();

    return {
      'id': _id,
      'dayPlansList': dayPlansListConverted,
      'dayOfPlans': _dayOfPlans!.toIso8601String(),
    };
  }

  static Future<DayPlans> fromDateOfPlans({
    required DateTime? dateOfPlans,
  }) async {
    Map<String?, dynamic>? json;

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // await SharedPreferences.getInstance().then(
    //   (
    //     SharedPreferences? prefs,
    //   ) async {
    //     json = jsonDecode(
    //       prefs!.getString(
    //         'dateOfPlans${dateOfPlans!.year}${dateOfPlans.month}${dateOfPlans.day}',
    //       )!,
    //     );
    //   },
    // );

    final jsonString = prefs.getString(
      'dateOfPlans${dateOfPlans!.year}${dateOfPlans.month}${dateOfPlans.day}',
    );

    if (jsonString != null) {
      json = jsonDecode(
        jsonString,
      );

      return DayPlans.fromJson(
        json!,
      );
    }

    return DayPlans();
  }

  factory DayPlans.fromJson(
    Map<String?, dynamic>? json,
  ) {
    List<DayPlan?>? dayPlansList = [];

    // TODO: fix dynamic dayPlanFromList to Map<String?, dynamic>? dayPlanFromList

    if (json?['dayPlansList'] != null && json?['dayPlansList'].length > 0) {
      json?['dayPlansList'].forEach(
        (
          Map<String?, dynamic>? dayPlanFromList,
        ) =>
            dayPlansList.add(
          DayPlan.fromJson(
            dayPlanFromList,
          ),
        ),
      );
    }

    final DayPlans dayPlans = DayPlans(
      dayOfPlans: DateTime.parse(
        json?['dayOfPlans'],
      ),
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
