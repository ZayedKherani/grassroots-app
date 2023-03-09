import 'dart:convert';

import 'package:grassroots_app/models/json/dayPlan/day_plan.dart';
import 'package:grassroots_app/models/json/dayPlan/day_plans.dart';
import 'package:grassroots_app/models/json/dayPlan/notes/note.dart';
import 'package:grassroots_app/models/json/dayPlan/notes/notes.dart';

class JsonDecodeService {
  static Future<JsonDayPlans?>? decodeDayPlans(
    String? jsonString,
  ) async {
    if (jsonString == null || jsonString.isEmpty) {
      return null;
    }

    Map<String?, dynamic>? jsonDecoded = jsonDecode(
      jsonString,
    );

    List<JsonDayPlan> jsonDayPlansList = [];

    if (jsonDecoded?['dayPlansList'] != null) {
      for (int i = 0; i < jsonDecoded?['dayPlansList'].length; i++) {
        jsonDayPlansList.add(
          JsonDayPlan.fromJson(
            jsonDecoded?['dayPlansList'][i],
          ),
        );
      }
    }

    return JsonDayPlans(
      id: jsonDecoded?['id'],
      dayPlansList: jsonDayPlansList,
      dayOfPlans: DateTime.parse(
        jsonDecoded?['dayOfPlans'],
      ),
    );
  }

  static Future<JsonNotes?>? decodeNotes(
    String? jsonString,
  ) async {
    if (jsonString == null || jsonString.isEmpty) {
      return null;
    }

    Map<String?, dynamic>? jsonDecoded = jsonDecode(
      jsonString,
    );

    List<JsonNote> jsonNotesList = [];

    if (jsonDecoded?['notesList'] != null) {
      for (int i = 0; i < jsonDecoded?['notesList'].length; i++) {
        jsonNotesList.add(
          JsonNote.fromJson(
            jsonDecoded?['notesList'][i],
          ),
        );
      }
    }

    return JsonNotes(
      id: jsonDecoded?['id'],
      jsonNotesList: jsonNotesList,
    );
  }
}
