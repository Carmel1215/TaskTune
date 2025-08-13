// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_db.dart';

// ignore_for_file: type=lint
class $TasksTable extends Tasks with TableInfo<$TasksTable, Task> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TasksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _doneMeta = const VerificationMeta('done');
  @override
  late final GeneratedColumn<bool> done = GeneratedColumn<bool>(
    'done',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("done" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _dueMeta = const VerificationMeta('due');
  @override
  late final GeneratedColumn<DateTime> due = GeneratedColumn<DateTime>(
    'due',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _priorityMeta = const VerificationMeta(
    'priority',
  );
  @override
  late final GeneratedColumn<int> priority = GeneratedColumn<int>(
    'priority',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _estimateMinutesMeta = const VerificationMeta(
    'estimateMinutes',
  );
  @override
  late final GeneratedColumn<int> estimateMinutes = GeneratedColumn<int>(
    'estimate_minutes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    done,
    due,
    priority,
    estimateMinutes,
    createdAt,
    completedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tasks';
  @override
  VerificationContext validateIntegrity(
    Insertable<Task> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('done')) {
      context.handle(
        _doneMeta,
        done.isAcceptableOrUnknown(data['done']!, _doneMeta),
      );
    }
    if (data.containsKey('due')) {
      context.handle(
        _dueMeta,
        due.isAcceptableOrUnknown(data['due']!, _dueMeta),
      );
    }
    if (data.containsKey('priority')) {
      context.handle(
        _priorityMeta,
        priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta),
      );
    }
    if (data.containsKey('estimate_minutes')) {
      context.handle(
        _estimateMinutesMeta,
        estimateMinutes.isAcceptableOrUnknown(
          data['estimate_minutes']!,
          _estimateMinutesMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Task map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Task(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      done: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}done'],
      )!,
      due: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}due'],
      ),
      priority: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}priority'],
      )!,
      estimateMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}estimate_minutes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
    );
  }

  @override
  $TasksTable createAlias(String alias) {
    return $TasksTable(attachedDatabase, alias);
  }
}

