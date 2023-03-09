import 'package:flutter_test/flutter_test.dart';
import 'package:grassroots_app/models/json/dayPlan/day_plan.dart';
import 'package:grassroots_app/models/json/dayPlan/day_plans.dart';
import 'package:grassroots_app/models/json/dayPlan/notes/note.dart';
import 'package:grassroots_app/models/json/dayPlan/notes/notes.dart';
import 'package:grassroots_app/services/jsonService/json_decode_service.dart';

void main() {
  group(
    'decodeDayPlans',
    () {
      test(
        'should return null if jsonString is null',
        () async {
          expect(
            await JsonDecodeService.decodeDayPlans(
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
            await JsonDecodeService.decodeDayPlans(
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
            await JsonDecodeService.decodeDayPlans(
              '{"id": "1", "dayOfPlans": "2021-01-01", "dayPlansList": [{"id": "1", "title": "test", "isComplete": false, "notes": {"id": "1", "notesList": [{"id": "1", "title": "test", "isComplete": false}]}}]}',
            ),
            isA<JsonDayPlans>(),
          );
        },
      );

      test(
        'should return JsonDayPlans with correct id if jsonString is valid',
        () async {
          expect(
            (await JsonDecodeService.decodeDayPlans(
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
            (await JsonDecodeService.decodeDayPlans(
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
            (await JsonDecodeService.decodeDayPlans(
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
            (await JsonDecodeService.decodeDayPlans(
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
            (await JsonDecodeService.decodeDayPlans(
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
            (await JsonDecodeService.decodeDayPlans(
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
            (await JsonDecodeService.decodeDayPlans(
              '{"id": "1", "dayOfPlans": "2021-01-01", "dayPlansList": [{"id": "1", "title": "test", "isComplete": false}]}',
            ))!
                .dayPlansList!
                .first!
                .isComplete,
            false,
          );
        },
      );
    },
  );

  group(
    'decodeNotes',
    () {
      test(
        'should return null is jsonString is null',
        () async {
          expect(
            await JsonDecodeService.decodeNotes(
              null,
            ),
            null,
          );
        },
      );

      test(
        'should return null is jsonString is empty',
        () async {
          expect(
            await JsonDecodeService.decodeNotes(
              '',
            ),
            null,
          );
        },
      );

      test(
        'should return JsonNotes if jsonString is valid',
        () async {
          expect(
            await JsonDecodeService.decodeNotes(
              '{"id": "1", "notesList": [{"id": "1", "message": "test message", "createdAt": "${DateTime(
                DateTime.now().year,
                DateTime.now().month,
                DateTime.now().day,
                DateTime.now().hour,
                DateTime.now().minute,
              ).toIso8601String()}"}]}',
            ),
            isA<JsonNotes>(),
          );
        },
      );

      test(
        'should return JsonNotes with correct id if jsonString is valid',
        () async {
          expect(
            (await JsonDecodeService.decodeNotes(
              '{"id": "1", "notesList": [{"id": "1", "message": "test message", "createdAt": "${DateTime(
                DateTime.now().year,
                DateTime.now().month,
                DateTime.now().day,
                DateTime.now().hour,
                DateTime.now().minute,
              ).toIso8601String()}"}]}',
            ))!
                .id,
            '1',
          );
        },
      );

      test(
        'should return JsonNotes with correct notesList if jsonString is valid',
        () async {
          expect(
            (await JsonDecodeService.decodeNotes(
              '{"id": "1", "notesList": [{"id": "1", "message": "test message", "createdAt": "${DateTime(
                DateTime.now().year,
                DateTime.now().month,
                DateTime.now().day,
                DateTime.now().hour,
                DateTime.now().minute,
              ).toIso8601String()}"}]}',
            ))!
                .jsonNotesList,
            isA<List<JsonNote>>(),
          );
        },
      );

      test(
        'should return JsonNotes with correct notesList length if jsonString is valid',
        () async {
          expect(
            (await JsonDecodeService.decodeNotes(
              '{"id": "1", "notesList": [{"id": "1", "message": "test message", "createdAt": "${DateTime(
                DateTime.now().year,
                DateTime.now().month,
                DateTime.now().day,
                DateTime.now().hour,
                DateTime.now().minute,
              ).toIso8601String()}"}]}',
            ))!
                .jsonNotesList!
                .length,
            1,
          );
        },
      );

      test(
        'should return JsonNotes with correct notesList[0].id if jsonString is valid',
        () async {
          expect(
            (await JsonDecodeService.decodeNotes(
              '{"id": "1", "notesList": [{"id": "1", "message": "test message", "createdAt": "${DateTime(
                DateTime.now().year,
                DateTime.now().month,
                DateTime.now().day,
                DateTime.now().hour,
                DateTime.now().minute,
              ).toIso8601String()}"}]}',
            ))!
                .jsonNotesList!
                .first!
                .id,
            '1',
          );
        },
      );

      test(
        'should return JsonNotes with correct notesList[0].message if jsonString is valid',
        () async {
          expect(
            (await JsonDecodeService.decodeNotes(
              '{"id": "1", "notesList": [{"id": "1", "message": "test message", "createdAt": "${DateTime(
                DateTime.now().year,
                DateTime.now().month,
                DateTime.now().day,
                DateTime.now().hour,
                DateTime.now().minute,
              ).toIso8601String()}"}]}',
            ))!
                .jsonNotesList!
                .first!
                .message,
            'test message',
          );
        },
      );

      test(
        'should return JsonNotes with correct notesList[0].createdAt if jsonString is valid',
        () async {
          expect(
            (await JsonDecodeService.decodeNotes(
              '{"id": "1", "notesList": [{"id": "1", "message": "test message", "createdAt": "${DateTime(
                DateTime.now().year,
                DateTime.now().month,
                DateTime.now().day,
                DateTime.now().hour,
                DateTime.now().minute,
              ).toIso8601String()}"}]}',
            ))!
                .jsonNotesList!
                .first!
                .createdAt,
            DateTime(
              DateTime.now().year,
              DateTime.now().month,
              DateTime.now().day,
              DateTime.now().hour,
              DateTime.now().minute,
            ),
          );
        },
      );
    },
  );
}
