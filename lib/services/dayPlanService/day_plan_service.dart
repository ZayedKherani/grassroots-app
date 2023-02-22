import 'package:grassroots_app/models/dayPlan/day_plan.dart';
import 'package:grassroots_app/models/dayPlan/day_plans.dart';
import 'package:grassroots_app/universals/variables.dart';

class DayPlanService {
  static Future<DayPlans?>? getDayPlans() async {
    return globalDayPlans;
  }

  static Future<void> addDayPlan({
    DayPlan? dayPlan,
  }) async {
    await globalDayPlans.addDayPlan(
      dayPlanToAdd: dayPlan!,
    );
  }

  static Future<void> updateDayPlanTitle({
    required DayPlan? dayPlan,
    required String? newDayPlayTitle,
    DayPlans? dayPlans,
  }) async {
    if (dayPlans == null) {
      await globalDayPlans.updateDayPlan(
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

  static Future<void> deleteDayPlan({
    DayPlan? dayPlan,
    String? title,
    String? id,
    DateTime? dateOfPlans,
  }) async {
    if (dateOfPlans == null) {
      if (title != null) {
        await globalDayPlans.deteleDayPlanByTitle(
          title: title,
        );
      } else if (id != null) {
        await globalDayPlans.deleteDayPlanById(
          id: id,
        );
      } else if (dayPlan != null) {
        await globalDayPlans.deleteDayPlanByDayPlan(
          dayPlanToDelete: dayPlan,
        );
      }
    } else {
      DayPlans? dayPlans =
          await DayPlans.fromDateOfPlans(dateOfPlans: dateOfPlans);

      // if (dayPlans != null) {
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
      // }
    }
  }

  static Future<void> deleteAllDayPlans({
    DateTime? dateOfPlans,
  }) async {}

  static Future<void> toggleDayPlanCompletion({
    required DayPlan? dayPlan,
    DayPlans? dayPlans,
  }) async {
    if (dayPlans == null) {
      await globalDayPlans.updateDayPlan(
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
}
