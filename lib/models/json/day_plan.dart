class JsonDayPlan {
  String? get id => _id;
  String? _id;

  String? title;
  bool? isComplete = false;

  JsonDayPlan({
    String? id,
    required this.title,
    required this.isComplete,
  }) {
    _id = id;
  }

  Map<String?, dynamic>? toJson() => {
        'id': _id,
        'title': title,
        'isComplete': isComplete,
      };

  factory JsonDayPlan.fromJson(
    Map<String?, dynamic>? json,
  ) {
    final JsonDayPlan jsonDayPlan = JsonDayPlan(
      title: json?['title'],
      isComplete: json?['isComplete'],
    );

    jsonDayPlan._id = json?['id'];

    return jsonDayPlan;
  }
}
