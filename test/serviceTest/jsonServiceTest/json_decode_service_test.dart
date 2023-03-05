import 'package:flutter_test/flutter_test.dart';
import 'package:grassroots_app/models/json/day_plan.dart';
import 'package:grassroots_app/models/json/day_plans.dart';
import 'package:grassroots_app/services/jsonService/json_decode_service.dart';

void main() {
  test(
    'should return null if jsonString is null',
    () async {
      expect(
        await JsonDecodeService.decode(
          null,
        ),
        null,
      );
    },
  );

  test(
    'should return null if jsonString is empty',
    () async {
      expect(
        await JsonDecodeService.decode(
          '',
        ),
        null,
      );
    },
  );

  test(
    'should return JsonDayPlans if jsonString is valid',
    () async {
      expect(
        await JsonDecodeService.decode(
          '{"id": "1", "dayOfPlans": "2021-01-01", "dayPlansList": [{"id": "1", "title": "test", "isComplete": false}]}',
        ),
        isA<JsonDayPlans>(),
      );
    },
  );

  test(
    'should return JsonDayPlans with correct id if jsonString is valid',
    () async {
      expect(
        (await JsonDecodeService.decode(
          '{"id": "1", "dayOfPlans": "2021-01-01", "dayPlansList": [{"id": "1", "title": "test", "isComplete": false}]}',
        ))!
            .id,
        '1',
      );
    },
  );

  test(
    'should return JsonDayPlans with correct dayOfPlans if jsonString is valid',
    () async {
      expect(
        (await JsonDecodeService.decode(
          '{"id": "1", "dayOfPlans": "2021-01-01", "dayPlansList": [{"id": "1", "title": "test", "isComplete": false}]}',
        ))!
            .dayOfPlans,
        DateTime.parse(
          '2021-01-01',
        ),
      );
    },
  );

  test(
    'should return JsonDayPlans with correct dayPlansList if jsonString is valid',
    () async {
      expect(
        (await JsonDecodeService.decode(
          '{"id": "1", "dayOfPlans": "2021-01-01", "dayPlansList": [{"id": "1", "title": "test", "isComplete": false}]}',
        ))!
            .dayPlansList,
        isA<List<JsonDayPlan>>(),
      );
    },
  );

  test(
    'should return JsonDayPlans with correct dayPlansList length if jsonString is valid',
    () async {
      expect(
        (await JsonDecodeService.decode(
          '{"id": "1", "dayOfPlans": "2021-01-01", "dayPlansList": [{"id": "1", "title": "test", "isComplete": false}]}',
        ))!
            .dayPlansList!
            .length,
        1,
      );
    },
  );

  test(
    'should return JsonDayPlans with correct dayPlansList[0].id if jsonString is valid',
    () async {
      expect(
        (await JsonDecodeService.decode(
          '{"id": "1", "dayOfPlans": "2021-01-01", "dayPlansList": [{"id": "1", "title": "test", "isComplete": false}]}',
        ))!
            .dayPlansList!
            .first!
            .id,
        '1',
      );
    },
  );

  test(
    'should return JsonDayPlans with correct dayPlansList[0].title if jsonString is valid',
    () async {
      expect(
        (await JsonDecodeService.decode(
          '{"id": "1", "dayOfPlans": "2021-01-01", "dayPlansList": [{"id": "1", "title": "test", "isComplete": false}]}',
        ))!
            .dayPlansList!
            .first!
            .title,
        'test',
      );
    },
  );

  test(
    'should return JsonDayPlans with correct dayPlansList[0].isComplete if jsonString is valid',
    () async {
      expect(
        (await JsonDecodeService.decode(
          '{"id": "1", "dayOfPlans": "2021-01-01", "dayPlansList": [{"id": "1", "title": "test", "isComplete": false}]}',
        ))!
            .dayPlansList!
            .first!
            .isComplete,
        false,
      );
    },
  );
}
