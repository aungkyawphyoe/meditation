// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $UserInfoTableTable extends UserInfoTable
    with TableInfo<$UserInfoTableTable, UserInfo> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserInfoTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _rankTitleMeta = const VerificationMeta(
    'rankTitle',
  );
  @override
  late final GeneratedColumn<String> rankTitle = GeneratedColumn<String>(
    'rank_title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _streakDaysMeta = const VerificationMeta(
    'streakDays',
  );
  @override
  late final GeneratedColumn<int> streakDays = GeneratedColumn<int>(
    'streak_days',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalLifetimeBeadsMeta =
      const VerificationMeta('totalLifetimeBeads');
  @override
  late final GeneratedColumn<int> totalLifetimeBeads = GeneratedColumn<int>(
    'total_lifetime_beads',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalLifetimeRoundsMeta =
      const VerificationMeta('totalLifetimeRounds');
  @override
  late final GeneratedColumn<int> totalLifetimeRounds = GeneratedColumn<int>(
    'total_lifetime_rounds',
    aliasedName,
    false,
    type: DriftSqlType.int,
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
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    rankTitle,
    streakDays,
    totalLifetimeBeads,
    totalLifetimeRounds,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_info_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserInfo> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('rank_title')) {
      context.handle(
        _rankTitleMeta,
        rankTitle.isAcceptableOrUnknown(data['rank_title']!, _rankTitleMeta),
      );
    } else if (isInserting) {
      context.missing(_rankTitleMeta);
    }
    if (data.containsKey('streak_days')) {
      context.handle(
        _streakDaysMeta,
        streakDays.isAcceptableOrUnknown(data['streak_days']!, _streakDaysMeta),
      );
    } else if (isInserting) {
      context.missing(_streakDaysMeta);
    }
    if (data.containsKey('total_lifetime_beads')) {
      context.handle(
        _totalLifetimeBeadsMeta,
        totalLifetimeBeads.isAcceptableOrUnknown(
          data['total_lifetime_beads']!,
          _totalLifetimeBeadsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalLifetimeBeadsMeta);
    }
    if (data.containsKey('total_lifetime_rounds')) {
      context.handle(
        _totalLifetimeRoundsMeta,
        totalLifetimeRounds.isAcceptableOrUnknown(
          data['total_lifetime_rounds']!,
          _totalLifetimeRoundsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalLifetimeRoundsMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserInfo map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserInfo(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      rankTitle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rank_title'],
      )!,
      streakDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}streak_days'],
      )!,
      totalLifetimeBeads: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_lifetime_beads'],
      )!,
      totalLifetimeRounds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_lifetime_rounds'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $UserInfoTableTable createAlias(String alias) {
    return $UserInfoTableTable(attachedDatabase, alias);
  }
}

class UserInfo extends DataClass implements Insertable<UserInfo> {
  final int id;
  final String name;
  final String rankTitle;
  final int streakDays;
  final int totalLifetimeBeads;
  final int totalLifetimeRounds;
  final DateTime createdAt;
  final DateTime updatedAt;
  const UserInfo({
    required this.id,
    required this.name,
    required this.rankTitle,
    required this.streakDays,
    required this.totalLifetimeBeads,
    required this.totalLifetimeRounds,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['rank_title'] = Variable<String>(rankTitle);
    map['streak_days'] = Variable<int>(streakDays);
    map['total_lifetime_beads'] = Variable<int>(totalLifetimeBeads);
    map['total_lifetime_rounds'] = Variable<int>(totalLifetimeRounds);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  UserInfoTableCompanion toCompanion(bool nullToAbsent) {
    return UserInfoTableCompanion(
      id: Value(id),
      name: Value(name),
      rankTitle: Value(rankTitle),
      streakDays: Value(streakDays),
      totalLifetimeBeads: Value(totalLifetimeBeads),
      totalLifetimeRounds: Value(totalLifetimeRounds),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory UserInfo.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserInfo(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      rankTitle: serializer.fromJson<String>(json['rankTitle']),
      streakDays: serializer.fromJson<int>(json['streakDays']),
      totalLifetimeBeads: serializer.fromJson<int>(json['totalLifetimeBeads']),
      totalLifetimeRounds: serializer.fromJson<int>(
        json['totalLifetimeRounds'],
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'rankTitle': serializer.toJson<String>(rankTitle),
      'streakDays': serializer.toJson<int>(streakDays),
      'totalLifetimeBeads': serializer.toJson<int>(totalLifetimeBeads),
      'totalLifetimeRounds': serializer.toJson<int>(totalLifetimeRounds),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  UserInfo copyWith({
    int? id,
    String? name,
    String? rankTitle,
    int? streakDays,
    int? totalLifetimeBeads,
    int? totalLifetimeRounds,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => UserInfo(
    id: id ?? this.id,
    name: name ?? this.name,
    rankTitle: rankTitle ?? this.rankTitle,
    streakDays: streakDays ?? this.streakDays,
    totalLifetimeBeads: totalLifetimeBeads ?? this.totalLifetimeBeads,
    totalLifetimeRounds: totalLifetimeRounds ?? this.totalLifetimeRounds,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  UserInfo copyWithCompanion(UserInfoTableCompanion data) {
    return UserInfo(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      rankTitle: data.rankTitle.present ? data.rankTitle.value : this.rankTitle,
      streakDays: data.streakDays.present
          ? data.streakDays.value
          : this.streakDays,
      totalLifetimeBeads: data.totalLifetimeBeads.present
          ? data.totalLifetimeBeads.value
          : this.totalLifetimeBeads,
      totalLifetimeRounds: data.totalLifetimeRounds.present
          ? data.totalLifetimeRounds.value
          : this.totalLifetimeRounds,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserInfo(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('rankTitle: $rankTitle, ')
          ..write('streakDays: $streakDays, ')
          ..write('totalLifetimeBeads: $totalLifetimeBeads, ')
          ..write('totalLifetimeRounds: $totalLifetimeRounds, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    rankTitle,
    streakDays,
    totalLifetimeBeads,
    totalLifetimeRounds,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserInfo &&
          other.id == this.id &&
          other.name == this.name &&
          other.rankTitle == this.rankTitle &&
          other.streakDays == this.streakDays &&
          other.totalLifetimeBeads == this.totalLifetimeBeads &&
          other.totalLifetimeRounds == this.totalLifetimeRounds &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class UserInfoTableCompanion extends UpdateCompanion<UserInfo> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> rankTitle;
  final Value<int> streakDays;
  final Value<int> totalLifetimeBeads;
  final Value<int> totalLifetimeRounds;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const UserInfoTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.rankTitle = const Value.absent(),
    this.streakDays = const Value.absent(),
    this.totalLifetimeBeads = const Value.absent(),
    this.totalLifetimeRounds = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  UserInfoTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String rankTitle,
    required int streakDays,
    required int totalLifetimeBeads,
    required int totalLifetimeRounds,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : name = Value(name),
       rankTitle = Value(rankTitle),
       streakDays = Value(streakDays),
       totalLifetimeBeads = Value(totalLifetimeBeads),
       totalLifetimeRounds = Value(totalLifetimeRounds),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<UserInfo> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? rankTitle,
    Expression<int>? streakDays,
    Expression<int>? totalLifetimeBeads,
    Expression<int>? totalLifetimeRounds,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (rankTitle != null) 'rank_title': rankTitle,
      if (streakDays != null) 'streak_days': streakDays,
      if (totalLifetimeBeads != null)
        'total_lifetime_beads': totalLifetimeBeads,
      if (totalLifetimeRounds != null)
        'total_lifetime_rounds': totalLifetimeRounds,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  UserInfoTableCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? rankTitle,
    Value<int>? streakDays,
    Value<int>? totalLifetimeBeads,
    Value<int>? totalLifetimeRounds,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return UserInfoTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      rankTitle: rankTitle ?? this.rankTitle,
      streakDays: streakDays ?? this.streakDays,
      totalLifetimeBeads: totalLifetimeBeads ?? this.totalLifetimeBeads,
      totalLifetimeRounds: totalLifetimeRounds ?? this.totalLifetimeRounds,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (rankTitle.present) {
      map['rank_title'] = Variable<String>(rankTitle.value);
    }
    if (streakDays.present) {
      map['streak_days'] = Variable<int>(streakDays.value);
    }
    if (totalLifetimeBeads.present) {
      map['total_lifetime_beads'] = Variable<int>(totalLifetimeBeads.value);
    }
    if (totalLifetimeRounds.present) {
      map['total_lifetime_rounds'] = Variable<int>(totalLifetimeRounds.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserInfoTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('rankTitle: $rankTitle, ')
          ..write('streakDays: $streakDays, ')
          ..write('totalLifetimeBeads: $totalLifetimeBeads, ')
          ..write('totalLifetimeRounds: $totalLifetimeRounds, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $ChantSessionsTableTable extends ChantSessionsTable
    with TableInfo<$ChantSessionsTableTable, ChantSession> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChantSessionsTableTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _modeMeta = const VerificationMeta('mode');
  @override
  late final GeneratedColumn<String> mode = GeneratedColumn<String>(
    'mode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _beadsCountMeta = const VerificationMeta(
    'beadsCount',
  );
  @override
  late final GeneratedColumn<int> beadsCount = GeneratedColumn<int>(
    'beads_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _roundsCompletedMeta = const VerificationMeta(
    'roundsCompleted',
  );
  @override
  late final GeneratedColumn<int> roundsCompleted = GeneratedColumn<int>(
    'rounds_completed',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
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
    mode,
    beadsCount,
    roundsCompleted,
    startedAt,
    completedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'chant_sessions_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<ChantSession> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('mode')) {
      context.handle(
        _modeMeta,
        mode.isAcceptableOrUnknown(data['mode']!, _modeMeta),
      );
    } else if (isInserting) {
      context.missing(_modeMeta);
    }
    if (data.containsKey('beads_count')) {
      context.handle(
        _beadsCountMeta,
        beadsCount.isAcceptableOrUnknown(data['beads_count']!, _beadsCountMeta),
      );
    } else if (isInserting) {
      context.missing(_beadsCountMeta);
    }
    if (data.containsKey('rounds_completed')) {
      context.handle(
        _roundsCompletedMeta,
        roundsCompleted.isAcceptableOrUnknown(
          data['rounds_completed']!,
          _roundsCompletedMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_roundsCompletedMeta);
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startedAtMeta);
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
  ChantSession map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChantSession(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      mode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mode'],
      )!,
      beadsCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}beads_count'],
      )!,
      roundsCompleted: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rounds_completed'],
      )!,
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
    );
  }

  @override
  $ChantSessionsTableTable createAlias(String alias) {
    return $ChantSessionsTableTable(attachedDatabase, alias);
  }
}

class ChantSession extends DataClass implements Insertable<ChantSession> {
  final int id;
  final String mode;
  final int beadsCount;
  final int roundsCompleted;
  final DateTime startedAt;
  final DateTime? completedAt;
  const ChantSession({
    required this.id,
    required this.mode,
    required this.beadsCount,
    required this.roundsCompleted,
    required this.startedAt,
    this.completedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['mode'] = Variable<String>(mode);
    map['beads_count'] = Variable<int>(beadsCount);
    map['rounds_completed'] = Variable<int>(roundsCompleted);
    map['started_at'] = Variable<DateTime>(startedAt);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    return map;
  }

  ChantSessionsTableCompanion toCompanion(bool nullToAbsent) {
    return ChantSessionsTableCompanion(
      id: Value(id),
      mode: Value(mode),
      beadsCount: Value(beadsCount),
      roundsCompleted: Value(roundsCompleted),
      startedAt: Value(startedAt),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
    );
  }

  factory ChantSession.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChantSession(
      id: serializer.fromJson<int>(json['id']),
      mode: serializer.fromJson<String>(json['mode']),
      beadsCount: serializer.fromJson<int>(json['beadsCount']),
      roundsCompleted: serializer.fromJson<int>(json['roundsCompleted']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'mode': serializer.toJson<String>(mode),
      'beadsCount': serializer.toJson<int>(beadsCount),
      'roundsCompleted': serializer.toJson<int>(roundsCompleted),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
    };
  }

  ChantSession copyWith({
    int? id,
    String? mode,
    int? beadsCount,
    int? roundsCompleted,
    DateTime? startedAt,
    Value<DateTime?> completedAt = const Value.absent(),
  }) => ChantSession(
    id: id ?? this.id,
    mode: mode ?? this.mode,
    beadsCount: beadsCount ?? this.beadsCount,
    roundsCompleted: roundsCompleted ?? this.roundsCompleted,
    startedAt: startedAt ?? this.startedAt,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
  );
  ChantSession copyWithCompanion(ChantSessionsTableCompanion data) {
    return ChantSession(
      id: data.id.present ? data.id.value : this.id,
      mode: data.mode.present ? data.mode.value : this.mode,
      beadsCount: data.beadsCount.present
          ? data.beadsCount.value
          : this.beadsCount,
      roundsCompleted: data.roundsCompleted.present
          ? data.roundsCompleted.value
          : this.roundsCompleted,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChantSession(')
          ..write('id: $id, ')
          ..write('mode: $mode, ')
          ..write('beadsCount: $beadsCount, ')
          ..write('roundsCompleted: $roundsCompleted, ')
          ..write('startedAt: $startedAt, ')
          ..write('completedAt: $completedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    mode,
    beadsCount,
    roundsCompleted,
    startedAt,
    completedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChantSession &&
          other.id == this.id &&
          other.mode == this.mode &&
          other.beadsCount == this.beadsCount &&
          other.roundsCompleted == this.roundsCompleted &&
          other.startedAt == this.startedAt &&
          other.completedAt == this.completedAt);
}

class ChantSessionsTableCompanion extends UpdateCompanion<ChantSession> {
  final Value<int> id;
  final Value<String> mode;
  final Value<int> beadsCount;
  final Value<int> roundsCompleted;
  final Value<DateTime> startedAt;
  final Value<DateTime?> completedAt;
  const ChantSessionsTableCompanion({
    this.id = const Value.absent(),
    this.mode = const Value.absent(),
    this.beadsCount = const Value.absent(),
    this.roundsCompleted = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.completedAt = const Value.absent(),
  });
  ChantSessionsTableCompanion.insert({
    this.id = const Value.absent(),
    required String mode,
    required int beadsCount,
    required int roundsCompleted,
    required DateTime startedAt,
    this.completedAt = const Value.absent(),
  }) : mode = Value(mode),
       beadsCount = Value(beadsCount),
       roundsCompleted = Value(roundsCompleted),
       startedAt = Value(startedAt);
  static Insertable<ChantSession> custom({
    Expression<int>? id,
    Expression<String>? mode,
    Expression<int>? beadsCount,
    Expression<int>? roundsCompleted,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? completedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (mode != null) 'mode': mode,
      if (beadsCount != null) 'beads_count': beadsCount,
      if (roundsCompleted != null) 'rounds_completed': roundsCompleted,
      if (startedAt != null) 'started_at': startedAt,
      if (completedAt != null) 'completed_at': completedAt,
    });
  }

  ChantSessionsTableCompanion copyWith({
    Value<int>? id,
    Value<String>? mode,
    Value<int>? beadsCount,
    Value<int>? roundsCompleted,
    Value<DateTime>? startedAt,
    Value<DateTime?>? completedAt,
  }) {
    return ChantSessionsTableCompanion(
      id: id ?? this.id,
      mode: mode ?? this.mode,
      beadsCount: beadsCount ?? this.beadsCount,
      roundsCompleted: roundsCompleted ?? this.roundsCompleted,
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt ?? this.completedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (mode.present) {
      map['mode'] = Variable<String>(mode.value);
    }
    if (beadsCount.present) {
      map['beads_count'] = Variable<int>(beadsCount.value);
    }
    if (roundsCompleted.present) {
      map['rounds_completed'] = Variable<int>(roundsCompleted.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChantSessionsTableCompanion(')
          ..write('id: $id, ')
          ..write('mode: $mode, ')
          ..write('beadsCount: $beadsCount, ')
          ..write('roundsCompleted: $roundsCompleted, ')
          ..write('startedAt: $startedAt, ')
          ..write('completedAt: $completedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UserInfoTableTable userInfoTable = $UserInfoTableTable(this);
  late final $ChantSessionsTableTable chantSessionsTable =
      $ChantSessionsTableTable(this);
  late final UserInfoDao userInfoDao = UserInfoDao(this as AppDatabase);
  late final ChantSessionDao chantSessionDao = ChantSessionDao(
    this as AppDatabase,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    userInfoTable,
    chantSessionsTable,
  ];
}

typedef $$UserInfoTableTableCreateCompanionBuilder =
    UserInfoTableCompanion Function({
      Value<int> id,
      required String name,
      required String rankTitle,
      required int streakDays,
      required int totalLifetimeBeads,
      required int totalLifetimeRounds,
      required DateTime createdAt,
      required DateTime updatedAt,
    });
typedef $$UserInfoTableTableUpdateCompanionBuilder =
    UserInfoTableCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> rankTitle,
      Value<int> streakDays,
      Value<int> totalLifetimeBeads,
      Value<int> totalLifetimeRounds,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$UserInfoTableTableFilterComposer
    extends Composer<_$AppDatabase, $UserInfoTableTable> {
  $$UserInfoTableTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rankTitle => $composableBuilder(
    column: $table.rankTitle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get streakDays => $composableBuilder(
    column: $table.streakDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalLifetimeBeads => $composableBuilder(
    column: $table.totalLifetimeBeads,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalLifetimeRounds => $composableBuilder(
    column: $table.totalLifetimeRounds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UserInfoTableTableOrderingComposer
    extends Composer<_$AppDatabase, $UserInfoTableTable> {
  $$UserInfoTableTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rankTitle => $composableBuilder(
    column: $table.rankTitle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get streakDays => $composableBuilder(
    column: $table.streakDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalLifetimeBeads => $composableBuilder(
    column: $table.totalLifetimeBeads,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalLifetimeRounds => $composableBuilder(
    column: $table.totalLifetimeRounds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UserInfoTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserInfoTableTable> {
  $$UserInfoTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get rankTitle =>
      $composableBuilder(column: $table.rankTitle, builder: (column) => column);

  GeneratedColumn<int> get streakDays => $composableBuilder(
    column: $table.streakDays,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalLifetimeBeads => $composableBuilder(
    column: $table.totalLifetimeBeads,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalLifetimeRounds => $composableBuilder(
    column: $table.totalLifetimeRounds,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$UserInfoTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserInfoTableTable,
          UserInfo,
          $$UserInfoTableTableFilterComposer,
          $$UserInfoTableTableOrderingComposer,
          $$UserInfoTableTableAnnotationComposer,
          $$UserInfoTableTableCreateCompanionBuilder,
          $$UserInfoTableTableUpdateCompanionBuilder,
          (
            UserInfo,
            BaseReferences<_$AppDatabase, $UserInfoTableTable, UserInfo>,
          ),
          UserInfo,
          PrefetchHooks Function()
        > {
  $$UserInfoTableTableTableManager(_$AppDatabase db, $UserInfoTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserInfoTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserInfoTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserInfoTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> rankTitle = const Value.absent(),
                Value<int> streakDays = const Value.absent(),
                Value<int> totalLifetimeBeads = const Value.absent(),
                Value<int> totalLifetimeRounds = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => UserInfoTableCompanion(
                id: id,
                name: name,
                rankTitle: rankTitle,
                streakDays: streakDays,
                totalLifetimeBeads: totalLifetimeBeads,
                totalLifetimeRounds: totalLifetimeRounds,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String rankTitle,
                required int streakDays,
                required int totalLifetimeBeads,
                required int totalLifetimeRounds,
                required DateTime createdAt,
                required DateTime updatedAt,
              }) => UserInfoTableCompanion.insert(
                id: id,
                name: name,
                rankTitle: rankTitle,
                streakDays: streakDays,
                totalLifetimeBeads: totalLifetimeBeads,
                totalLifetimeRounds: totalLifetimeRounds,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UserInfoTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserInfoTableTable,
      UserInfo,
      $$UserInfoTableTableFilterComposer,
      $$UserInfoTableTableOrderingComposer,
      $$UserInfoTableTableAnnotationComposer,
      $$UserInfoTableTableCreateCompanionBuilder,
      $$UserInfoTableTableUpdateCompanionBuilder,
      (UserInfo, BaseReferences<_$AppDatabase, $UserInfoTableTable, UserInfo>),
      UserInfo,
      PrefetchHooks Function()
    >;
typedef $$ChantSessionsTableTableCreateCompanionBuilder =
    ChantSessionsTableCompanion Function({
      Value<int> id,
      required String mode,
      required int beadsCount,
      required int roundsCompleted,
      required DateTime startedAt,
      Value<DateTime?> completedAt,
    });
typedef $$ChantSessionsTableTableUpdateCompanionBuilder =
    ChantSessionsTableCompanion Function({
      Value<int> id,
      Value<String> mode,
      Value<int> beadsCount,
      Value<int> roundsCompleted,
      Value<DateTime> startedAt,
      Value<DateTime?> completedAt,
    });

class $$ChantSessionsTableTableFilterComposer
    extends Composer<_$AppDatabase, $ChantSessionsTableTable> {
  $$ChantSessionsTableTableFilterComposer({
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

  ColumnFilters<String> get mode => $composableBuilder(
    column: $table.mode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get beadsCount => $composableBuilder(
    column: $table.beadsCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get roundsCompleted => $composableBuilder(
    column: $table.roundsCompleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ChantSessionsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ChantSessionsTableTable> {
  $$ChantSessionsTableTableOrderingComposer({
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

  ColumnOrderings<String> get mode => $composableBuilder(
    column: $table.mode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get beadsCount => $composableBuilder(
    column: $table.beadsCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get roundsCompleted => $composableBuilder(
    column: $table.roundsCompleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ChantSessionsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ChantSessionsTableTable> {
  $$ChantSessionsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get mode =>
      $composableBuilder(column: $table.mode, builder: (column) => column);

  GeneratedColumn<int> get beadsCount => $composableBuilder(
    column: $table.beadsCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get roundsCompleted => $composableBuilder(
    column: $table.roundsCompleted,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );
}

class $$ChantSessionsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ChantSessionsTableTable,
          ChantSession,
          $$ChantSessionsTableTableFilterComposer,
          $$ChantSessionsTableTableOrderingComposer,
          $$ChantSessionsTableTableAnnotationComposer,
          $$ChantSessionsTableTableCreateCompanionBuilder,
          $$ChantSessionsTableTableUpdateCompanionBuilder,
          (
            ChantSession,
            BaseReferences<
              _$AppDatabase,
              $ChantSessionsTableTable,
              ChantSession
            >,
          ),
          ChantSession,
          PrefetchHooks Function()
        > {
  $$ChantSessionsTableTableTableManager(
    _$AppDatabase db,
    $ChantSessionsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ChantSessionsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ChantSessionsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ChantSessionsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> mode = const Value.absent(),
                Value<int> beadsCount = const Value.absent(),
                Value<int> roundsCompleted = const Value.absent(),
                Value<DateTime> startedAt = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
              }) => ChantSessionsTableCompanion(
                id: id,
                mode: mode,
                beadsCount: beadsCount,
                roundsCompleted: roundsCompleted,
                startedAt: startedAt,
                completedAt: completedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String mode,
                required int beadsCount,
                required int roundsCompleted,
                required DateTime startedAt,
                Value<DateTime?> completedAt = const Value.absent(),
              }) => ChantSessionsTableCompanion.insert(
                id: id,
                mode: mode,
                beadsCount: beadsCount,
                roundsCompleted: roundsCompleted,
                startedAt: startedAt,
                completedAt: completedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ChantSessionsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ChantSessionsTableTable,
      ChantSession,
      $$ChantSessionsTableTableFilterComposer,
      $$ChantSessionsTableTableOrderingComposer,
      $$ChantSessionsTableTableAnnotationComposer,
      $$ChantSessionsTableTableCreateCompanionBuilder,
      $$ChantSessionsTableTableUpdateCompanionBuilder,
      (
        ChantSession,
        BaseReferences<_$AppDatabase, $ChantSessionsTableTable, ChantSession>,
      ),
      ChantSession,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UserInfoTableTableTableManager get userInfoTable =>
      $$UserInfoTableTableTableManager(_db, _db.userInfoTable);
  $$ChantSessionsTableTableTableManager get chantSessionsTable =>
      $$ChantSessionsTableTableTableManager(_db, _db.chantSessionsTable);
}
