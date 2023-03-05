import 'package:flutter_test/flutter_test.dart';
import 'package:grassroots_app/services/jsonService/json_encode_service.dart';

void main() {
  test(
    'should return null if json is null',
    () async {
      expect(
        await JsonEncodeService.encode(
          null,
        ),
        null,
      );
    },
  );

  test(
    'should return null if json is empty',
    () async {
      expect(
        await JsonEncodeService.encode(
          {},
        ),
        null,
      );
    },
  );

  test(
    'should return jsonString if json is valid',
    () async {
      expect(
        await JsonEncodeService.encode(
          {
            'id': '1',
            'dayOfPlans': '2021-01-01',
            'dayPlansList': [
              {
                'id': '1',
                'title': 'test',
                'isComplete': false,
              },
            ],
          },
        ),
        '{"id":"1","dayOfPlans":"2021-01-01","dayPlansList":[{"id":"1","title":"test","isComplete":false}]}',
      );
    },
  );
}
