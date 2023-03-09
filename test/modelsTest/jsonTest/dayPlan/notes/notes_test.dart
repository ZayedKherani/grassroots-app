import 'package:flutter_test/flutter_test.dart';
import 'package:grassroots_app/models/json/dayPlan/notes/note.dart';
import 'package:grassroots_app/models/json/dayPlan/notes/notes.dart';

void main() {
  group(
    'JsonNotes.toJson',
    () {
      final JsonNotes jsonNotes = JsonNotes(
        jsonNotesList: [],
      );

      test(
        'JsonNotes.toJson with No JsonNote',
        () async {
          expect(
            jsonNotes.toJson(),
            {
              'id': null,
              'jsonNotesList': [],
            },
          );
        },
      );

      test(
        'JsonNotes.toJson with One JsonNote',
        () async {
          jsonNotes.jsonNotesList?.add(
            JsonNote(
              message: 'Test Note',
              createdAt: DateTime(
                DateTime.now().year,
                DateTime.now().month,
                DateTime.now().day,
                DateTime.now().hour,
                DateTime.now().minute,
              ),
            ),
          );

          expect(
            jsonNotes.toJson(),
            {
              'id': null,
              'jsonNotesList': [
                {
                  'id': null,
                  'message': 'Test Note',
                  'createdAt': jsonNotes.jsonNotesList!.first!.createdAt!
                      .toIso8601String(),
                },
              ],
            },
          );
        },
      );

      test(
        'JsonNotes.toJson with Two JsonNotes',
        () async {
          jsonNotes.jsonNotesList?.add(
            JsonNote(
              message: 'Test Note 2',
              createdAt: DateTime(
                DateTime.now().year,
                DateTime.now().month,
                DateTime.now().day,
                DateTime.now().hour,
                DateTime.now().minute,
              ),
            ),
          );

          expect(
            jsonNotes.toJson(),
            {
              'id': null,
              'jsonNotesList': [
                {
                  'id': null,
                  'message': 'Test Note',
                  'createdAt': jsonNotes.jsonNotesList!.first!.createdAt!
                      .toIso8601String(),
                },
                {
                  'id': null,
                  'message': 'Test Note 2',
                  'createdAt': jsonNotes.jsonNotesList!.last!.createdAt!
                      .toIso8601String(),
                },
              ],
            },
          );
        },
      );
    },
  );

  group(
    'JsonNotes.fromJson',
    () {
      test(
        'JsonNotes.fromJson with No JsonNote',
        () {
          expect(
            JsonNotes.fromJson(
              {
                'id': null,
                'jsonNotesList': [],
              },
            ).toJson(),
            {
              'id': null,
              'jsonNotesList': [],
            },
          );
        },
      );

      test(
        'JsonNotes.fromJson with One JsonNote',
        () {
          final JsonNotes jsonNotes = JsonNotes.fromJson(
            {
              'id': null,
              'jsonNotesList': [
                {
                  'id': null,
                  'message': 'Test Note',
                  'createdAt': DateTime(
                    DateTime.now().year,
                    DateTime.now().month,
                    DateTime.now().day,
                    DateTime.now().hour,
                    DateTime.now().minute,
                  ).toIso8601String(),
                },
              ],
            },
          );

          expect(
            jsonNotes.toJson(),
            {
              'id': null,
              'jsonNotesList': [
                {
                  'id': null,
                  'message': 'Test Note',
                  'createdAt': jsonNotes.jsonNotesList!.first!.createdAt!
                      .toIso8601String(),
                },
              ],
            },
          );
        },
      );

      test(
        'JsonNotes.fromJson with Two JsonNotes',
        () {
          final JsonNotes jsonNotes = JsonNotes.fromJson(
            {
              'id': null,
              'jsonNotesList': [
                {
                  'id': null,
                  'message': 'Test Note',
                  'createdAt': DateTime(
                    DateTime.now().year,
                    DateTime.now().month,
                    DateTime.now().day,
                    DateTime.now().hour,
                    DateTime.now().minute,
                  ).toIso8601String(),
                },
                {
                  'id': null,
                  'message': 'Test Note 2',
                  'createdAt': DateTime(
                    DateTime.now().year,
                    DateTime.now().month,
                    DateTime.now().day,
                    DateTime.now().hour,
                    DateTime.now().minute,
                  ).toIso8601String(),
                },
              ],
            },
          );

          expect(
            jsonNotes.toJson(),
            {
              'id': null,
              'jsonNotesList': [
                {
                  'id': null,
                  'message': 'Test Note',
                  'createdAt': jsonNotes.jsonNotesList!.first!.createdAt!
                      .toIso8601String(),
                },
                {
                  'id': null,
                  'message': 'Test Note 2',
                  'createdAt': jsonNotes.jsonNotesList!.last!.createdAt!
                      .toIso8601String(),
                },
              ],
            },
          );
        },
      );
    },
  );
}
