import 'package:myapp/week06/calendar_scheduler/model/schedule.dart';
import 'package:drift/drift.dart';

import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';

// private값까지 불러올 수 있음
part 'drift_database.g.dart'; // part 파일 지정

@DriftDatabase( // 사용할 테이블 등록
  tables: [
    Schedules,
  ],
)
class LocalDatabase extends _$LocalDatabase {
  LocalDatabase() : super(_openConnection());
  Stream<List<Schedule>> watchSchedules(DateTime date) =>
  // 데이터를 조회하고 변화 감지
    (selecte(schedules)..((tbl) => tbl.date.equals(date))).watch();

  // watchSchedules() 함수 아래에 작성
  Future<int> createSchedule(SchedulesCompanion data) =>
    into(schedules).insert(data);

  // createSchedule() 함수 아래에 작성
  Future<int> removeSchedule(int id) =>
    (delete(schedules)..where((tbl) => tbl.id.equals(id))).go();

  // removeSchedule() 함수 아래에 작성
  @override
  int get schemaVersion => 1;
}
// Code Generation으로 생성할 클래스 상속