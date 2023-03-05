import 'package:shared_preferences/shared_preferences.dart';

import 'package:grassroots_app/models/dayPlan/day_plan.dart';
import 'package:grassroots_app/models/dayPlan/day_plans.dart';
import 'package:grassroots_app/services/jsonService/json_encode_service.dart';
import 'package:grassroots_app/universals/variables.dart';

class DayPlanService {
  static Future<DayPlans?>? getDayPlans({
    required bool? getFromStorage,
    DateTime? dateOfPlans,
  }) async {
    if (getFromStorage!) {
      return await DayPlans.fromDateOfPlans(
        dateOfPlans: dateOfPlans!,
      );
    }

    return globalDayPlans;
  }

  static Future<void> addDayPlan({
    DayPlan? dayPlan,
  }) async {
    await globalDayPlans!.addDayPlan(
      dayPlanToAdd: dayPlan!,
    );
  }

  static Future<void> updateDayPlanTitle({
    required DayPlan? dayPlan,
    required String? newDayPlayTitle,
    DayPlans? dayPlans,
  }) async {
    if (dayPlans == null) {
      await globalDayPlans!.updateDayPlan(
        dayPlanToUpdate: dayPlan!,
        newDayPlayTitle: newDayPlayTitle!,
      );
    } else {
      await dayPlans.updateDayPlan(
        dayPlanToUpdate: dayPlan!,
        newDayPlayTitle: newDayPlayTitle!,
      );
    }
  }

  static Future<DayPlans?> deleteDayPlan({
    DayPlan? dayPlan,
    String? title,
    String? id,
    DateTime? dateOfPlans,
  }) async {
    if (dateOfPlans == null) {
      if (title != null) {
        await globalDayPlans!.deteleDayPlanByTitle(
          title: title,
        );
      } else if (id != null) {
        await globalDayPlans!.deleteDayPlanById(
          id: id,
        );
      } else if (dayPlan != null) {
        await globalDayPlans!.deleteDayPlanByDayPlan(
          dayPlanToDelete: dayPlan,
        );
      }

      return globalDayPlans;
    } else {
      DayPlans? dayPlans = await DayPlans.fromDateOfPlans(
        dateOfPlans: dateOfPlans,
      );

      if (title != null) {
        await dayPlans.deteleDayPlanByTitle(
          title: title,
        );
      } else if (id != null) {
        await dayPlans.deleteDayPlanById(
          id: id,
        );
      } else if (dayPlan != null) {
        await dayPlans.deleteDayPlanByDayPlan(
          dayPlanToDelete: dayPlan,
        );
      }

      return dayPlans;
    }
  }

  static Future<void> toggleDayPlanCompletion({
    required DayPlan? dayPlan,
    DayPlans? dayPlans,
  }) async {
    if (dayPlans == null) {
      await globalDayPlans!.updateDayPlan(
        dayPlanToUpdate: dayPlan!,
        isComplete: !dayPlan.isComplete!,
      );
    } else {
      await dayPlans.updateDayPlan(
        dayPlanToUpdate: dayPlan!,
        isComplete: !dayPlan.isComplete!,
      );
    }
  }

  static Future<void> writeDayPlansToStorage({
    DayPlans? dayPlans,
  }) async {
    SharedPreferences? prefs = await SharedPreferences.getInstance();

    dayPlans ??= globalDayPlans;

    prefs.setString(
      'dateOfPlans${dayPlans!.dayOfPlans!.year}${dayPlans.dayOfPlans!.month}${dayPlans.dayOfPlans!.day}',
      (await JsonEncodeService.encode(
        dayPlans.toJson(),
      ))!,
    );

    dayPlanDates!.add(
      dayPlans.dayOfPlans,
    );

    prefs.setBool(
      'isDayPlanned',
      true,
    );

    prefs.setString(
      'isDayPlannedDateTime',
      DateTime(
        dayPlans.dayOfPlans!.year,
        dayPlans.dayOfPlans!.month,
        dayPlans.dayOfPlans!.day,
      ).toIso8601String(),
    );

    List<String>? dayPlanDatesStrings = [];

    for (DateTime? dayPlanDate in dayPlanDates!) {
      dayPlanDatesStrings.add(
        dayPlanDate!.toIso8601String(),
      );
    }

    prefs.setStringList(
      'dayPlanDates',
      dayPlanDatesStrings,
    );

    dayPlanDatesStrings = null;
  }
}
