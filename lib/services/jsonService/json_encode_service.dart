import 'dart:convert';

class JsonEncodeService {
  static Future<String?>? encodeDayPlans(
    Map<String?, dynamic>? json,
  ) async {
    if (json == null || json.isEmpty) {
      return null;
    }

    return jsonEncode(
      json,
    );
  }

  static Future<String?>? encodeNotes(
    Map<String?, dynamic>? json,
  ) async {
    if (json == null || json.isEmpty) {
      return null;
    }

    return jsonEncode(
      json,
    );
  }
}
