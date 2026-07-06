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
  static const VerificationMeta _defaultModeMeta = const VerificationMeta(
    'defaultMode',
  );
  @override
  late final GeneratedColumn<String> defaultMode = GeneratedColumn<String>(
    'default_mode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('standard'),
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
  static const VerificationMeta _counterRoundsMeta = const VerificationMeta(
    'counterRounds',
  );
  @override
  late final GeneratedColumn<int> counterRounds = GeneratedColumn<int>(
    'counter_rounds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
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
    defaultMode,
    streakDays,
    totalLifetimeBeads,
    totalLifetimeRounds,
    counterRounds,
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
    if (data.containsKey('default_mode')) {
      context.handle(
        _defaultModeMeta,
        defaultMode.isAcceptableOrUnknown(
          data['default_mode']!,
          _defaultModeMeta,
        ),
      );
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
    if (data.containsKey('counter_rounds')) {
      context.handle(
        _counterRoundsMeta,
        counterRounds.isAcceptableOrUnknown(
          data['counter_rounds']!,
          _counterRoundsMeta,
        ),
      );
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
      defaultMode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}default_mode'],
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
      counterRounds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}counter_rounds'],
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
  final String defaultMode;
  final int streakDays;
  final int totalLifetimeBeads;
  final int totalLifetimeRounds;
  final int counterRounds;
  final DateTime createdAt;
  final DateTime updatedAt;
  const UserInfo({
    required this.id,
    required this.name,
    required this.rankTitle,
    required this.defaultMode,
    required this.streakDays,
    required this.totalLifetimeBeads,
    required this.totalLifetimeRounds,
    required this.counterRounds,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['rank_title'] = Variable<String>(rankTitle);
    map['default_mode'] = Variable<String>(defaultMode);
    map['streak_days'] = Variable<int>(streakDays);
    map['total_lifetime_beads'] = Variable<int>(totalLifetimeBeads);
    map['total_lifetime_rounds'] = Variable<int>(totalLifetimeRounds);
    map['counter_rounds'] = Variable<int>(counterRounds);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  UserInfoTableCompanion toCompanion(bool nullToAbsent) {
    return UserInfoTableCompanion(
      id: Value(id),
      name: Value(name),
      rankTitle: Value(rankTitle),
      defaultMode: Value(defaultMode),
      streakDays: Value(streakDays),
      totalLifetimeBeads: Value(totalLifetimeBeads),
      totalLifetimeRounds: Value(totalLifetimeRounds),
      counterRounds: Value(counterRounds),
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
      defaultMode: serializer.fromJson<String>(json['defaultMode']),
      streakDays: serializer.fromJson<int>(json['streakDays']),
      totalLifetimeBeads: serializer.fromJson<int>(json['totalLifetimeBeads']),
      totalLifetimeRounds: serializer.fromJson<int>(
        json['totalLifetimeRounds'],
      ),
      counterRounds: serializer.fromJson<int>(json['counterRounds']),
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
      'defaultMode': serializer.toJson<String>(defaultMode),
      'streakDays': serializer.toJson<int>(streakDays),
      'totalLifetimeBeads': serializer.toJson<int>(totalLifetimeBeads),
      'totalLifetimeRounds': serializer.toJson<int>(totalLifetimeRounds),
      'counterRounds': serializer.toJson<int>(counterRounds),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  UserInfo copyWith({
    int? id,
    String? name,
    String? rankTitle,
    String? defaultMode,
    int? streakDays,
    int? totalLifetimeBeads,
    int? totalLifetimeRounds,
    int? counterRounds,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => UserInfo(
    id: id ?? this.id,
    name: name ?? this.name,
    rankTitle: rankTitle ?? this.rankTitle,
    defaultMode: defaultMode ?? this.defaultMode,
    streakDays: streakDays ?? this.streakDays,
    totalLifetimeBeads: totalLifetimeBeads ?? this.totalLifetimeBeads,
    totalLifetimeRounds: totalLifetimeRounds ?? this.totalLifetimeRounds,
    counterRounds: counterRounds ?? this.counterRounds,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  UserInfo copyWithCompanion(UserInfoTableCompanion data) {
    return UserInfo(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      rankTitle: data.rankTitle.present ? data.rankTitle.value : this.rankTitle,
      defaultMode: data.defaultMode.present
          ? data.defaultMode.value
          : this.defaultMode,
      streakDays: data.streakDays.present
          ? data.streakDays.value
          : this.streakDays,
      totalLifetimeBeads: data.totalLifetimeBeads.present
          ? data.totalLifetimeBeads.value
          : this.totalLifetimeBeads,
      totalLifetimeRounds: data.totalLifetimeRounds.present
          ? data.totalLifetimeRounds.value
          : this.totalLifetimeRounds,
      counterRounds: data.counterRounds.present
          ? data.counterRounds.value
          : this.counterRounds,
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
          ..write('defaultMode: $defaultMode, ')
          ..write('streakDays: $streakDays, ')
          ..write('totalLifetimeBeads: $totalLifetimeBeads, ')
          ..write('totalLifetimeRounds: $totalLifetimeRounds, ')
          ..write('counterRounds: $counterRounds, ')
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
    defaultMode,
    streakDays,
    totalLifetimeBeads,
    totalLifetimeRounds,
    counterRounds,
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
          other.defaultMode == this.defaultMode &&
          other.streakDays == this.streakDays &&
          other.totalLifetimeBeads == this.totalLifetimeBeads &&
          other.totalLifetimeRounds == this.totalLifetimeRounds &&
          other.counterRounds == this.counterRounds &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class UserInfoTableCompanion extends UpdateCompanion<UserInfo> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> rankTitle;
  final Value<String> defaultMode;
  final Value<int> streakDays;
  final Value<int> totalLifetimeBeads;
  final Value<int> totalLifetimeRounds;
  final Value<int> counterRounds;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const UserInfoTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.rankTitle = const Value.absent(),
    this.defaultMode = const Value.absent(),
    this.streakDays = const Value.absent(),
    this.totalLifetimeBeads = const Value.absent(),
    this.totalLifetimeRounds = const Value.absent(),
    this.counterRounds = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  UserInfoTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String rankTitle,
    this.defaultMode = const Value.absent(),
    required int streakDays,
    required int totalLifetimeBeads,
    required int totalLifetimeRounds,
    this.counterRounds = const Value.absent(),
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
    Expression<String>? defaultMode,
    Expression<int>? streakDays,
    Expression<int>? totalLifetimeBeads,
    Expression<int>? totalLifetimeRounds,
    Expression<int>? counterRounds,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (rankTitle != null) 'rank_title': rankTitle,
      if (defaultMode != null) 'default_mode': defaultMode,
      if (streakDays != null) 'streak_days': streakDays,
      if (totalLifetimeBeads != null)
        'total_lifetime_beads': totalLifetimeBeads,
      if (totalLifetimeRounds != null)
        'total_lifetime_rounds': totalLifetimeRounds,
      if (counterRounds != null) 'counter_rounds': counterRounds,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  UserInfoTableCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? rankTitle,
    Value<String>? defaultMode,
    Value<int>? streakDays,
    Value<int>? totalLifetimeBeads,
    Value<int>? totalLifetimeRounds,
    Value<int>? counterRounds,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return UserInfoTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      rankTitle: rankTitle ?? this.rankTitle,
      defaultMode: defaultMode ?? this.defaultMode,
      streakDays: streakDays ?? this.streakDays,
      totalLifetimeBeads: totalLifetimeBeads ?? this.totalLifetimeBeads,
      totalLifetimeRounds: totalLifetimeRounds ?? this.totalLifetimeRounds,
      counterRounds: counterRounds ?? this.counterRounds,
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
    if (defaultMode.present) {
      map['default_mode'] = Variable<String>(defaultMode.value);
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
    if (counterRounds.present) {
      map['counter_rounds'] = Variable<int>(counterRounds.value);
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
          ..write('defaultMode: $defaultMode, ')
          ..write('streakDays: $streakDays, ')
          ..write('totalLifetimeBeads: $totalLifetimeBeads, ')
          ..write('totalLifetimeRounds: $totalLifetimeRounds, ')
          ..write('counterRounds: $counterRounds, ')
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

class $GongDawDetailsTableTable extends GongDawDetailsTable
    with TableInfo<$GongDawDetailsTableTable, GongDawDetails> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GongDawDetailsTableTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _meaningMeta = const VerificationMeta(
    'meaning',
  );
  @override
  late final GeneratedColumn<String> meaning = GeneratedColumn<String>(
    'meaning',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, meaning];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'gong_daw_details_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<GongDawDetails> instance, {
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
    if (data.containsKey('meaning')) {
      context.handle(
        _meaningMeta,
        meaning.isAcceptableOrUnknown(data['meaning']!, _meaningMeta),
      );
    } else if (isInserting) {
      context.missing(_meaningMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GongDawDetails map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GongDawDetails(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      meaning: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}meaning'],
      )!,
    );
  }

  @override
  $GongDawDetailsTableTable createAlias(String alias) {
    return $GongDawDetailsTableTable(attachedDatabase, alias);
  }
}

class GongDawDetails extends DataClass implements Insertable<GongDawDetails> {
  final int id;
  final String name;
  final String meaning;
  const GongDawDetails({
    required this.id,
    required this.name,
    required this.meaning,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['meaning'] = Variable<String>(meaning);
    return map;
  }

  GongDawDetailsTableCompanion toCompanion(bool nullToAbsent) {
    return GongDawDetailsTableCompanion(
      id: Value(id),
      name: Value(name),
      meaning: Value(meaning),
    );
  }

  factory GongDawDetails.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GongDawDetails(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      meaning: serializer.fromJson<String>(json['meaning']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'meaning': serializer.toJson<String>(meaning),
    };
  }

  GongDawDetails copyWith({int? id, String? name, String? meaning}) =>
      GongDawDetails(
        id: id ?? this.id,
        name: name ?? this.name,
        meaning: meaning ?? this.meaning,
      );
  GongDawDetails copyWithCompanion(GongDawDetailsTableCompanion data) {
    return GongDawDetails(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      meaning: data.meaning.present ? data.meaning.value : this.meaning,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GongDawDetails(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('meaning: $meaning')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, meaning);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GongDawDetails &&
          other.id == this.id &&
          other.name == this.name &&
          other.meaning == this.meaning);
}

class GongDawDetailsTableCompanion extends UpdateCompanion<GongDawDetails> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> meaning;
  const GongDawDetailsTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.meaning = const Value.absent(),
  });
  GongDawDetailsTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String meaning,
  }) : name = Value(name),
       meaning = Value(meaning);
  static Insertable<GongDawDetails> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? meaning,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (meaning != null) 'meaning': meaning,
    });
  }

  GongDawDetailsTableCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? meaning,
  }) {
    return GongDawDetailsTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      meaning: meaning ?? this.meaning,
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
    if (meaning.present) {
      map['meaning'] = Variable<String>(meaning.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GongDawDetailsTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('meaning: $meaning')
          ..write(')'))
        .toString();
  }
}

class $BeadPlansTableTable extends BeadPlansTable
    with TableInfo<$BeadPlansTableTable, BeadPlan> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BeadPlansTableTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isPredefinedMeta = const VerificationMeta(
    'isPredefined',
  );
  @override
  late final GeneratedColumn<bool> isPredefined = GeneratedColumn<bool>(
    'is_predefined',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_predefined" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _beadsPerRoundMeta = const VerificationMeta(
    'beadsPerRound',
  );
  @override
  late final GeneratedColumn<int> beadsPerRound = GeneratedColumn<int>(
    'beads_per_round',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(108),
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
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    description,
    isPredefined,
    beadsPerRound,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bead_plans_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<BeadPlan> instance, {
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
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('is_predefined')) {
      context.handle(
        _isPredefinedMeta,
        isPredefined.isAcceptableOrUnknown(
          data['is_predefined']!,
          _isPredefinedMeta,
        ),
      );
    }
    if (data.containsKey('beads_per_round')) {
      context.handle(
        _beadsPerRoundMeta,
        beadsPerRound.isAcceptableOrUnknown(
          data['beads_per_round']!,
          _beadsPerRoundMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BeadPlan map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BeadPlan(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      isPredefined: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_predefined'],
      )!,
      beadsPerRound: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}beads_per_round'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $BeadPlansTableTable createAlias(String alias) {
    return $BeadPlansTableTable(attachedDatabase, alias);
  }
}

class BeadPlan extends DataClass implements Insertable<BeadPlan> {
  final int id;
  final String title;
  final String description;
  final bool isPredefined;
  final int beadsPerRound;
  final DateTime createdAt;
  const BeadPlan({
    required this.id,
    required this.title,
    required this.description,
    required this.isPredefined,
    required this.beadsPerRound,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['description'] = Variable<String>(description);
    map['is_predefined'] = Variable<bool>(isPredefined);
    map['beads_per_round'] = Variable<int>(beadsPerRound);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  BeadPlansTableCompanion toCompanion(bool nullToAbsent) {
    return BeadPlansTableCompanion(
      id: Value(id),
      title: Value(title),
      description: Value(description),
      isPredefined: Value(isPredefined),
      beadsPerRound: Value(beadsPerRound),
      createdAt: Value(createdAt),
    );
  }

  factory BeadPlan.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BeadPlan(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
      isPredefined: serializer.fromJson<bool>(json['isPredefined']),
      beadsPerRound: serializer.fromJson<int>(json['beadsPerRound']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String>(description),
      'isPredefined': serializer.toJson<bool>(isPredefined),
      'beadsPerRound': serializer.toJson<int>(beadsPerRound),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  BeadPlan copyWith({
    int? id,
    String? title,
    String? description,
    bool? isPredefined,
    int? beadsPerRound,
    DateTime? createdAt,
  }) => BeadPlan(
    id: id ?? this.id,
    title: title ?? this.title,
    description: description ?? this.description,
    isPredefined: isPredefined ?? this.isPredefined,
    beadsPerRound: beadsPerRound ?? this.beadsPerRound,
    createdAt: createdAt ?? this.createdAt,
  );
  BeadPlan copyWithCompanion(BeadPlansTableCompanion data) {
    return BeadPlan(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present
          ? data.description.value
          : this.description,
      isPredefined: data.isPredefined.present
          ? data.isPredefined.value
          : this.isPredefined,
      beadsPerRound: data.beadsPerRound.present
          ? data.beadsPerRound.value
          : this.beadsPerRound,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BeadPlan(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('isPredefined: $isPredefined, ')
          ..write('beadsPerRound: $beadsPerRound, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    description,
    isPredefined,
    beadsPerRound,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BeadPlan &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.isPredefined == this.isPredefined &&
          other.beadsPerRound == this.beadsPerRound &&
          other.createdAt == this.createdAt);
}

class BeadPlansTableCompanion extends UpdateCompanion<BeadPlan> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> description;
  final Value<bool> isPredefined;
  final Value<int> beadsPerRound;
  final Value<DateTime> createdAt;
  const BeadPlansTableCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.isPredefined = const Value.absent(),
    this.beadsPerRound = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  BeadPlansTableCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String description,
    this.isPredefined = const Value.absent(),
    this.beadsPerRound = const Value.absent(),
    required DateTime createdAt,
  }) : title = Value(title),
       description = Value(description),
       createdAt = Value(createdAt);
  static Insertable<BeadPlan> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<bool>? isPredefined,
    Expression<int>? beadsPerRound,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (isPredefined != null) 'is_predefined': isPredefined,
      if (beadsPerRound != null) 'beads_per_round': beadsPerRound,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  BeadPlansTableCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<String>? description,
    Value<bool>? isPredefined,
    Value<int>? beadsPerRound,
    Value<DateTime>? createdAt,
  }) {
    return BeadPlansTableCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isPredefined: isPredefined ?? this.isPredefined,
      beadsPerRound: beadsPerRound ?? this.beadsPerRound,
      createdAt: createdAt ?? this.createdAt,
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
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (isPredefined.present) {
      map['is_predefined'] = Variable<bool>(isPredefined.value);
    }
    if (beadsPerRound.present) {
      map['beads_per_round'] = Variable<int>(beadsPerRound.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BeadPlansTableCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('isPredefined: $isPredefined, ')
          ..write('beadsPerRound: $beadsPerRound, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $PlanDaysTableTable extends PlanDaysTable
    with TableInfo<$PlanDaysTableTable, PlanDay> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlanDaysTableTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _planIdMeta = const VerificationMeta('planId');
  @override
  late final GeneratedColumn<int> planId = GeneratedColumn<int>(
    'plan_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES bead_plans_table (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _dayNumberMeta = const VerificationMeta(
    'dayNumber',
  );
  @override
  late final GeneratedColumn<int> dayNumber = GeneratedColumn<int>(
    'day_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _gongDawIdMeta = const VerificationMeta(
    'gongDawId',
  );
  @override
  late final GeneratedColumn<int> gongDawId = GeneratedColumn<int>(
    'gong_daw_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES gong_daw_details_table (id)',
    ),
  );
  static const VerificationMeta _targetRoundsMeta = const VerificationMeta(
    'targetRounds',
  );
  @override
  late final GeneratedColumn<int> targetRounds = GeneratedColumn<int>(
    'target_rounds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _gongDawNameMeta = const VerificationMeta(
    'gongDawName',
  );
  @override
  late final GeneratedColumn<String> gongDawName = GeneratedColumn<String>(
    'gong_daw_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    planId,
    dayNumber,
    gongDawId,
    targetRounds,
    gongDawName,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'plan_days_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<PlanDay> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('plan_id')) {
      context.handle(
        _planIdMeta,
        planId.isAcceptableOrUnknown(data['plan_id']!, _planIdMeta),
      );
    } else if (isInserting) {
      context.missing(_planIdMeta);
    }
    if (data.containsKey('day_number')) {
      context.handle(
        _dayNumberMeta,
        dayNumber.isAcceptableOrUnknown(data['day_number']!, _dayNumberMeta),
      );
    } else if (isInserting) {
      context.missing(_dayNumberMeta);
    }
    if (data.containsKey('gong_daw_id')) {
      context.handle(
        _gongDawIdMeta,
        gongDawId.isAcceptableOrUnknown(data['gong_daw_id']!, _gongDawIdMeta),
      );
    } else if (isInserting) {
      context.missing(_gongDawIdMeta);
    }
    if (data.containsKey('target_rounds')) {
      context.handle(
        _targetRoundsMeta,
        targetRounds.isAcceptableOrUnknown(
          data['target_rounds']!,
          _targetRoundsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_targetRoundsMeta);
    }
    if (data.containsKey('gong_daw_name')) {
      context.handle(
        _gongDawNameMeta,
        gongDawName.isAcceptableOrUnknown(
          data['gong_daw_name']!,
          _gongDawNameMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PlanDay map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlanDay(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      planId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}plan_id'],
      )!,
      dayNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}day_number'],
      )!,
      gongDawId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}gong_daw_id'],
      )!,
      targetRounds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}target_rounds'],
      )!,
      gongDawName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}gong_daw_name'],
      ),
    );
  }

  @override
  $PlanDaysTableTable createAlias(String alias) {
    return $PlanDaysTableTable(attachedDatabase, alias);
  }
}

class PlanDay extends DataClass implements Insertable<PlanDay> {
  final int id;
  final int planId;
  final int dayNumber;
  final int gongDawId;
  final int targetRounds;
  final String? gongDawName;
  const PlanDay({
    required this.id,
    required this.planId,
    required this.dayNumber,
    required this.gongDawId,
    required this.targetRounds,
    this.gongDawName,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['plan_id'] = Variable<int>(planId);
    map['day_number'] = Variable<int>(dayNumber);
    map['gong_daw_id'] = Variable<int>(gongDawId);
    map['target_rounds'] = Variable<int>(targetRounds);
    if (!nullToAbsent || gongDawName != null) {
      map['gong_daw_name'] = Variable<String>(gongDawName);
    }
    return map;
  }

  PlanDaysTableCompanion toCompanion(bool nullToAbsent) {
    return PlanDaysTableCompanion(
      id: Value(id),
      planId: Value(planId),
      dayNumber: Value(dayNumber),
      gongDawId: Value(gongDawId),
      targetRounds: Value(targetRounds),
      gongDawName: gongDawName == null && nullToAbsent
          ? const Value.absent()
          : Value(gongDawName),
    );
  }

  factory PlanDay.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlanDay(
      id: serializer.fromJson<int>(json['id']),
      planId: serializer.fromJson<int>(json['planId']),
      dayNumber: serializer.fromJson<int>(json['dayNumber']),
      gongDawId: serializer.fromJson<int>(json['gongDawId']),
      targetRounds: serializer.fromJson<int>(json['targetRounds']),
      gongDawName: serializer.fromJson<String?>(json['gongDawName']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'planId': serializer.toJson<int>(planId),
      'dayNumber': serializer.toJson<int>(dayNumber),
      'gongDawId': serializer.toJson<int>(gongDawId),
      'targetRounds': serializer.toJson<int>(targetRounds),
      'gongDawName': serializer.toJson<String?>(gongDawName),
    };
  }

  PlanDay copyWith({
    int? id,
    int? planId,
    int? dayNumber,
    int? gongDawId,
    int? targetRounds,
    Value<String?> gongDawName = const Value.absent(),
  }) => PlanDay(
    id: id ?? this.id,
    planId: planId ?? this.planId,
    dayNumber: dayNumber ?? this.dayNumber,
    gongDawId: gongDawId ?? this.gongDawId,
    targetRounds: targetRounds ?? this.targetRounds,
    gongDawName: gongDawName.present ? gongDawName.value : this.gongDawName,
  );
  PlanDay copyWithCompanion(PlanDaysTableCompanion data) {
    return PlanDay(
      id: data.id.present ? data.id.value : this.id,
      planId: data.planId.present ? data.planId.value : this.planId,
      dayNumber: data.dayNumber.present ? data.dayNumber.value : this.dayNumber,
      gongDawId: data.gongDawId.present ? data.gongDawId.value : this.gongDawId,
      targetRounds: data.targetRounds.present
          ? data.targetRounds.value
          : this.targetRounds,
      gongDawName: data.gongDawName.present
          ? data.gongDawName.value
          : this.gongDawName,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PlanDay(')
          ..write('id: $id, ')
          ..write('planId: $planId, ')
          ..write('dayNumber: $dayNumber, ')
          ..write('gongDawId: $gongDawId, ')
          ..write('targetRounds: $targetRounds, ')
          ..write('gongDawName: $gongDawName')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, planId, dayNumber, gongDawId, targetRounds, gongDawName);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlanDay &&
          other.id == this.id &&
          other.planId == this.planId &&
          other.dayNumber == this.dayNumber &&
          other.gongDawId == this.gongDawId &&
          other.targetRounds == this.targetRounds &&
          other.gongDawName == this.gongDawName);
}

class PlanDaysTableCompanion extends UpdateCompanion<PlanDay> {
  final Value<int> id;
  final Value<int> planId;
  final Value<int> dayNumber;
  final Value<int> gongDawId;
  final Value<int> targetRounds;
  final Value<String?> gongDawName;
  const PlanDaysTableCompanion({
    this.id = const Value.absent(),
    this.planId = const Value.absent(),
    this.dayNumber = const Value.absent(),
    this.gongDawId = const Value.absent(),
    this.targetRounds = const Value.absent(),
    this.gongDawName = const Value.absent(),
  });
  PlanDaysTableCompanion.insert({
    this.id = const Value.absent(),
    required int planId,
    required int dayNumber,
    required int gongDawId,
    required int targetRounds,
    this.gongDawName = const Value.absent(),
  }) : planId = Value(planId),
       dayNumber = Value(dayNumber),
       gongDawId = Value(gongDawId),
       targetRounds = Value(targetRounds);
  static Insertable<PlanDay> custom({
    Expression<int>? id,
    Expression<int>? planId,
    Expression<int>? dayNumber,
    Expression<int>? gongDawId,
    Expression<int>? targetRounds,
    Expression<String>? gongDawName,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (planId != null) 'plan_id': planId,
      if (dayNumber != null) 'day_number': dayNumber,
      if (gongDawId != null) 'gong_daw_id': gongDawId,
      if (targetRounds != null) 'target_rounds': targetRounds,
      if (gongDawName != null) 'gong_daw_name': gongDawName,
    });
  }

  PlanDaysTableCompanion copyWith({
    Value<int>? id,
    Value<int>? planId,
    Value<int>? dayNumber,
    Value<int>? gongDawId,
    Value<int>? targetRounds,
    Value<String?>? gongDawName,
  }) {
    return PlanDaysTableCompanion(
      id: id ?? this.id,
      planId: planId ?? this.planId,
      dayNumber: dayNumber ?? this.dayNumber,
      gongDawId: gongDawId ?? this.gongDawId,
      targetRounds: targetRounds ?? this.targetRounds,
      gongDawName: gongDawName ?? this.gongDawName,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (planId.present) {
      map['plan_id'] = Variable<int>(planId.value);
    }
    if (dayNumber.present) {
      map['day_number'] = Variable<int>(dayNumber.value);
    }
    if (gongDawId.present) {
      map['gong_daw_id'] = Variable<int>(gongDawId.value);
    }
    if (targetRounds.present) {
      map['target_rounds'] = Variable<int>(targetRounds.value);
    }
    if (gongDawName.present) {
      map['gong_daw_name'] = Variable<String>(gongDawName.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlanDaysTableCompanion(')
          ..write('id: $id, ')
          ..write('planId: $planId, ')
          ..write('dayNumber: $dayNumber, ')
          ..write('gongDawId: $gongDawId, ')
          ..write('targetRounds: $targetRounds, ')
          ..write('gongDawName: $gongDawName')
          ..write(')'))
        .toString();
  }
}

class $UserPlanProgressTableTable extends UserPlanProgressTable
    with TableInfo<$UserPlanProgressTableTable, UserPlanProgress> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserPlanProgressTableTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES user_info_table (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _planIdMeta = const VerificationMeta('planId');
  @override
  late final GeneratedColumn<int> planId = GeneratedColumn<int>(
    'plan_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES bead_plans_table (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _currentDayMeta = const VerificationMeta(
    'currentDay',
  );
  @override
  late final GeneratedColumn<int> currentDay = GeneratedColumn<int>(
    'current_day',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startDateMeta = const VerificationMeta(
    'startDate',
  );
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
    'start_date',
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
    userId,
    planId,
    currentDay,
    status,
    startDate,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_plan_progress_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserPlanProgress> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('plan_id')) {
      context.handle(
        _planIdMeta,
        planId.isAcceptableOrUnknown(data['plan_id']!, _planIdMeta),
      );
    } else if (isInserting) {
      context.missing(_planIdMeta);
    }
    if (data.containsKey('current_day')) {
      context.handle(
        _currentDayMeta,
        currentDay.isAcceptableOrUnknown(data['current_day']!, _currentDayMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('start_date')) {
      context.handle(
        _startDateMeta,
        startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta),
      );
    } else if (isInserting) {
      context.missing(_startDateMeta);
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
  UserPlanProgress map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserPlanProgress(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}user_id'],
      )!,
      planId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}plan_id'],
      )!,
      currentDay: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}current_day'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      startDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_date'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $UserPlanProgressTableTable createAlias(String alias) {
    return $UserPlanProgressTableTable(attachedDatabase, alias);
  }
}

class UserPlanProgress extends DataClass
    implements Insertable<UserPlanProgress> {
  final int id;
  final int userId;
  final int planId;
  final int currentDay;
  final String status;
  final DateTime startDate;
  final DateTime updatedAt;
  const UserPlanProgress({
    required this.id,
    required this.userId,
    required this.planId,
    required this.currentDay,
    required this.status,
    required this.startDate,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<int>(userId);
    map['plan_id'] = Variable<int>(planId);
    map['current_day'] = Variable<int>(currentDay);
    map['status'] = Variable<String>(status);
    map['start_date'] = Variable<DateTime>(startDate);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  UserPlanProgressTableCompanion toCompanion(bool nullToAbsent) {
    return UserPlanProgressTableCompanion(
      id: Value(id),
      userId: Value(userId),
      planId: Value(planId),
      currentDay: Value(currentDay),
      status: Value(status),
      startDate: Value(startDate),
      updatedAt: Value(updatedAt),
    );
  }

  factory UserPlanProgress.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserPlanProgress(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<int>(json['userId']),
      planId: serializer.fromJson<int>(json['planId']),
      currentDay: serializer.fromJson<int>(json['currentDay']),
      status: serializer.fromJson<String>(json['status']),
      startDate: serializer.fromJson<DateTime>(json['startDate']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<int>(userId),
      'planId': serializer.toJson<int>(planId),
      'currentDay': serializer.toJson<int>(currentDay),
      'status': serializer.toJson<String>(status),
      'startDate': serializer.toJson<DateTime>(startDate),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  UserPlanProgress copyWith({
    int? id,
    int? userId,
    int? planId,
    int? currentDay,
    String? status,
    DateTime? startDate,
    DateTime? updatedAt,
  }) => UserPlanProgress(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    planId: planId ?? this.planId,
    currentDay: currentDay ?? this.currentDay,
    status: status ?? this.status,
    startDate: startDate ?? this.startDate,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  UserPlanProgress copyWithCompanion(UserPlanProgressTableCompanion data) {
    return UserPlanProgress(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      planId: data.planId.present ? data.planId.value : this.planId,
      currentDay: data.currentDay.present
          ? data.currentDay.value
          : this.currentDay,
      status: data.status.present ? data.status.value : this.status,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserPlanProgress(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('planId: $planId, ')
          ..write('currentDay: $currentDay, ')
          ..write('status: $status, ')
          ..write('startDate: $startDate, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, userId, planId, currentDay, status, startDate, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserPlanProgress &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.planId == this.planId &&
          other.currentDay == this.currentDay &&
          other.status == this.status &&
          other.startDate == this.startDate &&
          other.updatedAt == this.updatedAt);
}

class UserPlanProgressTableCompanion extends UpdateCompanion<UserPlanProgress> {
  final Value<int> id;
  final Value<int> userId;
  final Value<int> planId;
  final Value<int> currentDay;
  final Value<String> status;
  final Value<DateTime> startDate;
  final Value<DateTime> updatedAt;
  const UserPlanProgressTableCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.planId = const Value.absent(),
    this.currentDay = const Value.absent(),
    this.status = const Value.absent(),
    this.startDate = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  UserPlanProgressTableCompanion.insert({
    this.id = const Value.absent(),
    required int userId,
    required int planId,
    this.currentDay = const Value.absent(),
    required String status,
    required DateTime startDate,
    required DateTime updatedAt,
  }) : userId = Value(userId),
       planId = Value(planId),
       status = Value(status),
       startDate = Value(startDate),
       updatedAt = Value(updatedAt);
  static Insertable<UserPlanProgress> custom({
    Expression<int>? id,
    Expression<int>? userId,
    Expression<int>? planId,
    Expression<int>? currentDay,
    Expression<String>? status,
    Expression<DateTime>? startDate,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (planId != null) 'plan_id': planId,
      if (currentDay != null) 'current_day': currentDay,
      if (status != null) 'status': status,
      if (startDate != null) 'start_date': startDate,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  UserPlanProgressTableCompanion copyWith({
    Value<int>? id,
    Value<int>? userId,
    Value<int>? planId,
    Value<int>? currentDay,
    Value<String>? status,
    Value<DateTime>? startDate,
    Value<DateTime>? updatedAt,
  }) {
    return UserPlanProgressTableCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      planId: planId ?? this.planId,
      currentDay: currentDay ?? this.currentDay,
      status: status ?? this.status,
      startDate: startDate ?? this.startDate,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (planId.present) {
      map['plan_id'] = Variable<int>(planId.value);
    }
    if (currentDay.present) {
      map['current_day'] = Variable<int>(currentDay.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserPlanProgressTableCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('planId: $planId, ')
          ..write('currentDay: $currentDay, ')
          ..write('status: $status, ')
          ..write('startDate: $startDate, ')
          ..write('updatedAt: $updatedAt')
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
  late final $GongDawDetailsTableTable gongDawDetailsTable =
      $GongDawDetailsTableTable(this);
  late final $BeadPlansTableTable beadPlansTable = $BeadPlansTableTable(this);
  late final $PlanDaysTableTable planDaysTable = $PlanDaysTableTable(this);
  late final $UserPlanProgressTableTable userPlanProgressTable =
      $UserPlanProgressTableTable(this);
  late final UserInfoDao userInfoDao = UserInfoDao(this as AppDatabase);
  late final ChantSessionDao chantSessionDao = ChantSessionDao(
    this as AppDatabase,
  );
  late final PlanDao planDao = PlanDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    userInfoTable,
    chantSessionsTable,
    gongDawDetailsTable,
    beadPlansTable,
    planDaysTable,
    userPlanProgressTable,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'bead_plans_table',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('plan_days_table', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'user_info_table',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [
        TableUpdate('user_plan_progress_table', kind: UpdateKind.delete),
      ],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'bead_plans_table',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [
        TableUpdate('user_plan_progress_table', kind: UpdateKind.delete),
      ],
    ),
  ]);
}

typedef $$UserInfoTableTableCreateCompanionBuilder =
    UserInfoTableCompanion Function({
      Value<int> id,
      required String name,
      required String rankTitle,
      Value<String> defaultMode,
      required int streakDays,
      required int totalLifetimeBeads,
      required int totalLifetimeRounds,
      Value<int> counterRounds,
      required DateTime createdAt,
      required DateTime updatedAt,
    });
typedef $$UserInfoTableTableUpdateCompanionBuilder =
    UserInfoTableCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> rankTitle,
      Value<String> defaultMode,
      Value<int> streakDays,
      Value<int> totalLifetimeBeads,
      Value<int> totalLifetimeRounds,
      Value<int> counterRounds,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$UserInfoTableTableReferences
    extends BaseReferences<_$AppDatabase, $UserInfoTableTable, UserInfo> {
  $$UserInfoTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<
    $UserPlanProgressTableTable,
    List<UserPlanProgress>
  >
  _userPlanProgressTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.userPlanProgressTable,
        aliasName: $_aliasNameGenerator(
          db.userInfoTable.id,
          db.userPlanProgressTable.userId,
        ),
      );

  $$UserPlanProgressTableTableProcessedTableManager
  get userPlanProgressTableRefs {
    final manager = $$UserPlanProgressTableTableTableManager(
      $_db,
      $_db.userPlanProgressTable,
    ).filter((f) => f.userId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _userPlanProgressTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

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

  ColumnFilters<String> get defaultMode => $composableBuilder(
    column: $table.defaultMode,
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

  ColumnFilters<int> get counterRounds => $composableBuilder(
    column: $table.counterRounds,
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

  Expression<bool> userPlanProgressTableRefs(
    Expression<bool> Function($$UserPlanProgressTableTableFilterComposer f) f,
  ) {
    final $$UserPlanProgressTableTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.userPlanProgressTable,
          getReferencedColumn: (t) => t.userId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$UserPlanProgressTableTableFilterComposer(
                $db: $db,
                $table: $db.userPlanProgressTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
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

  ColumnOrderings<String> get defaultMode => $composableBuilder(
    column: $table.defaultMode,
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

  ColumnOrderings<int> get counterRounds => $composableBuilder(
    column: $table.counterRounds,
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

  GeneratedColumn<String> get defaultMode => $composableBuilder(
    column: $table.defaultMode,
    builder: (column) => column,
  );

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

  GeneratedColumn<int> get counterRounds => $composableBuilder(
    column: $table.counterRounds,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> userPlanProgressTableRefs<T extends Object>(
    Expression<T> Function($$UserPlanProgressTableTableAnnotationComposer a) f,
  ) {
    final $$UserPlanProgressTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.userPlanProgressTable,
          getReferencedColumn: (t) => t.userId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$UserPlanProgressTableTableAnnotationComposer(
                $db: $db,
                $table: $db.userPlanProgressTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
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
          (UserInfo, $$UserInfoTableTableReferences),
          UserInfo,
          PrefetchHooks Function({bool userPlanProgressTableRefs})
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
                Value<String> defaultMode = const Value.absent(),
                Value<int> streakDays = const Value.absent(),
                Value<int> totalLifetimeBeads = const Value.absent(),
                Value<int> totalLifetimeRounds = const Value.absent(),
                Value<int> counterRounds = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => UserInfoTableCompanion(
                id: id,
                name: name,
                rankTitle: rankTitle,
                defaultMode: defaultMode,
                streakDays: streakDays,
                totalLifetimeBeads: totalLifetimeBeads,
                totalLifetimeRounds: totalLifetimeRounds,
                counterRounds: counterRounds,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String rankTitle,
                Value<String> defaultMode = const Value.absent(),
                required int streakDays,
                required int totalLifetimeBeads,
                required int totalLifetimeRounds,
                Value<int> counterRounds = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
              }) => UserInfoTableCompanion.insert(
                id: id,
                name: name,
                rankTitle: rankTitle,
                defaultMode: defaultMode,
                streakDays: streakDays,
                totalLifetimeBeads: totalLifetimeBeads,
                totalLifetimeRounds: totalLifetimeRounds,
                counterRounds: counterRounds,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$UserInfoTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({userPlanProgressTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (userPlanProgressTableRefs) db.userPlanProgressTable,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (userPlanProgressTableRefs)
                    await $_getPrefetchedData<
                      UserInfo,
                      $UserInfoTableTable,
                      UserPlanProgress
                    >(
                      currentTable: table,
                      referencedTable: $$UserInfoTableTableReferences
                          ._userPlanProgressTableRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$UserInfoTableTableReferences(
                            db,
                            table,
                            p0,
                          ).userPlanProgressTableRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.userId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
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
      (UserInfo, $$UserInfoTableTableReferences),
      UserInfo,
      PrefetchHooks Function({bool userPlanProgressTableRefs})
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
typedef $$GongDawDetailsTableTableCreateCompanionBuilder =
    GongDawDetailsTableCompanion Function({
      Value<int> id,
      required String name,
      required String meaning,
    });
typedef $$GongDawDetailsTableTableUpdateCompanionBuilder =
    GongDawDetailsTableCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> meaning,
    });

final class $$GongDawDetailsTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $GongDawDetailsTableTable,
          GongDawDetails
        > {
  $$GongDawDetailsTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$PlanDaysTableTable, List<PlanDay>>
  _planDaysTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.planDaysTable,
    aliasName: $_aliasNameGenerator(
      db.gongDawDetailsTable.id,
      db.planDaysTable.gongDawId,
    ),
  );

  $$PlanDaysTableTableProcessedTableManager get planDaysTableRefs {
    final manager = $$PlanDaysTableTableTableManager(
      $_db,
      $_db.planDaysTable,
    ).filter((f) => f.gongDawId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_planDaysTableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$GongDawDetailsTableTableFilterComposer
    extends Composer<_$AppDatabase, $GongDawDetailsTableTable> {
  $$GongDawDetailsTableTableFilterComposer({
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

  ColumnFilters<String> get meaning => $composableBuilder(
    column: $table.meaning,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> planDaysTableRefs(
    Expression<bool> Function($$PlanDaysTableTableFilterComposer f) f,
  ) {
    final $$PlanDaysTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.planDaysTable,
      getReferencedColumn: (t) => t.gongDawId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlanDaysTableTableFilterComposer(
            $db: $db,
            $table: $db.planDaysTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$GongDawDetailsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $GongDawDetailsTableTable> {
  $$GongDawDetailsTableTableOrderingComposer({
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

  ColumnOrderings<String> get meaning => $composableBuilder(
    column: $table.meaning,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$GongDawDetailsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $GongDawDetailsTableTable> {
  $$GongDawDetailsTableTableAnnotationComposer({
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

  GeneratedColumn<String> get meaning =>
      $composableBuilder(column: $table.meaning, builder: (column) => column);

  Expression<T> planDaysTableRefs<T extends Object>(
    Expression<T> Function($$PlanDaysTableTableAnnotationComposer a) f,
  ) {
    final $$PlanDaysTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.planDaysTable,
      getReferencedColumn: (t) => t.gongDawId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlanDaysTableTableAnnotationComposer(
            $db: $db,
            $table: $db.planDaysTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$GongDawDetailsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GongDawDetailsTableTable,
          GongDawDetails,
          $$GongDawDetailsTableTableFilterComposer,
          $$GongDawDetailsTableTableOrderingComposer,
          $$GongDawDetailsTableTableAnnotationComposer,
          $$GongDawDetailsTableTableCreateCompanionBuilder,
          $$GongDawDetailsTableTableUpdateCompanionBuilder,
          (GongDawDetails, $$GongDawDetailsTableTableReferences),
          GongDawDetails,
          PrefetchHooks Function({bool planDaysTableRefs})
        > {
  $$GongDawDetailsTableTableTableManager(
    _$AppDatabase db,
    $GongDawDetailsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GongDawDetailsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GongDawDetailsTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$GongDawDetailsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> meaning = const Value.absent(),
              }) => GongDawDetailsTableCompanion(
                id: id,
                name: name,
                meaning: meaning,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String meaning,
              }) => GongDawDetailsTableCompanion.insert(
                id: id,
                name: name,
                meaning: meaning,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$GongDawDetailsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({planDaysTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (planDaysTableRefs) db.planDaysTable,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (planDaysTableRefs)
                    await $_getPrefetchedData<
                      GongDawDetails,
                      $GongDawDetailsTableTable,
                      PlanDay
                    >(
                      currentTable: table,
                      referencedTable: $$GongDawDetailsTableTableReferences
                          ._planDaysTableRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$GongDawDetailsTableTableReferences(
                            db,
                            table,
                            p0,
                          ).planDaysTableRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.gongDawId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$GongDawDetailsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GongDawDetailsTableTable,
      GongDawDetails,
      $$GongDawDetailsTableTableFilterComposer,
      $$GongDawDetailsTableTableOrderingComposer,
      $$GongDawDetailsTableTableAnnotationComposer,
      $$GongDawDetailsTableTableCreateCompanionBuilder,
      $$GongDawDetailsTableTableUpdateCompanionBuilder,
      (GongDawDetails, $$GongDawDetailsTableTableReferences),
      GongDawDetails,
      PrefetchHooks Function({bool planDaysTableRefs})
    >;
typedef $$BeadPlansTableTableCreateCompanionBuilder =
    BeadPlansTableCompanion Function({
      Value<int> id,
      required String title,
      required String description,
      Value<bool> isPredefined,
      Value<int> beadsPerRound,
      required DateTime createdAt,
    });
typedef $$BeadPlansTableTableUpdateCompanionBuilder =
    BeadPlansTableCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<String> description,
      Value<bool> isPredefined,
      Value<int> beadsPerRound,
      Value<DateTime> createdAt,
    });

final class $$BeadPlansTableTableReferences
    extends BaseReferences<_$AppDatabase, $BeadPlansTableTable, BeadPlan> {
  $$BeadPlansTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$PlanDaysTableTable, List<PlanDay>>
  _planDaysTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.planDaysTable,
    aliasName: $_aliasNameGenerator(
      db.beadPlansTable.id,
      db.planDaysTable.planId,
    ),
  );

  $$PlanDaysTableTableProcessedTableManager get planDaysTableRefs {
    final manager = $$PlanDaysTableTableTableManager(
      $_db,
      $_db.planDaysTable,
    ).filter((f) => f.planId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_planDaysTableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $UserPlanProgressTableTable,
    List<UserPlanProgress>
  >
  _userPlanProgressTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.userPlanProgressTable,
        aliasName: $_aliasNameGenerator(
          db.beadPlansTable.id,
          db.userPlanProgressTable.planId,
        ),
      );

  $$UserPlanProgressTableTableProcessedTableManager
  get userPlanProgressTableRefs {
    final manager = $$UserPlanProgressTableTableTableManager(
      $_db,
      $_db.userPlanProgressTable,
    ).filter((f) => f.planId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _userPlanProgressTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$BeadPlansTableTableFilterComposer
    extends Composer<_$AppDatabase, $BeadPlansTableTable> {
  $$BeadPlansTableTableFilterComposer({
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

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isPredefined => $composableBuilder(
    column: $table.isPredefined,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get beadsPerRound => $composableBuilder(
    column: $table.beadsPerRound,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> planDaysTableRefs(
    Expression<bool> Function($$PlanDaysTableTableFilterComposer f) f,
  ) {
    final $$PlanDaysTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.planDaysTable,
      getReferencedColumn: (t) => t.planId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlanDaysTableTableFilterComposer(
            $db: $db,
            $table: $db.planDaysTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> userPlanProgressTableRefs(
    Expression<bool> Function($$UserPlanProgressTableTableFilterComposer f) f,
  ) {
    final $$UserPlanProgressTableTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.userPlanProgressTable,
          getReferencedColumn: (t) => t.planId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$UserPlanProgressTableTableFilterComposer(
                $db: $db,
                $table: $db.userPlanProgressTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$BeadPlansTableTableOrderingComposer
    extends Composer<_$AppDatabase, $BeadPlansTableTable> {
  $$BeadPlansTableTableOrderingComposer({
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

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isPredefined => $composableBuilder(
    column: $table.isPredefined,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get beadsPerRound => $composableBuilder(
    column: $table.beadsPerRound,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BeadPlansTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $BeadPlansTableTable> {
  $$BeadPlansTableTableAnnotationComposer({
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

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isPredefined => $composableBuilder(
    column: $table.isPredefined,
    builder: (column) => column,
  );

  GeneratedColumn<int> get beadsPerRound => $composableBuilder(
    column: $table.beadsPerRound,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> planDaysTableRefs<T extends Object>(
    Expression<T> Function($$PlanDaysTableTableAnnotationComposer a) f,
  ) {
    final $$PlanDaysTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.planDaysTable,
      getReferencedColumn: (t) => t.planId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlanDaysTableTableAnnotationComposer(
            $db: $db,
            $table: $db.planDaysTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> userPlanProgressTableRefs<T extends Object>(
    Expression<T> Function($$UserPlanProgressTableTableAnnotationComposer a) f,
  ) {
    final $$UserPlanProgressTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.userPlanProgressTable,
          getReferencedColumn: (t) => t.planId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$UserPlanProgressTableTableAnnotationComposer(
                $db: $db,
                $table: $db.userPlanProgressTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$BeadPlansTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BeadPlansTableTable,
          BeadPlan,
          $$BeadPlansTableTableFilterComposer,
          $$BeadPlansTableTableOrderingComposer,
          $$BeadPlansTableTableAnnotationComposer,
          $$BeadPlansTableTableCreateCompanionBuilder,
          $$BeadPlansTableTableUpdateCompanionBuilder,
          (BeadPlan, $$BeadPlansTableTableReferences),
          BeadPlan,
          PrefetchHooks Function({
            bool planDaysTableRefs,
            bool userPlanProgressTableRefs,
          })
        > {
  $$BeadPlansTableTableTableManager(
    _$AppDatabase db,
    $BeadPlansTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BeadPlansTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BeadPlansTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BeadPlansTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<bool> isPredefined = const Value.absent(),
                Value<int> beadsPerRound = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => BeadPlansTableCompanion(
                id: id,
                title: title,
                description: description,
                isPredefined: isPredefined,
                beadsPerRound: beadsPerRound,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                required String description,
                Value<bool> isPredefined = const Value.absent(),
                Value<int> beadsPerRound = const Value.absent(),
                required DateTime createdAt,
              }) => BeadPlansTableCompanion.insert(
                id: id,
                title: title,
                description: description,
                isPredefined: isPredefined,
                beadsPerRound: beadsPerRound,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$BeadPlansTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({planDaysTableRefs = false, userPlanProgressTableRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (planDaysTableRefs) db.planDaysTable,
                    if (userPlanProgressTableRefs) db.userPlanProgressTable,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (planDaysTableRefs)
                        await $_getPrefetchedData<
                          BeadPlan,
                          $BeadPlansTableTable,
                          PlanDay
                        >(
                          currentTable: table,
                          referencedTable: $$BeadPlansTableTableReferences
                              ._planDaysTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BeadPlansTableTableReferences(
                                db,
                                table,
                                p0,
                              ).planDaysTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.planId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (userPlanProgressTableRefs)
                        await $_getPrefetchedData<
                          BeadPlan,
                          $BeadPlansTableTable,
                          UserPlanProgress
                        >(
                          currentTable: table,
                          referencedTable: $$BeadPlansTableTableReferences
                              ._userPlanProgressTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BeadPlansTableTableReferences(
                                db,
                                table,
                                p0,
                              ).userPlanProgressTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.planId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$BeadPlansTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BeadPlansTableTable,
      BeadPlan,
      $$BeadPlansTableTableFilterComposer,
      $$BeadPlansTableTableOrderingComposer,
      $$BeadPlansTableTableAnnotationComposer,
      $$BeadPlansTableTableCreateCompanionBuilder,
      $$BeadPlansTableTableUpdateCompanionBuilder,
      (BeadPlan, $$BeadPlansTableTableReferences),
      BeadPlan,
      PrefetchHooks Function({
        bool planDaysTableRefs,
        bool userPlanProgressTableRefs,
      })
    >;
typedef $$PlanDaysTableTableCreateCompanionBuilder =
    PlanDaysTableCompanion Function({
      Value<int> id,
      required int planId,
      required int dayNumber,
      required int gongDawId,
      required int targetRounds,
      Value<String?> gongDawName,
    });
typedef $$PlanDaysTableTableUpdateCompanionBuilder =
    PlanDaysTableCompanion Function({
      Value<int> id,
      Value<int> planId,
      Value<int> dayNumber,
      Value<int> gongDawId,
      Value<int> targetRounds,
      Value<String?> gongDawName,
    });

final class $$PlanDaysTableTableReferences
    extends BaseReferences<_$AppDatabase, $PlanDaysTableTable, PlanDay> {
  $$PlanDaysTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $BeadPlansTableTable _planIdTable(_$AppDatabase db) =>
      db.beadPlansTable.createAlias(
        $_aliasNameGenerator(db.planDaysTable.planId, db.beadPlansTable.id),
      );

  $$BeadPlansTableTableProcessedTableManager get planId {
    final $_column = $_itemColumn<int>('plan_id')!;

    final manager = $$BeadPlansTableTableTableManager(
      $_db,
      $_db.beadPlansTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_planIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $GongDawDetailsTableTable _gongDawIdTable(_$AppDatabase db) =>
      db.gongDawDetailsTable.createAlias(
        $_aliasNameGenerator(
          db.planDaysTable.gongDawId,
          db.gongDawDetailsTable.id,
        ),
      );

  $$GongDawDetailsTableTableProcessedTableManager get gongDawId {
    final $_column = $_itemColumn<int>('gong_daw_id')!;

    final manager = $$GongDawDetailsTableTableTableManager(
      $_db,
      $_db.gongDawDetailsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_gongDawIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PlanDaysTableTableFilterComposer
    extends Composer<_$AppDatabase, $PlanDaysTableTable> {
  $$PlanDaysTableTableFilterComposer({
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

  ColumnFilters<int> get dayNumber => $composableBuilder(
    column: $table.dayNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get targetRounds => $composableBuilder(
    column: $table.targetRounds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get gongDawName => $composableBuilder(
    column: $table.gongDawName,
    builder: (column) => ColumnFilters(column),
  );

  $$BeadPlansTableTableFilterComposer get planId {
    final $$BeadPlansTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.planId,
      referencedTable: $db.beadPlansTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BeadPlansTableTableFilterComposer(
            $db: $db,
            $table: $db.beadPlansTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$GongDawDetailsTableTableFilterComposer get gongDawId {
    final $$GongDawDetailsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.gongDawId,
      referencedTable: $db.gongDawDetailsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GongDawDetailsTableTableFilterComposer(
            $db: $db,
            $table: $db.gongDawDetailsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PlanDaysTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PlanDaysTableTable> {
  $$PlanDaysTableTableOrderingComposer({
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

  ColumnOrderings<int> get dayNumber => $composableBuilder(
    column: $table.dayNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get targetRounds => $composableBuilder(
    column: $table.targetRounds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get gongDawName => $composableBuilder(
    column: $table.gongDawName,
    builder: (column) => ColumnOrderings(column),
  );

  $$BeadPlansTableTableOrderingComposer get planId {
    final $$BeadPlansTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.planId,
      referencedTable: $db.beadPlansTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BeadPlansTableTableOrderingComposer(
            $db: $db,
            $table: $db.beadPlansTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$GongDawDetailsTableTableOrderingComposer get gongDawId {
    final $$GongDawDetailsTableTableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.gongDawId,
          referencedTable: $db.gongDawDetailsTable,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$GongDawDetailsTableTableOrderingComposer(
                $db: $db,
                $table: $db.gongDawDetailsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$PlanDaysTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PlanDaysTableTable> {
  $$PlanDaysTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get dayNumber =>
      $composableBuilder(column: $table.dayNumber, builder: (column) => column);

  GeneratedColumn<int> get targetRounds => $composableBuilder(
    column: $table.targetRounds,
    builder: (column) => column,
  );

  GeneratedColumn<String> get gongDawName => $composableBuilder(
    column: $table.gongDawName,
    builder: (column) => column,
  );

  $$BeadPlansTableTableAnnotationComposer get planId {
    final $$BeadPlansTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.planId,
      referencedTable: $db.beadPlansTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BeadPlansTableTableAnnotationComposer(
            $db: $db,
            $table: $db.beadPlansTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$GongDawDetailsTableTableAnnotationComposer get gongDawId {
    final $$GongDawDetailsTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.gongDawId,
          referencedTable: $db.gongDawDetailsTable,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$GongDawDetailsTableTableAnnotationComposer(
                $db: $db,
                $table: $db.gongDawDetailsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$PlanDaysTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PlanDaysTableTable,
          PlanDay,
          $$PlanDaysTableTableFilterComposer,
          $$PlanDaysTableTableOrderingComposer,
          $$PlanDaysTableTableAnnotationComposer,
          $$PlanDaysTableTableCreateCompanionBuilder,
          $$PlanDaysTableTableUpdateCompanionBuilder,
          (PlanDay, $$PlanDaysTableTableReferences),
          PlanDay,
          PrefetchHooks Function({bool planId, bool gongDawId})
        > {
  $$PlanDaysTableTableTableManager(_$AppDatabase db, $PlanDaysTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlanDaysTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlanDaysTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlanDaysTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> planId = const Value.absent(),
                Value<int> dayNumber = const Value.absent(),
                Value<int> gongDawId = const Value.absent(),
                Value<int> targetRounds = const Value.absent(),
                Value<String?> gongDawName = const Value.absent(),
              }) => PlanDaysTableCompanion(
                id: id,
                planId: planId,
                dayNumber: dayNumber,
                gongDawId: gongDawId,
                targetRounds: targetRounds,
                gongDawName: gongDawName,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int planId,
                required int dayNumber,
                required int gongDawId,
                required int targetRounds,
                Value<String?> gongDawName = const Value.absent(),
              }) => PlanDaysTableCompanion.insert(
                id: id,
                planId: planId,
                dayNumber: dayNumber,
                gongDawId: gongDawId,
                targetRounds: targetRounds,
                gongDawName: gongDawName,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PlanDaysTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({planId = false, gongDawId = false}) {
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
                    if (planId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.planId,
                                referencedTable: $$PlanDaysTableTableReferences
                                    ._planIdTable(db),
                                referencedColumn: $$PlanDaysTableTableReferences
                                    ._planIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (gongDawId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.gongDawId,
                                referencedTable: $$PlanDaysTableTableReferences
                                    ._gongDawIdTable(db),
                                referencedColumn: $$PlanDaysTableTableReferences
                                    ._gongDawIdTable(db)
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

typedef $$PlanDaysTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PlanDaysTableTable,
      PlanDay,
      $$PlanDaysTableTableFilterComposer,
      $$PlanDaysTableTableOrderingComposer,
      $$PlanDaysTableTableAnnotationComposer,
      $$PlanDaysTableTableCreateCompanionBuilder,
      $$PlanDaysTableTableUpdateCompanionBuilder,
      (PlanDay, $$PlanDaysTableTableReferences),
      PlanDay,
      PrefetchHooks Function({bool planId, bool gongDawId})
    >;
typedef $$UserPlanProgressTableTableCreateCompanionBuilder =
    UserPlanProgressTableCompanion Function({
      Value<int> id,
      required int userId,
      required int planId,
      Value<int> currentDay,
      required String status,
      required DateTime startDate,
      required DateTime updatedAt,
    });
typedef $$UserPlanProgressTableTableUpdateCompanionBuilder =
    UserPlanProgressTableCompanion Function({
      Value<int> id,
      Value<int> userId,
      Value<int> planId,
      Value<int> currentDay,
      Value<String> status,
      Value<DateTime> startDate,
      Value<DateTime> updatedAt,
    });

final class $$UserPlanProgressTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $UserPlanProgressTableTable,
          UserPlanProgress
        > {
  $$UserPlanProgressTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $UserInfoTableTable _userIdTable(_$AppDatabase db) =>
      db.userInfoTable.createAlias(
        $_aliasNameGenerator(
          db.userPlanProgressTable.userId,
          db.userInfoTable.id,
        ),
      );

  $$UserInfoTableTableProcessedTableManager get userId {
    final $_column = $_itemColumn<int>('user_id')!;

    final manager = $$UserInfoTableTableTableManager(
      $_db,
      $_db.userInfoTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $BeadPlansTableTable _planIdTable(_$AppDatabase db) =>
      db.beadPlansTable.createAlias(
        $_aliasNameGenerator(
          db.userPlanProgressTable.planId,
          db.beadPlansTable.id,
        ),
      );

  $$BeadPlansTableTableProcessedTableManager get planId {
    final $_column = $_itemColumn<int>('plan_id')!;

    final manager = $$BeadPlansTableTableTableManager(
      $_db,
      $_db.beadPlansTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_planIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$UserPlanProgressTableTableFilterComposer
    extends Composer<_$AppDatabase, $UserPlanProgressTableTable> {
  $$UserPlanProgressTableTableFilterComposer({
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

  ColumnFilters<int> get currentDay => $composableBuilder(
    column: $table.currentDay,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$UserInfoTableTableFilterComposer get userId {
    final $$UserInfoTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.userInfoTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserInfoTableTableFilterComposer(
            $db: $db,
            $table: $db.userInfoTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BeadPlansTableTableFilterComposer get planId {
    final $$BeadPlansTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.planId,
      referencedTable: $db.beadPlansTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BeadPlansTableTableFilterComposer(
            $db: $db,
            $table: $db.beadPlansTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserPlanProgressTableTableOrderingComposer
    extends Composer<_$AppDatabase, $UserPlanProgressTableTable> {
  $$UserPlanProgressTableTableOrderingComposer({
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

  ColumnOrderings<int> get currentDay => $composableBuilder(
    column: $table.currentDay,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$UserInfoTableTableOrderingComposer get userId {
    final $$UserInfoTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.userInfoTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserInfoTableTableOrderingComposer(
            $db: $db,
            $table: $db.userInfoTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BeadPlansTableTableOrderingComposer get planId {
    final $$BeadPlansTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.planId,
      referencedTable: $db.beadPlansTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BeadPlansTableTableOrderingComposer(
            $db: $db,
            $table: $db.beadPlansTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserPlanProgressTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserPlanProgressTableTable> {
  $$UserPlanProgressTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get currentDay => $composableBuilder(
    column: $table.currentDay,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$UserInfoTableTableAnnotationComposer get userId {
    final $$UserInfoTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.userInfoTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserInfoTableTableAnnotationComposer(
            $db: $db,
            $table: $db.userInfoTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BeadPlansTableTableAnnotationComposer get planId {
    final $$BeadPlansTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.planId,
      referencedTable: $db.beadPlansTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BeadPlansTableTableAnnotationComposer(
            $db: $db,
            $table: $db.beadPlansTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserPlanProgressTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserPlanProgressTableTable,
          UserPlanProgress,
          $$UserPlanProgressTableTableFilterComposer,
          $$UserPlanProgressTableTableOrderingComposer,
          $$UserPlanProgressTableTableAnnotationComposer,
          $$UserPlanProgressTableTableCreateCompanionBuilder,
          $$UserPlanProgressTableTableUpdateCompanionBuilder,
          (UserPlanProgress, $$UserPlanProgressTableTableReferences),
          UserPlanProgress,
          PrefetchHooks Function({bool userId, bool planId})
        > {
  $$UserPlanProgressTableTableTableManager(
    _$AppDatabase db,
    $UserPlanProgressTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserPlanProgressTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$UserPlanProgressTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$UserPlanProgressTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> userId = const Value.absent(),
                Value<int> planId = const Value.absent(),
                Value<int> currentDay = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> startDate = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => UserPlanProgressTableCompanion(
                id: id,
                userId: userId,
                planId: planId,
                currentDay: currentDay,
                status: status,
                startDate: startDate,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int userId,
                required int planId,
                Value<int> currentDay = const Value.absent(),
                required String status,
                required DateTime startDate,
                required DateTime updatedAt,
              }) => UserPlanProgressTableCompanion.insert(
                id: id,
                userId: userId,
                planId: planId,
                currentDay: currentDay,
                status: status,
                startDate: startDate,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$UserPlanProgressTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({userId = false, planId = false}) {
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
                    if (userId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.userId,
                                referencedTable:
                                    $$UserPlanProgressTableTableReferences
                                        ._userIdTable(db),
                                referencedColumn:
                                    $$UserPlanProgressTableTableReferences
                                        ._userIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (planId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.planId,
                                referencedTable:
                                    $$UserPlanProgressTableTableReferences
                                        ._planIdTable(db),
                                referencedColumn:
                                    $$UserPlanProgressTableTableReferences
                                        ._planIdTable(db)
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

typedef $$UserPlanProgressTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserPlanProgressTableTable,
      UserPlanProgress,
      $$UserPlanProgressTableTableFilterComposer,
      $$UserPlanProgressTableTableOrderingComposer,
      $$UserPlanProgressTableTableAnnotationComposer,
      $$UserPlanProgressTableTableCreateCompanionBuilder,
      $$UserPlanProgressTableTableUpdateCompanionBuilder,
      (UserPlanProgress, $$UserPlanProgressTableTableReferences),
      UserPlanProgress,
      PrefetchHooks Function({bool userId, bool planId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UserInfoTableTableTableManager get userInfoTable =>
      $$UserInfoTableTableTableManager(_db, _db.userInfoTable);
  $$ChantSessionsTableTableTableManager get chantSessionsTable =>
      $$ChantSessionsTableTableTableManager(_db, _db.chantSessionsTable);
  $$GongDawDetailsTableTableTableManager get gongDawDetailsTable =>
      $$GongDawDetailsTableTableTableManager(_db, _db.gongDawDetailsTable);
  $$BeadPlansTableTableTableManager get beadPlansTable =>
      $$BeadPlansTableTableTableManager(_db, _db.beadPlansTable);
  $$PlanDaysTableTableTableManager get planDaysTable =>
      $$PlanDaysTableTableTableManager(_db, _db.planDaysTable);
  $$UserPlanProgressTableTableTableManager get userPlanProgressTable =>
      $$UserPlanProgressTableTableTableManager(_db, _db.userPlanProgressTable);
}
