import 'package:grassroots_app/models/json/dayPlan/notes/notes.dart';

class JsonDayPlan {
  String? get id => _id;
  String? _id;

  String? title;
  bool? isComplete = false;

  bool? isTodayExpanded = false;

  JsonNotes? notes;

  JsonDayPlan({
    String? id,
    required this.title,
    required this.isComplete,
    required this.isTodayExpanded,
    this.notes,
  }) {
    _id = id;
  }

  Map<String?, dynamic>? toJson() => {
        'id': _id,
        'title': title,
        'isComplete': isComplete,
        'isTodayExpanded': isTodayExpanded,
        'notes': notes!.toJson(),
      };

  factory JsonDayPlan.fromJson(
    Map<String?, dynamic>? json,
  ) {
    final JsonDayPlan jsonDayPlan = JsonDayPlan(
      title: json?['title'],
      isComplete: json?['isComplete'],
      isTodayExpanded: json?['isTodayExpanded'],
      notes: JsonNotes.fromJson(
        json?['notes'],
      ),
    );

    jsonDayPlan._id = json?['id'];

    return jsonDayPlan;
  }
}
