class JsonNote {
  String? get id => _id!;
  String? _id;

  String? message;

  DateTime? createdAt;

  JsonNote({
    String? id,
    required this.message,
    required this.createdAt,
  }) {
    _id = id;
  }

  Map<String?, dynamic>? toJson() => {
        'id': _id,
        'message': message,
        'createdAt': createdAt!.toIso8601String(),
      };

  factory JsonNote.fromJson(
    Map<String?, dynamic>? json,
  ) {
    final JsonNote jsonNode = JsonNote(
      message: json?['message'],
      createdAt: json?['createdAt'] == null
          ? null
          : DateTime.parse(
              json?['createdAt'],
            ),
    );

    jsonNode._id = json?['id'];

    return jsonNode;
  }
}
