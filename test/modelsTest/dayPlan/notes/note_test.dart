import 'package:flutter_test/flutter_test.dart';

import 'package:grassroots_app/models/dayPlan/notes/note.dart';

void main() {
  test(
    'Note toJson',
    () {
      final Note note = Note(
        message: 'Test Note',
        createdAt: DateTime.now(),
      );

      final Map<String?, dynamic>? json = note.toJson();

      expect(
        json,
        {
          'id': null,
          'message': 'Test Note',
          'createdAt': note.createdAt!.toIso8601String(),
        },
      );
    },
  );

  test(
    'Note fromJson',
    () {
      final Map<String?, dynamic> json = {
        'id': '123',
        'message': 'Test Note',
        'createdAt': DateTime.now().toIso8601String(),
      };

      final Note note = Note.fromJson(
        json,
      );

      expect(note.id, '123');
      expect(note.message, 'Test Note');
      expect(note.createdAt!.toIso8601String(), json['createdAt']);
    },
  );
}
