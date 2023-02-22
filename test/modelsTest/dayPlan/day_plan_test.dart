import 'package:flutter_test/flutter_test.dart';

import 'package:grassroots_app/models/dayPlan/day_plan.dart';

void main() {
  test(
    'DayPlan toJson',
    () {
      final DayPlan dayPlan = DayPlan(
        title: 'Test Day Plan',
        isComplete: false,
      );

      final Map<String?, dynamic>? json = dayPlan.toJson();

      expect(
        json,
        {
          'id': null,
          'dayPlanName': 'Test Day Plan',
          'isComplete': false,
        },
      );
    },
  );

  test(
    'DayPlan fromJson',
    () {
      final Map<String?, dynamic> json = {
        'id': '123',
        'dayPlanName': 'Test Day Plan',
        'isComplete': false,
      };

      final DayPlan dayPlan = DayPlan.fromJson(
        json,
      );

      expect(dayPlan.id, '123');
      expect(dayPlan.title, 'Test Day Plan');
      expect(dayPlan.isComplete, false);
    },
  );
}
