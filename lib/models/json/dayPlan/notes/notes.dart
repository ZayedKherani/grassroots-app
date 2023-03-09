import 'package:grassroots_app/models/json/dayPlan/notes/note.dart';

class JsonNotes {
  String? get id => _id!;
  String? _id;

  List<JsonNote?>? jsonNotesList;

  JsonNotes({
    String? id,
    required this.jsonNotesList,
  }) {
    _id = id;
  }

  Map<String?, dynamic>? toJson() => {
        'id': _id,
        'jsonNotesList': jsonNotesList!
            .map(
              (
                JsonNote? jsonNote,
              ) =>
                  jsonNote!.toJson(),
            )
            .toList(),
      };

  factory JsonNotes.fromJson(
    Map<String?, dynamic>? json,
  ) {
    List<JsonNote?>? jsonNotesList = [];

    if (json?['jsonNotesList'] != null && json?['jsonNotesList'].length > 0) {
      for (int i = 0; i < json?['jsonNotesList']!.length; i++) {
        jsonNotesList.add(
          JsonNote.fromJson(
            json?['jsonNotesList'][i],
          ),
        );
      }
    }

    final JsonNotes jsonNotes = JsonNotes(
      jsonNotesList: jsonNotesList,
    );

    jsonNotes._id = json?['id'];

    return jsonNotes;
  }
}
