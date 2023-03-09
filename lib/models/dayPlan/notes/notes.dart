import 'package:grassroots_app/models/dayPlan/notes/note.dart';
import 'package:grassroots_app/models/json/dayPlan/notes/notes.dart';

class Notes {
  String? get id => _id!;
  String? _id;

  List<Note?>? notesList;

  Notes({
    String? id,
    this.notesList,
  }) {
    _id = id;

    notesList ??= <Note?>[];
  }

  Future<void> addNote({
    required Note? noteToAdd,
  }) async {
    notesList!.add(
      noteToAdd!,
    );
  }

  Future<void> updateNote({
    required Note? noteToUpdate,
    String? newNoteMessage,
  }) async {
    if (newNoteMessage != null) {
      noteToUpdate!.message = newNoteMessage;
    }
  }

  Future<void> deleteNoteByNote({
    required Note? noteToDelete,
  }) async {
    notesList!.removeWhere(
      (
        Note? note,
      ) =>
          note!.message == noteToDelete!.message,
    );
  }

  Map<String?, dynamic>? toJson() => {
        'id': _id,
        'notesList': notesList!
            .map(
              (
                Note? note,
              ) =>
                  note!.toJson(),
            )
            .toList(),
      };

  static Notes fromJsonNotesJson(
    Map<String?, dynamic>? json,
  ) {
    JsonNotes? jsonNotes = JsonNotes.fromJson(
      {
        'id': json?['id'],
        'jsonNotesList': json?['notesList'],
      },
    );

    return Notes.fromJson(
      jsonNotes.toJson(),
    );
  }

  factory Notes.fromJson(
    Map<String?, dynamic>? json,
  ) {
    List<Note?>? notesListJson = json?['notesList'] as List<Note?>?;

    Notes notes;

    if (notesListJson != null && notesListJson.isNotEmpty) {
      notes = Notes(
        notesList: notesListJson.map(
          (
            Note? note,
          ) {
            var a = note!.toJson();
            var b = Note.fromJson(
              a,
            );

            return b;
          },
        ).toList(),
      );
    } else {
      notes = Notes(
        notesList: <Note?>[],
      );
    }

    notes._id = json?['id'];

    return notes;
  }
}
