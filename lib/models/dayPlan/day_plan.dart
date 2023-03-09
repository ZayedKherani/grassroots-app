import 'package:grassroots_app/models/dayPlan/notes/notes.dart';

class DayPlan {
  String get id => _id!;
  String? _id;

  String? title;
  bool? isComplete = false;

  bool? isTodayExpanded = false;

  Notes? notes;

  DayPlan({
    String? id,
    required this.title,
    required this.isComplete,
    required this.isTodayExpanded,
    this.notes,
  }) {
    _id = id;

    notes ??= Notes();
  }

  Map<String?, dynamic>? toJson() => {
        'id': _id,
        'title': title,
        'isComplete': isComplete,
        'isTodayExpanded': isTodayExpanded,
        'notes': notes!.toJson(),
      };

  factory DayPlan.fromJson(
    Map<String?, dynamic>? json,
  ) {
    final DayPlan dayPlan = DayPlan(
      title: json?['title'],
      isComplete: json?['isComplete'],
      isTodayExpanded: json?['isTodayExpanded'],
      notes: Notes.fromJsonNotesJson(
        json?['notes'],
      ),
    );

    dayPlan._id = json?['id'];

    return dayPlan;
  }
}
