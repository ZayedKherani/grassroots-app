class DayPlan {
  String? get id => _id!;
  String? _id;

  String? title;
  bool? isComplete = false;

  DayPlan({
    String? id,
    required this.title,
    required this.isComplete,
  }) {
    _id = id;
  }

  Map<String?, dynamic>? toJson() => {
        'id': _id,
        'dayPlanName': title,
        'isComplete': isComplete,
      };

  factory DayPlan.fromJson(
    Map<String?, dynamic>? json,
  ) {
    final DayPlan dayPlan = DayPlan(
      title: json?['dayPlanName'],
      isComplete: json?['isComplete'],
    );

    dayPlan._id = json?['id'];

    return dayPlan;
  }
}
