import 'package:grassroots_app/models/json/day_plan.dart';

class JsonDayPlans {
  String? get id => _id;
  String? _id;

  List<JsonDayPlan?>? dayPlansList = [];

  DateTime? dayOfPlans;

  JsonDayPlans({
    String? id,
    required this.dayPlansList,
    required this.dayOfPlans,
  }) {
    _id = id;
  }

  Map<String?, dynamic>? toJson() => {
        'id': _id,
        'dayPlansList': dayPlansList!
            .map(
              (
                JsonDayPlan? jsonDayPlanFromList,
              ) =>
                  jsonDayPlanFromList!.toJson(),
            )
            .toList(),
        'dayOfPlans': dayOfPlans,
      };

  factory JsonDayPlans.fromJson(
    Map<String?, dynamic>? json,
  ) {
    List<JsonDayPlan?>? jsonDayPlansList = [];

    if (json?['dayPlansList'] != null && json?['dayPlansList'].length > 0) {
      for (int i = 0; i < json?['dayPlansList']!.length; i++) {
        jsonDayPlansList.add(
          JsonDayPlan.fromJson(
            json?['dayPlansList'][i],
          ),
        );
      }
    }

    final JsonDayPlans jsonDayPlans = JsonDayPlans(
      dayPlansList: jsonDayPlansList,
      dayOfPlans: () {
        if (json?['dayOfPlans'].runtimeType == String) {
          return DateTime.parse(
            json?['dayOfPlans'],
          );
        } else {
          return DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
          );
        }
      }(),
    );

    jsonDayPlans._id = json?['id'];

    return jsonDayPlans;
  }
}