class Task extends DataClass implements Insertable<Task> {
  final int id;
  final String title;
  final bool done;
  final DateTime? due;
  final int priority;
  final int? estimateMinutes;
  final DateTime createdAt;
  final DateTime? completedAt;
  const Task({
    required this.id,
    required this.title,
    required this.done,
    this.due,
    required this.priority,
    this.estimateMinutes,
    required this.createdAt,
    this.completedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['done'] = Variable<bool>(done);
    if (!nullToAbsent || due != null) {
      map['due'] = Variable<DateTime>(due);
    }
    map['priority'] = Variable<int>(priority);
    if (!nullToAbsent || estimateMinutes != null) {
      map['estimate_minutes'] = Variable<int>(estimateMinutes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    return map;
  }

  TasksCompanion toCompanion(bool nullToAbsent) {
    return TasksCompanion(
      id: Value(id),
      title: Value(title),
      done: Value(done),
      due: due == null && nullToAbsent ? const Value.absent() : Value(due),
      priority: Value(priority),
      estimateMinutes: estimateMinutes == null && nullToAbsent
          ? const Value.absent()
          : Value(estimateMinutes),
      createdAt: Value(createdAt),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
    );
  }

  factory Task.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Task(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      done: serializer.fromJson<bool>(json['done']),
      due: serializer.fromJson<DateTime?>(json['due']),
      priority: serializer.fromJson<int>(json['priority']),
      estimateMinutes: serializer.fromJson<int?>(json['estimateMinutes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'done': serializer.toJson<bool>(done),
      'due': serializer.toJson<DateTime?>(due),
      'priority': serializer.toJson<int>(priority),
      'estimateMinutes': serializer.toJson<int?>(estimateMinutes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
    };
  }

  Task copyWith({
    int? id,
    String? title,
    bool? done,
    Value<DateTime?> due = const Value.absent(),
    int? priority,
    Value<int?> estimateMinutes = const Value.absent(),
    DateTime? createdAt,
    Value<DateTime?> completedAt = const Value.absent(),
  }) => Task(
    id: id ?? this.id,
    title: title ?? this.title,
    done: done ?? this.done,
    due: due.present ? due.value : this.due,
    priority: priority ?? this.priority,
    estimateMinutes: estimateMinutes.present
        ? estimateMinutes.value
        : this.estimateMinutes,
    createdAt: createdAt ?? this.createdAt,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
  );
  Task copyWithCompanion(TasksCompanion data) {
    return Task(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      done: data.done.present ? data.done.value : this.done,
      due: data.due.present ? data.due.value : this.due,
      priority: data.priority.present ? data.priority.value : this.priority,
      estimateMinutes: data.estimateMinutes.present
          ? data.estimateMinutes.value
          : this.estimateMinutes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Task(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('done: $done, ')
          ..write('due: $due, ')
          ..write('priority: $priority, ')
          ..write('estimateMinutes: $estimateMinutes, ')
          ..write('createdAt: $createdAt, ')
          ..write('completedAt: $completedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    done,
    due,
    priority,
    estimateMinutes,
    createdAt,
    completedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Task &&
          other.id == this.id &&
          other.title == this.title &&
          other.done == this.done &&
          other.due == this.due &&
          other.priority == this.priority &&
          other.estimateMinutes == this.estimateMinutes &&
          other.createdAt == this.createdAt &&
          other.completedAt == this.completedAt);
}

class TasksCompanion extends UpdateCompanion<Task> {
  final Value<int> id;
  final Value<String> title;
  final Value<bool> done;
  final Value<DateTime?> due;
  final Value<int> priority;
  final Value<int?> estimateMinutes;
  final Value<DateTime> createdAt;
  final Value<DateTime?> completedAt;
  const TasksCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.done = const Value.absent(),
    this.due = const Value.absent(),
    this.priority = const Value.absent(),
    this.estimateMinutes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.completedAt = const Value.absent(),
  });
  TasksCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    this.done = const Value.absent(),
    this.due = const Value.absent(),
    this.priority = const Value.absent(),
    this.estimateMinutes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.completedAt = const Value.absent(),
  }) : title = Value(title);
  static Insertable<Task> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<bool>? done,
    Expression<DateTime>? due,
    Expression<int>? priority,
    Expression<int>? estimateMinutes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? completedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (done != null) 'done': done,
      if (due != null) 'due': due,
      if (priority != null) 'priority': priority,
      if (estimateMinutes != null) 'estimate_minutes': estimateMinutes,
      if (createdAt != null) 'created_at': createdAt,
      if (completedAt != null) 'completed_at': completedAt,
    });
  }

  TasksCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<bool>? done,
    Value<DateTime?>? due,
    Value<int>? priority,
    Value<int?>? estimateMinutes,
    Value<DateTime>? createdAt,
    Value<DateTime?>? completedAt,
  }) {
    return TasksCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      done: done ?? this.done,
      due: due ?? this.due,
      priority: priority ?? this.priority,
      estimateMinutes: estimateMinutes ?? this.estimateMinutes,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (done.present) {
      map['done'] = Variable<bool>(done.value);
    }
    if (due.present) {
      map['due'] = Variable<DateTime>(due.value);
    }
    if (priority.present) {
      map['priority'] = Variable<int>(priority.value);
    }
    if (estimateMinutes.present) {
      map['estimate_minutes'] = Variable<int>(estimateMinutes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TasksCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('done: $done, ')
          ..write('due: $due, ')
          ..write('priority: $priority, ')
          ..write('estimateMinutes: $estimateMinutes, ')
          ..write('createdAt: $createdAt, ')
          ..write('completedAt: $completedAt')
          ..write(')'))
        .toString();
  }
}

