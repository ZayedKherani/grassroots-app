class Note {
  String? get id => _id!;
  String? _id;

  String? message;

  DateTime? createdAt;

  Note({
    String? id,
    required this.message,
    this.createdAt,
  }) {
    _id = id;

    createdAt == null
        ? DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
            DateTime.now().hour,
            DateTime.now().minute,
          )
        : DateTime(
            createdAt!.year,
            createdAt!.month,
            createdAt!.day,
            createdAt!.hour,
            createdAt!.minute,
          );
  }

  Map<String?, dynamic>? toJson() => {
        'id': _id,
        'message': message,
        'createdAt': createdAt!.toIso8601String(),
      };

  factory Note.fromJson(
    Map<String?, dynamic>? json,
  ) {
    final Note note = Note(
        message: json?['message'],
        createdAt: json?['createdAt'] == null
            ? null
            : DateTime.parse(
                json?['createdAt'],
              ));

    note._id = json?['id'];

    return note;
  }
}
