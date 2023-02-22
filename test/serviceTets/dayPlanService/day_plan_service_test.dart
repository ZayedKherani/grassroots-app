import 'package:flutter_test/flutter_test.dart';

import 'package:grassroots_app/models/dayPlan/day_plan.dart';
import 'package:grassroots_app/models/dayPlan/day_plans.dart';
import 'package:grassroots_app/services/dayPlanService/day_plan_service.dart';

void main() {
  test(
    'DayPlanService().getDayPlans',
    () async {
      expect(
        await DayPlanService.getDayPlans(),
        isA<DayPlans>(),
      );
    },
  );

  test(
    'DayPlanService().addDayPlan',
    () async {
      DayPlans? dayPlans = await DayPlanService.getDayPlans();

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
}
