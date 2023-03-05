import 'dart:convert';

class JsonEncodeService {
  static Future<String?>? encode(
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
