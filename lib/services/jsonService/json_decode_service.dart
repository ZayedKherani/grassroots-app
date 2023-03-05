import 'dart:convert';

import 'package:grassroots_app/models/json/day_plan.dart';
import 'package:grassroots_app/models/json/day_plans.dart';

class JsonDecodeService {
  static Future<JsonDayPlans?>? decode(
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
}
