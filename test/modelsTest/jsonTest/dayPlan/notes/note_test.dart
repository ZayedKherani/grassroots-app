import 'package:flutter_test/flutter_test.dart';

import 'package:grassroots_app/models/json/dayPlan/notes/note.dart';

void main() {
  test(
    'JsonNote toJson',
    () {
      final JsonNote jsonNote = JsonNote(
        message: 'Test Note',
        createdAt: DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
          DateTime.now().hour,
          DateTime.now().minute,
        ),
      );

      final Map<String?, dynamic>? json = jsonNote.toJson();

      expect(
        json,
        {
          'id': null,
          'message': 'Test Note',
          'createdAt': jsonNote.createdAt!.toIso8601String(),
        },
      );
    },
  );

  test(
    'JsonNote fromJson',
    () {
      final Map<String?, dynamic> json = {
        'id': '123',
        'message': 'Test Note',
        'createdAt': DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
          DateTime.now().hour,
          DateTime.now().minute,
        ).toIso8601String(),
      };

      final JsonNote jsonNote = JsonNote.fromJson(
        json,
      );

      expect(jsonNote.id, '123');
      expect(jsonNote.message, 'Test Note');
      expect(
        jsonNote.createdAt,
        DateTime.parse(
          json['createdAt'],
        ),
      );
    },
  );
}
