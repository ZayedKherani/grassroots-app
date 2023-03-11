import 'package:flutter_test/flutter_test.dart';

import 'package:grassroots_app/models/dayPlan/day_plan.dart';
import 'package:grassroots_app/models/dayPlan/notes/notes.dart';

void main() {
  test(
    'DayPlan toJson',
    () {
      final DayPlan dayPlan = DayPlan(
        title: 'Test Day Plan',
        isComplete: false,
        isTodayExpanded: false,
        notes: Notes(),
      );

      final Map<String?, dynamic>? json = dayPlan.toJson();

      expect(
        json,
        {
          'id': null,
          'title': 'Test Day Plan',
          'isComplete': false,
          'isTodayExpanded': false,
          'notes': dayPlan.notes!.toJson(),
        },
      );
    },
  );

  test(
    'DayPlan fromJson',
    () {
      final Map<String?, dynamic> json = {
        'id': '123',
        'title': 'Test Day Plan',
        'isComplete': false,
        'isTodayExpanded': false,
        'notes': {
          'id': null,
          'notesList': [],
        },
      };

      final DayPlan dayPlan = DayPlan.fromJson(
        json,
      );

      expect(dayPlan.id, '123');
      expect(dayPlan.title, 'Test Day Plan');
      expect(dayPlan.isComplete, false);
      expect(dayPlan.isTodayExpanded, false);
      expect(
        dayPlan.notes!.toJson(),
        {
          'id': null,
          'notesList': [],
        },
      );
    },
  );
}
