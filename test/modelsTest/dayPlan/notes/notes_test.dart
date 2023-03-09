import 'package:flutter_test/flutter_test.dart';

import 'package:grassroots_app/models/dayPlan/notes/note.dart';
import 'package:grassroots_app/models/dayPlan/notes/notes.dart';

void main() {
  group(
    'Notes toJson',
    () {
      group(
        'Self Create',
        () {
          final Notes notes = Notes();

          test(
            'No Notes',
            () {
              final Map<String?, dynamic>? json = notes.toJson();

              expect(
                json,
                {
                  'id': null,
                  'notesList': [],
                },
              );
            },
          );

          test(
            'One Note',
            () {
              final Note note = Note(
                message: 'Test Note',
                createdAt: DateTime.now(),
              );

              notes.addNote(
                noteToAdd: note,
              );

              final Map<String?, dynamic>? json = notes.toJson();

              expect(
                json,
                {
                  'id': null,
                  'notesList': [
                    {
                      'id': null,
                      'message': 'Test Note',
                      'createdAt': note.createdAt!.toIso8601String(),
                    },
                  ],
                },
              );
            },
          );

          test(
            'Multiple Notes',
            () {
              final Note note2 = Note(
                message: 'Test Note 2',
                createdAt: DateTime.now(),
              );

              notes.addNote(
                noteToAdd: note2,
              );

              final Map<String?, dynamic>? json = notes.toJson();

              expect(
                json,
                {
                  'id': null,
                  'notesList': [
                    {
                      'id': null,
                      'message': 'Test Note',
                      'createdAt':
                          notes.notesList![0]!.createdAt!.toIso8601String(),
                    },
                    {
                      'id': null,
                      'message': 'Test Note 2',
                      'createdAt':
                          notes.notesList![1]!.createdAt!.toIso8601String(),
                    },
                  ],
                },
              );
            },
          );
        },
      );

      group(
        'notesList passed',
        () {
          test(
            'No Notes',
            () {
              final Notes notes = Notes(
                notesList: [],
              );

              final Map<String?, dynamic>? json = notes.toJson();

              expect(
                json,
                {
                  'id': null,
                  'notesList': [],
                },
              );
            },
          );

          test(
            'One Note',
            () {
              final Note note = Note(
                message: 'Test Note',
                createdAt: DateTime.now(),
              );

              final Notes notes = Notes(
                notesList: [note],
              );

              final Map<String?, dynamic>? json = notes.toJson();

              expect(
                json,
                {
                  'id': null,
                  'notesList': [
                    {
                      'id': null,
                      'message': 'Test Note',
                      'createdAt': note.createdAt!.toIso8601String(),
                    },
                  ],
                },
              );
            },
          );

          test(
            'Multiple Notes',
            () {
              final Note note2 = Note(
                message: 'Test Note 2',
                createdAt: DateTime.now(),
              );

              final Notes notes = Notes(
                notesList: [
                  note2,
                ],
              );

              final Map<String?, dynamic>? json = notes.toJson();

              expect(
                json,
                {
                  'id': null,
                  'notesList': [
                    {
                      'id': null,
                      'message': 'Test Note 2',
                      'createdAt':
                          notes.notesList![0]!.createdAt!.toIso8601String(),
                    },
                  ],
                },
              );
            },
          );
        },
      );
    },
  );

  group(
    'Notes fromJson',
    () {
      test(
        'null notesList',
        () {
          final Notes notes = Notes.fromJson(
            {
              'id': null,
              'notesList': null,
            },
          );

          expect(
            notes.notesList,
            [],
          );
        },
      );

      test(
        'empty notesList',
        () {
          final Notes notes = Notes.fromJson(
            {
              'id': null,
              'notesList': <Note?>[],
            },
          );

          expect(
            notes.notesList,
            [],
          );
        },
      );

      test(
        'one note',
        () {
          final Notes notes = Notes.fromJson(
            {
              'id': null,
              'notesList': <Note?>[
                Note.fromJson(
                  {
                    'id': null,
                    'message': 'Test Note',
                    'createdAt': DateTime.now().toIso8601String(),
                  },
                ),
              ],
            },
          );

          expect(
            notes.toJson(),
            {
              'id': null,
              'notesList': [
                {
                  'id': null,
                  'message': 'Test Note',
                  'createdAt':
                      notes.notesList![0]!.createdAt!.toIso8601String(),
                },
              ],
            },
          );
        },
      );

      test(
        'multiple notes',
        () {
          final Notes notes = Notes.fromJson(
            {
              'id': null,
              'notesList': <Note?>[
                Note.fromJson(
                  {
                    'id': null,
                    'message': 'Test Note',
                    'createdAt': DateTime.now().toIso8601String(),
                  },
                ),
                Note.fromJson(
                  {
                    'id': null,
                    'message': 'Test Note 2',
                    'createdAt': DateTime.now().toIso8601String(),
                  },
                ),
              ],
            },
          );

          expect(
            notes.toJson(),
            {
              'id': null,
              'notesList': [
                {
                  'id': null,
                  'message': 'Test Note',
                  'createdAt':
                      notes.notesList![0]!.createdAt!.toIso8601String(),
                },
                {
                  'id': null,
                  'message': 'Test Note 2',
                  'createdAt':
                      notes.notesList![1]!.createdAt!.toIso8601String(),
                },
              ],
            },
          );
        },
      );
    },
  );
}
