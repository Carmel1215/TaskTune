// lib/data/local/app_db.dart
import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';

part 'app_db.g.dart'; // build_runner가 생성

// ---------------------- Tables ----------------------

// 1) 할 일
class Tasks extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  BoolColumn get done => boolean().withDefault(const Constant(false))();
  DateTimeColumn get due => dateTime().nullable()();
  IntColumn get priority => integer().withDefault(const Constant(0))();
  IntColumn get estimateMinutes => integer().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get completedAt => dateTime().nullable()();
  // 인덱스 권장: due, completedAt (Drift는 선언적 인덱스 미지원이므로 쿼리에서 정렬/where로 커버)
}

// 2) 사용자 설정(개인 최대 피로도)
class UserPrefs extends Table {
  IntColumn get id => integer().withDefault(const Constant(1))();
  @override
  Set<Column> get primaryKey => {id};
  RealColumn get maxFatigue => real()(); // 0.0 ~ 1.0
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

// 3) 할 일별 피로도 캐시
class TaskFatigueScores extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get taskId =>
      integer().references(Tasks, #id, onDelete: KeyAction.cascade)();
  RealColumn get score => real()(); // 0.0 ~ 1.0
  TextColumn get modelVersion => text()();
  TextColumn get featuresHash => text()(); // 특징치 해시
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  List<String> get customConstraints => [
    'UNIQUE(task_id, features_hash)',
  ];
}

// ---------------------- Database ----------------------

@DriftDatabase(tables: [Tasks, UserPrefs, TaskFatigueScores])
class AppDb extends _$AppDb {
  AppDb() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // ---- 최소 DAO ----
  Future<int> insertTask(TasksCompanion data) => into(tasks).insert(data);

  Future<List<Task>> fetchTodayTasks(DateTime day) {
    final start = DateTime(day.year, day.month, day.day);
    final end = start.add(const Duration(days: 1));
    return (select(tasks)
          ..where((t) => t.due.isBetweenValues(start, end))
          ..orderBy([
            (t) => OrderingTerm.desc(t.priority),
            (t) => OrderingTerm.asc(t.due),
          ]))
        .get();
  }

  Future<void> toggleDone(int id, bool v) async {
    await (update(tasks)..where((t) => t.id.equals(id))).write(
      TasksCompanion(
        done: Value(v),
        completedAt: Value(v ? DateTime.now() : null),
      ),
    );
  }

  Future<TaskFatigueScore?> getTaskScore(int taskId, String hash) {
    return (select(taskFatigueScores)
          ..where(
            (t) => t.taskId.equals(taskId) & t.featuresHash.equals(hash),
          )
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .getSingleOrNull();
  }

  Future<int> cacheTaskScore({
    required int taskId,
    required double score,
    required String modelVersion,
    required String featuresHash,
  }) {
    return into(taskFatigueScores).insert(
      TaskFatigueScoresCompanion.insert(
        taskId: taskId,
        score: score,
        modelVersion: modelVersion,
        featuresHash: featuresHash,
      ),
    );
  }
}

// 파일 열기(Native SQLite)
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/tasktune.db');
    return NativeDatabase(file);
  });
}
