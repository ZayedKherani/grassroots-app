import 'package:grassroots_app/models/dayPlan/notes/note.dart';
import 'package:grassroots_app/models/dayPlan/notes/notes.dart';

class NotesService {
  static Future<void> addNote({
    required Note? noteToAdd,
    required Notes? notes,
  }) async {
    await notes!.addNote(
      noteToAdd: noteToAdd!,
    );
  }

  static Future<void> updateNote({
    required Note? noteToUpdate,
    required Notes? notes,
    String? newNoteMessage,
  }) async {
    if (newNoteMessage != null) {
      await notes!.updateNote(
        noteToUpdate: noteToUpdate!,
        newNoteMessage: newNoteMessage,
      );
    }
  }

  static Future<void> deleteNoteByNote({
    required Note? noteToDelete,
    required Notes? notes,
  }) async {
    await notes!.deleteNoteByNote(
      noteToDelete: noteToDelete!,
    );
  }
}
