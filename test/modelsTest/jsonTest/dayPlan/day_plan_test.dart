import 'package:flutter_test/flutter_test.dart';
import 'package:grassroots_app/models/json/dayPlan/notes/notes.dart';

import 'package:grassroots_app/models/json/dayPlan/day_plan.dart';

void main() {
  test(
    'JsonDayPlan toJson',
    () async {
      final JsonDayPlan jsonDayPlan = JsonDayPlan(
        title: 'Test Day Plan',
        isComplete: false,
        isTodayExpanded: false,
        notes: JsonNotes(
          jsonNotesList: [],
        ),
      );

      final Map<String?, dynamic>? json = jsonDayPlan.toJson();

      expect(
        json,
        {
          'id': null,
          'title': 'Test Day Plan',
          'isComplete': false,
          'isTodayExpanded': false,
          'notes': jsonDayPlan.notes!.toJson(),
        },
      );
    },
  );

  test(
    'JsonDayPlan fromJson',
    () async {
      final Map<String?, dynamic> json = {
        'id': '123',
        'title': 'Test Day Plan',
        'isComplete': false,
      };

      final JsonDayPlan jsonDayPlan = JsonDayPlan.fromJson(
        json,
      );

      expect(jsonDayPlan.id, '123');
      expect(jsonDayPlan.title, 'Test Day Plan');
      expect(jsonDayPlan.isComplete, false);
    },
  );
}
