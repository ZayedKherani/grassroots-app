import 'package:flutter_test/flutter_test.dart';

import 'package:grassroots_app/models/dayPlan/notes/note.dart';
import 'package:grassroots_app/models/dayPlan/notes/notes.dart';
import 'package:grassroots_app/services/dayPlanService/notesService/note_service.dart';

void main() {
  test(
    'NoteService.addNote',
    () {
      final Notes notes = Notes();

      final Note note = Note(
        message: 'Test Note',
        createdAt: DateTime.now(),
      );

      NotesService.addNote(
        noteToAdd: note,
        notes: notes,
      );

      expect(
        notes.notesList!.length,
        1,
      );
    },
  );

  test(
    'NoteService.updateNote',
    () {
      final Notes notes = Notes();

      final Note note = Note(
        message: 'Test Note',
        createdAt: DateTime.now(),
      );

      NotesService.addNote(
        noteToAdd: note,
        notes: notes,
      );

      final Note noteToUpdate = notes.notesList!.first!;

      NotesService.updateNote(
        noteToUpdate: noteToUpdate,
        notes: notes,
        newNoteMessage: 'New Note Message',
      );

      expect(
        noteToUpdate.message,
        'New Note Message',
      );
    },
  );

  test(
    'NoteService.deleteNoteByNote',
    () {
      final Notes notes = Notes();

      final Note note = Note(
        message: 'Test Note',
        createdAt: DateTime.now(),
      );

      NotesService.addNote(
        noteToAdd: note,
        notes: notes,
      );

      final Note noteToDelete = notes.notesList!.first!;

      NotesService.deleteNoteByNote(
        noteToDelete: noteToDelete,
        notes: notes,
      );

      expect(
        notes.notesList!.length,
        0,
      );
    },
  );
}