class $UserPrefsTable extends UserPrefs
    with TableInfo<$UserPrefsTable, UserPref> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserPrefsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _maxFatigueMeta = const VerificationMeta(
    'maxFatigue',
  );
  @override
  late final GeneratedColumn<double> maxFatigue = GeneratedColumn<double>(
    'max_fatigue',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [id, maxFatigue, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_prefs';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserPref> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('max_fatigue')) {
      context.handle(
        _maxFatigueMeta,
        maxFatigue.isAcceptableOrUnknown(data['max_fatigue']!, _maxFatigueMeta),
      );
    } else if (isInserting) {
      context.missing(_maxFatigueMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserPref map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserPref(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      maxFatigue: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}max_fatigue'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $UserPrefsTable createAlias(String alias) {
    return $UserPrefsTable(attachedDatabase, alias);
  }
}

class UserPref extends DataClass implements Insertable<UserPref> {
  final int id;
  final double maxFatigue;
  final DateTime updatedAt;
  const UserPref({
    required this.id,
    required this.maxFatigue,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['max_fatigue'] = Variable<double>(maxFatigue);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  UserPrefsCompanion toCompanion(bool nullToAbsent) {
    return UserPrefsCompanion(
      id: Value(id),
      maxFatigue: Value(maxFatigue),
      updatedAt: Value(updatedAt),
    );
  }

  factory UserPref.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserPref(
      id: serializer.fromJson<int>(json['id']),
      maxFatigue: serializer.fromJson<double>(json['maxFatigue']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'maxFatigue': serializer.toJson<double>(maxFatigue),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  UserPref copyWith({int? id, double? maxFatigue, DateTime? updatedAt}) =>
      UserPref(
        id: id ?? this.id,
        maxFatigue: maxFatigue ?? this.maxFatigue,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  UserPref copyWithCompanion(UserPrefsCompanion data) {
    return UserPref(
      id: data.id.present ? data.id.value : this.id,
      maxFatigue: data.maxFatigue.present
          ? data.maxFatigue.value
          : this.maxFatigue,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserPref(')
          ..write('id: $id, ')
          ..write('maxFatigue: $maxFatigue, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, maxFatigue, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserPref &&
          other.id == this.id &&
          other.maxFatigue == this.maxFatigue &&
          other.updatedAt == this.updatedAt);
}

class UserPrefsCompanion extends UpdateCompanion<UserPref> {
  final Value<int> id;
  final Value<double> maxFatigue;
  final Value<DateTime> updatedAt;
  const UserPrefsCompanion({
    this.id = const Value.absent(),
    this.maxFatigue = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  UserPrefsCompanion.insert({
    this.id = const Value.absent(),
    required double maxFatigue,
    this.updatedAt = const Value.absent(),
  }) : maxFatigue = Value(maxFatigue);
  static Insertable<UserPref> custom({
    Expression<int>? id,
    Expression<double>? maxFatigue,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (maxFatigue != null) 'max_fatigue': maxFatigue,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  UserPrefsCompanion copyWith({
    Value<int>? id,
    Value<double>? maxFatigue,
    Value<DateTime>? updatedAt,
  }) {
    return UserPrefsCompanion(
      id: id ?? this.id,
      maxFatigue: maxFatigue ?? this.maxFatigue,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (maxFatigue.present) {
      map['max_fatigue'] = Variable<double>(maxFatigue.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserPrefsCompanion(')
          ..write('id: $id, ')
          ..write('maxFatigue: $maxFatigue, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $TaskFatigueScoresTable extends TaskFatigueScores
    with TableInfo<$TaskFatigueScoresTable, TaskFatigueScore> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TaskFatigueScoresTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _taskIdMeta = const VerificationMeta('taskId');
  @override
  late final GeneratedColumn<int> taskId = GeneratedColumn<int>(
    'task_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES tasks (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _scoreMeta = const VerificationMeta('score');
  @override
  late final GeneratedColumn<double> score = GeneratedColumn<double>(
    'score',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _modelVersionMeta = const VerificationMeta(
    'modelVersion',
  );
  @override
  late final GeneratedColumn<String> modelVersion = GeneratedColumn<String>(
    'model_version',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _featuresHashMeta = const VerificationMeta(
    'featuresHash',
  );
  @override
  late final GeneratedColumn<String> featuresHash = GeneratedColumn<String>(
    'features_hash',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    taskId,
    score,
    modelVersion,
    featuresHash,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'task_fatigue_scores';
  @override
  VerificationContext validateIntegrity(
    Insertable<TaskFatigueScore> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('task_id')) {
      context.handle(
        _taskIdMeta,
        taskId.isAcceptableOrUnknown(data['task_id']!, _taskIdMeta),
      );
    } else if (isInserting) {
      context.missing(_taskIdMeta);
    }
    if (data.containsKey('score')) {
      context.handle(
        _scoreMeta,
        score.isAcceptableOrUnknown(data['score']!, _scoreMeta),
      );
    } else if (isInserting) {
      context.missing(_scoreMeta);
    }
    if (data.containsKey('model_version')) {
      context.handle(
        _modelVersionMeta,
        modelVersion.isAcceptableOrUnknown(
          data['model_version']!,
          _modelVersionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_modelVersionMeta);
    }
    if (data.containsKey('features_hash')) {
      context.handle(
        _featuresHashMeta,
        featuresHash.isAcceptableOrUnknown(
          data['features_hash']!,
          _featuresHashMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_featuresHashMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TaskFatigueScore map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TaskFatigueScore(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      taskId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}task_id'],
      )!,
      score: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}score'],
      )!,
      modelVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}model_version'],
      )!,
      featuresHash: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}features_hash'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $TaskFatigueScoresTable createAlias(String alias) {
    return $TaskFatigueScoresTable(attachedDatabase, alias);
  }
}

class TaskFatigueScore extends DataClass
    implements Insertable<TaskFatigueScore> {
  final int id;
  final int taskId;
  final double score;
  final String modelVersion;
  final String featuresHash;
  final DateTime createdAt;
  const TaskFatigueScore({
    required this.id,
    required this.taskId,
    required this.score,
    required this.modelVersion,
    required this.featuresHash,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['task_id'] = Variable<int>(taskId);
    map['score'] = Variable<double>(score);
    map['model_version'] = Variable<String>(modelVersion);
    map['features_hash'] = Variable<String>(featuresHash);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  TaskFatigueScoresCompanion toCompanion(bool nullToAbsent) {
    return TaskFatigueScoresCompanion(
      id: Value(id),
      taskId: Value(taskId),
      score: Value(score),
      modelVersion: Value(modelVersion),
      featuresHash: Value(featuresHash),
      createdAt: Value(createdAt),
    );
  }

  factory TaskFatigueScore.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TaskFatigueScore(
      id: serializer.fromJson<int>(json['id']),
      taskId: serializer.fromJson<int>(json['taskId']),
      score: serializer.fromJson<double>(json['score']),
      modelVersion: serializer.fromJson<String>(json['modelVersion']),
      featuresHash: serializer.fromJson<String>(json['featuresHash']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'taskId': serializer.toJson<int>(taskId),
      'score': serializer.toJson<double>(score),
      'modelVersion': serializer.toJson<String>(modelVersion),
      'featuresHash': serializer.toJson<String>(featuresHash),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  TaskFatigueScore copyWith({
    int? id,
    int? taskId,
    double? score,
    String? modelVersion,
    String? featuresHash,
    DateTime? createdAt,
  }) => TaskFatigueScore(
    id: id ?? this.id,
    taskId: taskId ?? this.taskId,
    score: score ?? this.score,
    modelVersion: modelVersion ?? this.modelVersion,
    featuresHash: featuresHash ?? this.featuresHash,
    createdAt: createdAt ?? this.createdAt,
  );
  TaskFatigueScore copyWithCompanion(TaskFatigueScoresCompanion data) {
    return TaskFatigueScore(
      id: data.id.present ? data.id.value : this.id,
      taskId: data.taskId.present ? data.taskId.value : this.taskId,
      score: data.score.present ? data.score.value : this.score,
      modelVersion: data.modelVersion.present
          ? data.modelVersion.value
          : this.modelVersion,
      featuresHash: data.featuresHash.present
          ? data.featuresHash.value
          : this.featuresHash,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TaskFatigueScore(')
          ..write('id: $id, ')
          ..write('taskId: $taskId, ')
          ..write('score: $score, ')
          ..write('modelVersion: $modelVersion, ')
          ..write('featuresHash: $featuresHash, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, taskId, score, modelVersion, featuresHash, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TaskFatigueScore &&
          other.id == this.id &&
          other.taskId == this.taskId &&
          other.score == this.score &&
          other.modelVersion == this.modelVersion &&
          other.featuresHash == this.featuresHash &&
          other.createdAt == this.createdAt);
}

class TaskFatigueScoresCompanion extends UpdateCompanion<TaskFatigueScore> {
  final Value<int> id;
  final Value<int> taskId;
  final Value<double> score;
  final Value<String> modelVersion;
  final Value<String> featuresHash;
  final Value<DateTime> createdAt;
  const TaskFatigueScoresCompanion({
    this.id = const Value.absent(),
    this.taskId = const Value.absent(),
    this.score = const Value.absent(),
    this.modelVersion = const Value.absent(),
    this.featuresHash = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  TaskFatigueScoresCompanion.insert({
    this.id = const Value.absent(),
    required int taskId,
    required double score,
    required String modelVersion,
    required String featuresHash,
    this.createdAt = const Value.absent(),
  }) : taskId = Value(taskId),
       score = Value(score),
       modelVersion = Value(modelVersion),
       featuresHash = Value(featuresHash);
  static Insertable<TaskFatigueScore> custom({
    Expression<int>? id,
    Expression<int>? taskId,
    Expression<double>? score,
    Expression<String>? modelVersion,
    Expression<String>? featuresHash,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (taskId != null) 'task_id': taskId,
      if (score != null) 'score': score,
      if (modelVersion != null) 'model_version': modelVersion,
      if (featuresHash != null) 'features_hash': featuresHash,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  TaskFatigueScoresCompanion copyWith({
    Value<int>? id,
    Value<int>? taskId,
    Value<double>? score,
    Value<String>? modelVersion,
    Value<String>? featuresHash,
    Value<DateTime>? createdAt,
  }) {
    return TaskFatigueScoresCompanion(
      id: id ?? this.id,
      taskId: taskId ?? this.taskId,
      score: score ?? this.score,
      modelVersion: modelVersion ?? this.modelVersion,
      featuresHash: featuresHash ?? this.featuresHash,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (taskId.present) {
      map['task_id'] = Variable<int>(taskId.value);
    }
    if (score.present) {
      map['score'] = Variable<double>(score.value);
    }
    if (modelVersion.present) {
      map['model_version'] = Variable<String>(modelVersion.value);
    }
    if (featuresHash.present) {
      map['features_hash'] = Variable<String>(featuresHash.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TaskFatigueScoresCompanion(')
          ..write('id: $id, ')
          ..write('taskId: $taskId, ')
          ..write('score: $score, ')
          ..write('modelVersion: $modelVersion, ')
          ..write('featuresHash: $featuresHash, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDb extends GeneratedDatabase {
  _$AppDb(QueryExecutor e) : super(e);
  $AppDbManager get managers => $AppDbManager(this);
  late final $TasksTable tasks = $TasksTable(this);
  late final $UserPrefsTable userPrefs = $UserPrefsTable(this);
  late final $TaskFatigueScoresTable taskFatigueScores =
      $TaskFatigueScoresTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    tasks,
    userPrefs,
    taskFatigueScores,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'tasks',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('task_fatigue_scores', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$TasksTableCreateCompanionBuilder =
    TasksCompanion Function({
      Value<int> id,
      required String title,
      Value<bool> done,
      Value<DateTime?> due,
      Value<int> priority,
      Value<int?> estimateMinutes,
      Value<DateTime> createdAt,
      Value<DateTime?> completedAt,
    });
typedef $$TasksTableUpdateCompanionBuilder =
    TasksCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<bool> done,
      Value<DateTime?> due,
      Value<int> priority,
      Value<int?> estimateMinutes,
      Value<DateTime> createdAt,
      Value<DateTime?> completedAt,
    });

final class $$TasksTableReferences
    extends BaseReferences<_$AppDb, $TasksTable, Task> {
  $$TasksTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$TaskFatigueScoresTable, List<TaskFatigueScore>>
  _taskFatigueScoresRefsTable(_$AppDb db) => MultiTypedResultKey.fromTable(
    db.taskFatigueScores,
    aliasName: $_aliasNameGenerator(db.tasks.id, db.taskFatigueScores.taskId),
  );

  $$TaskFatigueScoresTableProcessedTableManager get taskFatigueScoresRefs {
    final manager = $$TaskFatigueScoresTableTableManager(
      $_db,
      $_db.taskFatigueScores,
    ).filter((f) => f.taskId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _taskFatigueScoresRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TasksTableFilterComposer extends Composer<_$AppDb, $TasksTable> {
  $$TasksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get done => $composableBuilder(
    column: $table.done,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get due => $composableBuilder(
    column: $table.due,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get estimateMinutes => $composableBuilder(
    column: $table.estimateMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> taskFatigueScoresRefs(
    Expression<bool> Function($$TaskFatigueScoresTableFilterComposer f) f,
  ) {
    final $$TaskFatigueScoresTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.taskFatigueScores,
      getReferencedColumn: (t) => t.taskId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TaskFatigueScoresTableFilterComposer(
            $db: $db,
            $table: $db.taskFatigueScores,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TasksTableOrderingComposer extends Composer<_$AppDb, $TasksTable> {
  $$TasksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get done => $composableBuilder(
    column: $table.done,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get due => $composableBuilder(
    column: $table.due,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get estimateMinutes => $composableBuilder(
    column: $table.estimateMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TasksTableAnnotationComposer extends Composer<_$AppDb, $TasksTable> {
  $$TasksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<bool> get done =>
      $composableBuilder(column: $table.done, builder: (column) => column);

  GeneratedColumn<DateTime> get due =>
      $composableBuilder(column: $table.due, builder: (column) => column);

  GeneratedColumn<int> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  GeneratedColumn<int> get estimateMinutes => $composableBuilder(
    column: $table.estimateMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  Expression<T> taskFatigueScoresRefs<T extends Object>(
    Expression<T> Function($$TaskFatigueScoresTableAnnotationComposer a) f,
  ) {
    final $$TaskFatigueScoresTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.taskFatigueScores,
          getReferencedColumn: (t) => t.taskId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$TaskFatigueScoresTableAnnotationComposer(
                $db: $db,
                $table: $db.taskFatigueScores,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$TasksTableTableManager
    extends
        RootTableManager<
          _$AppDb,
          $TasksTable,
          Task,
          $$TasksTableFilterComposer,
          $$TasksTableOrderingComposer,
          $$TasksTableAnnotationComposer,
          $$TasksTableCreateCompanionBuilder,
          $$TasksTableUpdateCompanionBuilder,
          (Task, $$TasksTableReferences),
          Task,
          PrefetchHooks Function({bool taskFatigueScoresRefs})
        > {
  $$TasksTableTableManager(_$AppDb db, $TasksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TasksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TasksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TasksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<bool> done = const Value.absent(),
                Value<DateTime?> due = const Value.absent(),
                Value<int> priority = const Value.absent(),
                Value<int?> estimateMinutes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
              }) => TasksCompanion(
                id: id,
                title: title,
                done: done,
                due: due,
                priority: priority,
                estimateMinutes: estimateMinutes,
                createdAt: createdAt,
                completedAt: completedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                Value<bool> done = const Value.absent(),
                Value<DateTime?> due = const Value.absent(),
                Value<int> priority = const Value.absent(),
                Value<int?> estimateMinutes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
              }) => TasksCompanion.insert(
                id: id,
                title: title,
                done: done,
                due: due,
                priority: priority,
                estimateMinutes: estimateMinutes,
                createdAt: createdAt,
                completedAt: completedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$TasksTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({taskFatigueScoresRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (taskFatigueScoresRefs) db.taskFatigueScores,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (taskFatigueScoresRefs)
                    await $_getPrefetchedData<
                      Task,
                      $TasksTable,
                      TaskFatigueScore
                    >(
                      currentTable: table,
                      referencedTable: $$TasksTableReferences
                          ._taskFatigueScoresRefsTable(db),
                      managerFromTypedResult: (p0) => $$TasksTableReferences(
                        db,
                        table,
                        p0,
                      ).taskFatigueScoresRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.taskId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$TasksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDb,
      $TasksTable,
      Task,
      $$TasksTableFilterComposer,
      $$TasksTableOrderingComposer,
      $$TasksTableAnnotationComposer,
      $$TasksTableCreateCompanionBuilder,
      $$TasksTableUpdateCompanionBuilder,
      (Task, $$TasksTableReferences),
      Task,
      PrefetchHooks Function({bool taskFatigueScoresRefs})
    >;
typedef $$UserPrefsTableCreateCompanionBuilder =
    UserPrefsCompanion Function({
      Value<int> id,
      required double maxFatigue,
      Value<DateTime> updatedAt,
    });
typedef $$UserPrefsTableUpdateCompanionBuilder =
    UserPrefsCompanion Function({
      Value<int> id,
      Value<double> maxFatigue,
      Value<DateTime> updatedAt,
    });

class $$UserPrefsTableFilterComposer
    extends Composer<_$AppDb, $UserPrefsTable> {
  $$UserPrefsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get maxFatigue => $composableBuilder(
    column: $table.maxFatigue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UserPrefsTableOrderingComposer
    extends Composer<_$AppDb, $UserPrefsTable> {
  $$UserPrefsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get maxFatigue => $composableBuilder(
    column: $table.maxFatigue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UserPrefsTableAnnotationComposer
    extends Composer<_$AppDb, $UserPrefsTable> {
  $$UserPrefsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get maxFatigue => $composableBuilder(
    column: $table.maxFatigue,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$UserPrefsTableTableManager
    extends
        RootTableManager<
          _$AppDb,
          $UserPrefsTable,
          UserPref,
          $$UserPrefsTableFilterComposer,
          $$UserPrefsTableOrderingComposer,
          $$UserPrefsTableAnnotationComposer,
          $$UserPrefsTableCreateCompanionBuilder,
          $$UserPrefsTableUpdateCompanionBuilder,
          (UserPref, BaseReferences<_$AppDb, $UserPrefsTable, UserPref>),
          UserPref,
          PrefetchHooks Function()
        > {
  $$UserPrefsTableTableManager(_$AppDb db, $UserPrefsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserPrefsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserPrefsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserPrefsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<double> maxFatigue = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => UserPrefsCompanion(
                id: id,
                maxFatigue: maxFatigue,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required double maxFatigue,
                Value<DateTime> updatedAt = const Value.absent(),
              }) => UserPrefsCompanion.insert(
                id: id,
                maxFatigue: maxFatigue,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UserPrefsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDb,
      $UserPrefsTable,
      UserPref,
      $$UserPrefsTableFilterComposer,
      $$UserPrefsTableOrderingComposer,
      $$UserPrefsTableAnnotationComposer,
      $$UserPrefsTableCreateCompanionBuilder,
      $$UserPrefsTableUpdateCompanionBuilder,
      (UserPref, BaseReferences<_$AppDb, $UserPrefsTable, UserPref>),
      UserPref,
      PrefetchHooks Function()
    >;
typedef $$TaskFatigueScoresTableCreateCompanionBuilder =
    TaskFatigueScoresCompanion Function({
      Value<int> id,
      required int taskId,
      required double score,
      required String modelVersion,
      required String featuresHash,
      Value<DateTime> createdAt,
    });
typedef $$TaskFatigueScoresTableUpdateCompanionBuilder =
    TaskFatigueScoresCompanion Function({
      Value<int> id,
      Value<int> taskId,
      Value<double> score,
      Value<String> modelVersion,
      Value<String> featuresHash,
      Value<DateTime> createdAt,
    });

final class $$TaskFatigueScoresTableReferences
    extends BaseReferences<_$AppDb, $TaskFatigueScoresTable, TaskFatigueScore> {
  $$TaskFatigueScoresTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $TasksTable _taskIdTable(_$AppDb db) => db.tasks.createAlias(
    $_aliasNameGenerator(db.taskFatigueScores.taskId, db.tasks.id),
  );

  $$TasksTableProcessedTableManager get taskId {
    final $_column = $_itemColumn<int>('task_id')!;

    final manager = $$TasksTableTableManager(
      $_db,
      $_db.tasks,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_taskIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TaskFatigueScoresTableFilterComposer
    extends Composer<_$AppDb, $TaskFatigueScoresTable> {
  $$TaskFatigueScoresTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get score => $composableBuilder(
    column: $table.score,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get modelVersion => $composableBuilder(
    column: $table.modelVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get featuresHash => $composableBuilder(
    column: $table.featuresHash,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$TasksTableFilterComposer get taskId {
    final $$TasksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.taskId,
      referencedTable: $db.tasks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TasksTableFilterComposer(
            $db: $db,
            $table: $db.tasks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TaskFatigueScoresTableOrderingComposer
    extends Composer<_$AppDb, $TaskFatigueScoresTable> {
  $$TaskFatigueScoresTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get score => $composableBuilder(
    column: $table.score,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get modelVersion => $composableBuilder(
    column: $table.modelVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get featuresHash => $composableBuilder(
    column: $table.featuresHash,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$TasksTableOrderingComposer get taskId {
    final $$TasksTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.taskId,
      referencedTable: $db.tasks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TasksTableOrderingComposer(
            $db: $db,
            $table: $db.tasks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TaskFatigueScoresTableAnnotationComposer
    extends Composer<_$AppDb, $TaskFatigueScoresTable> {
  $$TaskFatigueScoresTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get score =>
      $composableBuilder(column: $table.score, builder: (column) => column);

  GeneratedColumn<String> get modelVersion => $composableBuilder(
    column: $table.modelVersion,
    builder: (column) => column,
  );

  GeneratedColumn<String> get featuresHash => $composableBuilder(
    column: $table.featuresHash,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$TasksTableAnnotationComposer get taskId {
    final $$TasksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.taskId,
      referencedTable: $db.tasks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TasksTableAnnotationComposer(
            $db: $db,
            $table: $db.tasks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TaskFatigueScoresTableTableManager
    extends
        RootTableManager<
          _$AppDb,
          $TaskFatigueScoresTable,
          TaskFatigueScore,
          $$TaskFatigueScoresTableFilterComposer,
          $$TaskFatigueScoresTableOrderingComposer,
          $$TaskFatigueScoresTableAnnotationComposer,
          $$TaskFatigueScoresTableCreateCompanionBuilder,
          $$TaskFatigueScoresTableUpdateCompanionBuilder,
          (TaskFatigueScore, $$TaskFatigueScoresTableReferences),
          TaskFatigueScore,
          PrefetchHooks Function({bool taskId})
        > {
  $$TaskFatigueScoresTableTableManager(
    _$AppDb db,
    $TaskFatigueScoresTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TaskFatigueScoresTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TaskFatigueScoresTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TaskFatigueScoresTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> taskId = const Value.absent(),
                Value<double> score = const Value.absent(),
                Value<String> modelVersion = const Value.absent(),
                Value<String> featuresHash = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => TaskFatigueScoresCompanion(
                id: id,
                taskId: taskId,
                score: score,
                modelVersion: modelVersion,
                featuresHash: featuresHash,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int taskId,
                required double score,
                required String modelVersion,
                required String featuresHash,
                Value<DateTime> createdAt = const Value.absent(),
              }) => TaskFatigueScoresCompanion.insert(
                id: id,
                taskId: taskId,
                score: score,
                modelVersion: modelVersion,
                featuresHash: featuresHash,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TaskFatigueScoresTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({taskId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (taskId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.taskId,
                                referencedTable:
                                    $$TaskFatigueScoresTableReferences
                                        ._taskIdTable(db),
                                referencedColumn:
                                    $$TaskFatigueScoresTableReferences
                                        ._taskIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$TaskFatigueScoresTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDb,
      $TaskFatigueScoresTable,
      TaskFatigueScore,
      $$TaskFatigueScoresTableFilterComposer,
      $$TaskFatigueScoresTableOrderingComposer,
      $$TaskFatigueScoresTableAnnotationComposer,
      $$TaskFatigueScoresTableCreateCompanionBuilder,
      $$TaskFatigueScoresTableUpdateCompanionBuilder,
      (TaskFatigueScore, $$TaskFatigueScoresTableReferences),
      TaskFatigueScore,
      PrefetchHooks Function({bool taskId})
    >;

class $AppDbManager {
  final _$AppDb _db;
  $AppDbManager(this._db);
  $$TasksTableTableManager get tasks =>
      $$TasksTableTableManager(_db, _db.tasks);
  $$UserPrefsTableTableManager get userPrefs =>
      $$UserPrefsTableTableManager(_db, _db.userPrefs);
  $$TaskFatigueScoresTableTableManager get taskFatigueScores =>
      $$TaskFatigueScoresTableTableManager(_db, _db.taskFatigueScores);
}
