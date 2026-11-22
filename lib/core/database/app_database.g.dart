// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $SyncMetadataTableTable extends SyncMetadataTable
    with TableInfo<$SyncMetadataTableTable, SyncMetadataRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncMetadataTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _resourceKeyMeta = const VerificationMeta(
    'resourceKey',
  );
  @override
  late final GeneratedColumn<String> resourceKey = GeneratedColumn<String>(
    'resource_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastSuccessAtMeta = const VerificationMeta(
    'lastSuccessAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastSuccessAt =
      GeneratedColumn<DateTime>(
        'last_success_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  @override
  late final GeneratedColumnWithTypeConverter<SyncState, String> status =
      GeneratedColumn<String>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: Constant(SyncState.idle.name),
      ).withConverter<SyncState>($SyncMetadataTableTable.$converterstatus);
  static const VerificationMeta _nextOffsetMeta = const VerificationMeta(
    'nextOffset',
  );
  @override
  late final GeneratedColumn<int> nextOffset = GeneratedColumn<int>(
    'next_offset',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _totalRemoteMeta = const VerificationMeta(
    'totalRemote',
  );
  @override
  late final GeneratedColumn<int> totalRemote = GeneratedColumn<int>(
    'total_remote',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    resourceKey,
    lastSuccessAt,
    status,
    nextOffset,
    totalRemote,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_metadata';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncMetadataRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('resource_key')) {
      context.handle(
        _resourceKeyMeta,
        resourceKey.isAcceptableOrUnknown(
          data['resource_key']!,
          _resourceKeyMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_resourceKeyMeta);
    }
    if (data.containsKey('last_success_at')) {
      context.handle(
        _lastSuccessAtMeta,
        lastSuccessAt.isAcceptableOrUnknown(
          data['last_success_at']!,
          _lastSuccessAtMeta,
        ),
      );
    }
    if (data.containsKey('next_offset')) {
      context.handle(
        _nextOffsetMeta,
        nextOffset.isAcceptableOrUnknown(data['next_offset']!, _nextOffsetMeta),
      );
    }
    if (data.containsKey('total_remote')) {
      context.handle(
        _totalRemoteMeta,
        totalRemote.isAcceptableOrUnknown(
          data['total_remote']!,
          _totalRemoteMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {resourceKey};
  @override
  SyncMetadataRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncMetadataRow(
      resourceKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}resource_key'],
      )!,
      lastSuccessAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_success_at'],
      ),
      status: $SyncMetadataTableTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}status'],
        )!,
      ),
      nextOffset: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}next_offset'],
      )!,
      totalRemote: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_remote'],
      ),
    );
  }

  @override
  $SyncMetadataTableTable createAlias(String alias) {
    return $SyncMetadataTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<SyncState, String, String> $converterstatus =
      const EnumNameConverter<SyncState>(SyncState.values);
}

class SyncMetadataRow extends DataClass implements Insertable<SyncMetadataRow> {
  final String resourceKey;
  final DateTime? lastSuccessAt;
  final SyncState status;
  final int nextOffset;
  final int? totalRemote;
  const SyncMetadataRow({
    required this.resourceKey,
    this.lastSuccessAt,
    required this.status,
    required this.nextOffset,
    this.totalRemote,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['resource_key'] = Variable<String>(resourceKey);
    if (!nullToAbsent || lastSuccessAt != null) {
      map['last_success_at'] = Variable<DateTime>(lastSuccessAt);
    }
    {
      map['status'] = Variable<String>(
        $SyncMetadataTableTable.$converterstatus.toSql(status),
      );
    }
    map['next_offset'] = Variable<int>(nextOffset);
    if (!nullToAbsent || totalRemote != null) {
      map['total_remote'] = Variable<int>(totalRemote);
    }
    return map;
  }

  SyncMetadataTableCompanion toCompanion(bool nullToAbsent) {
    return SyncMetadataTableCompanion(
      resourceKey: Value(resourceKey),
      lastSuccessAt: lastSuccessAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSuccessAt),
      status: Value(status),
      nextOffset: Value(nextOffset),
      totalRemote: totalRemote == null && nullToAbsent
          ? const Value.absent()
          : Value(totalRemote),
    );
  }

  factory SyncMetadataRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncMetadataRow(
      resourceKey: serializer.fromJson<String>(json['resourceKey']),
      lastSuccessAt: serializer.fromJson<DateTime?>(json['lastSuccessAt']),
      status: $SyncMetadataTableTable.$converterstatus.fromJson(
        serializer.fromJson<String>(json['status']),
      ),
      nextOffset: serializer.fromJson<int>(json['nextOffset']),
      totalRemote: serializer.fromJson<int?>(json['totalRemote']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'resourceKey': serializer.toJson<String>(resourceKey),
      'lastSuccessAt': serializer.toJson<DateTime?>(lastSuccessAt),
      'status': serializer.toJson<String>(
        $SyncMetadataTableTable.$converterstatus.toJson(status),
      ),
      'nextOffset': serializer.toJson<int>(nextOffset),
      'totalRemote': serializer.toJson<int?>(totalRemote),
    };
  }

  SyncMetadataRow copyWith({
    String? resourceKey,
    Value<DateTime?> lastSuccessAt = const Value.absent(),
    SyncState? status,
    int? nextOffset,
    Value<int?> totalRemote = const Value.absent(),
  }) => SyncMetadataRow(
    resourceKey: resourceKey ?? this.resourceKey,
    lastSuccessAt: lastSuccessAt.present
        ? lastSuccessAt.value
        : this.lastSuccessAt,
    status: status ?? this.status,
    nextOffset: nextOffset ?? this.nextOffset,
    totalRemote: totalRemote.present ? totalRemote.value : this.totalRemote,
  );
  SyncMetadataRow copyWithCompanion(SyncMetadataTableCompanion data) {
    return SyncMetadataRow(
      resourceKey: data.resourceKey.present
          ? data.resourceKey.value
          : this.resourceKey,
      lastSuccessAt: data.lastSuccessAt.present
          ? data.lastSuccessAt.value
          : this.lastSuccessAt,
      status: data.status.present ? data.status.value : this.status,
      nextOffset: data.nextOffset.present
          ? data.nextOffset.value
          : this.nextOffset,
      totalRemote: data.totalRemote.present
          ? data.totalRemote.value
          : this.totalRemote,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncMetadataRow(')
          ..write('resourceKey: $resourceKey, ')
          ..write('lastSuccessAt: $lastSuccessAt, ')
          ..write('status: $status, ')
          ..write('nextOffset: $nextOffset, ')
          ..write('totalRemote: $totalRemote')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(resourceKey, lastSuccessAt, status, nextOffset, totalRemote);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncMetadataRow &&
          other.resourceKey == this.resourceKey &&
          other.lastSuccessAt == this.lastSuccessAt &&
          other.status == this.status &&
          other.nextOffset == this.nextOffset &&
          other.totalRemote == this.totalRemote);
}

class SyncMetadataTableCompanion extends UpdateCompanion<SyncMetadataRow> {
  final Value<String> resourceKey;
  final Value<DateTime?> lastSuccessAt;
  final Value<SyncState> status;
  final Value<int> nextOffset;
  final Value<int?> totalRemote;
  final Value<int> rowid;
  const SyncMetadataTableCompanion({
    this.resourceKey = const Value.absent(),
    this.lastSuccessAt = const Value.absent(),
    this.status = const Value.absent(),
    this.nextOffset = const Value.absent(),
    this.totalRemote = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncMetadataTableCompanion.insert({
    required String resourceKey,
    this.lastSuccessAt = const Value.absent(),
    this.status = const Value.absent(),
    this.nextOffset = const Value.absent(),
    this.totalRemote = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : resourceKey = Value(resourceKey);
  static Insertable<SyncMetadataRow> custom({
    Expression<String>? resourceKey,
    Expression<DateTime>? lastSuccessAt,
    Expression<String>? status,
    Expression<int>? nextOffset,
    Expression<int>? totalRemote,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (resourceKey != null) 'resource_key': resourceKey,
      if (lastSuccessAt != null) 'last_success_at': lastSuccessAt,
      if (status != null) 'status': status,
      if (nextOffset != null) 'next_offset': nextOffset,
      if (totalRemote != null) 'total_remote': totalRemote,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncMetadataTableCompanion copyWith({
    Value<String>? resourceKey,
    Value<DateTime?>? lastSuccessAt,
    Value<SyncState>? status,
    Value<int>? nextOffset,
    Value<int?>? totalRemote,
    Value<int>? rowid,
  }) {
    return SyncMetadataTableCompanion(
      resourceKey: resourceKey ?? this.resourceKey,
      lastSuccessAt: lastSuccessAt ?? this.lastSuccessAt,
      status: status ?? this.status,
      nextOffset: nextOffset ?? this.nextOffset,
      totalRemote: totalRemote ?? this.totalRemote,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (resourceKey.present) {
      map['resource_key'] = Variable<String>(resourceKey.value);
    }
    if (lastSuccessAt.present) {
      map['last_success_at'] = Variable<DateTime>(lastSuccessAt.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(
        $SyncMetadataTableTable.$converterstatus.toSql(status.value),
      );
    }
    if (nextOffset.present) {
      map['next_offset'] = Variable<int>(nextOffset.value);
    }
    if (totalRemote.present) {
      map['total_remote'] = Variable<int>(totalRemote.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncMetadataTableCompanion(')
          ..write('resourceKey: $resourceKey, ')
          ..write('lastSuccessAt: $lastSuccessAt, ')
          ..write('status: $status, ')
          ..write('nextOffset: $nextOffset, ')
          ..write('totalRemote: $totalRemote, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FavoritesTableTable extends FavoritesTable
    with TableInfo<$FavoritesTableTable, FavoriteRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FavoritesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _pokemonIdMeta = const VerificationMeta(
    'pokemonId',
  );
  @override
  late final GeneratedColumn<int> pokemonId = GeneratedColumn<int>(
    'pokemon_id',
    aliasedName,
    false,
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
  @override
  List<GeneratedColumn> get $columns => [pokemonId, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'favorites';
  @override
  VerificationContext validateIntegrity(
    Insertable<FavoriteRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('pokemon_id')) {
      context.handle(
        _pokemonIdMeta,
        pokemonId.isAcceptableOrUnknown(data['pokemon_id']!, _pokemonIdMeta),
      );
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
  Set<GeneratedColumn> get $primaryKey => {pokemonId};
  @override
  FavoriteRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FavoriteRow(
      pokemonId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pokemon_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $FavoritesTableTable createAlias(String alias) {
    return $FavoritesTableTable(attachedDatabase, alias);
  }
}

class FavoriteRow extends DataClass implements Insertable<FavoriteRow> {
  final int pokemonId;
  final DateTime createdAt;
  const FavoriteRow({required this.pokemonId, required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['pokemon_id'] = Variable<int>(pokemonId);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  FavoritesTableCompanion toCompanion(bool nullToAbsent) {
    return FavoritesTableCompanion(
      pokemonId: Value(pokemonId),
      createdAt: Value(createdAt),
    );
  }

  factory FavoriteRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FavoriteRow(
      pokemonId: serializer.fromJson<int>(json['pokemonId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'pokemonId': serializer.toJson<int>(pokemonId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  FavoriteRow copyWith({int? pokemonId, DateTime? createdAt}) => FavoriteRow(
    pokemonId: pokemonId ?? this.pokemonId,
    createdAt: createdAt ?? this.createdAt,
  );
  FavoriteRow copyWithCompanion(FavoritesTableCompanion data) {
    return FavoriteRow(
      pokemonId: data.pokemonId.present ? data.pokemonId.value : this.pokemonId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FavoriteRow(')
          ..write('pokemonId: $pokemonId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(pokemonId, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FavoriteRow &&
          other.pokemonId == this.pokemonId &&
          other.createdAt == this.createdAt);
}

class FavoritesTableCompanion extends UpdateCompanion<FavoriteRow> {
  final Value<int> pokemonId;
  final Value<DateTime> createdAt;
  const FavoritesTableCompanion({
    this.pokemonId = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  FavoritesTableCompanion.insert({
    this.pokemonId = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  static Insertable<FavoriteRow> custom({
    Expression<int>? pokemonId,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (pokemonId != null) 'pokemon_id': pokemonId,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  FavoritesTableCompanion copyWith({
    Value<int>? pokemonId,
    Value<DateTime>? createdAt,
  }) {
    return FavoritesTableCompanion(
      pokemonId: pokemonId ?? this.pokemonId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (pokemonId.present) {
      map['pokemon_id'] = Variable<int>(pokemonId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FavoritesTableCompanion(')
          ..write('pokemonId: $pokemonId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $PokemonTableTable extends PokemonTable
    with TableInfo<$PokemonTableTable, PokemonRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PokemonTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dexNumberMeta = const VerificationMeta(
    'dexNumber',
  );
  @override
  late final GeneratedColumn<int> dexNumber = GeneratedColumn<int>(
    'dex_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
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
  static const VerificationMeta _spriteUrlMeta = const VerificationMeta(
    'spriteUrl',
  );
  @override
  late final GeneratedColumn<String> spriteUrl = GeneratedColumn<String>(
    'sprite_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _artworkUrlMeta = const VerificationMeta(
    'artworkUrl',
  );
  @override
  late final GeneratedColumn<String> artworkUrl = GeneratedColumn<String>(
    'artwork_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
  static const VerificationMeta _heightMeta = const VerificationMeta('height');
  @override
  late final GeneratedColumn<int> height = GeneratedColumn<int>(
    'height',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<int> weight = GeneratedColumn<int>(
    'weight',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _generationIdMeta = const VerificationMeta(
    'generationId',
  );
  @override
  late final GeneratedColumn<int> generationId = GeneratedColumn<int>(
    'generation_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isDefaultMeta = const VerificationMeta(
    'isDefault',
  );
  @override
  late final GeneratedColumn<bool> isDefault = GeneratedColumn<bool>(
    'is_default',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_default" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    dexNumber,
    name,
    spriteUrl,
    artworkUrl,
    updatedAt,
    height,
    weight,
    generationId,
    isDefault,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pokemon';
  @override
  VerificationContext validateIntegrity(
    Insertable<PokemonRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('dex_number')) {
      context.handle(
        _dexNumberMeta,
        dexNumber.isAcceptableOrUnknown(data['dex_number']!, _dexNumberMeta),
      );
    } else if (isInserting) {
      context.missing(_dexNumberMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('sprite_url')) {
      context.handle(
        _spriteUrlMeta,
        spriteUrl.isAcceptableOrUnknown(data['sprite_url']!, _spriteUrlMeta),
      );
    }
    if (data.containsKey('artwork_url')) {
      context.handle(
        _artworkUrlMeta,
        artworkUrl.isAcceptableOrUnknown(data['artwork_url']!, _artworkUrlMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('height')) {
      context.handle(
        _heightMeta,
        height.isAcceptableOrUnknown(data['height']!, _heightMeta),
      );
    }
    if (data.containsKey('weight')) {
      context.handle(
        _weightMeta,
        weight.isAcceptableOrUnknown(data['weight']!, _weightMeta),
      );
    }
    if (data.containsKey('generation_id')) {
      context.handle(
        _generationIdMeta,
        generationId.isAcceptableOrUnknown(
          data['generation_id']!,
          _generationIdMeta,
        ),
      );
    }
    if (data.containsKey('is_default')) {
      context.handle(
        _isDefaultMeta,
        isDefault.isAcceptableOrUnknown(data['is_default']!, _isDefaultMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PokemonRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PokemonRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      dexNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}dex_number'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      spriteUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sprite_url'],
      ),
      artworkUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}artwork_url'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      height: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}height'],
      ),
      weight: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}weight'],
      ),
      generationId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}generation_id'],
      ),
      isDefault: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_default'],
      )!,
    );
  }

  @override
  $PokemonTableTable createAlias(String alias) {
    return $PokemonTableTable(attachedDatabase, alias);
  }
}

class PokemonRow extends DataClass implements Insertable<PokemonRow> {
  final int id;
  final int dexNumber;
  final String name;
  final String? spriteUrl;
  final String? artworkUrl;
  final DateTime updatedAt;
  final int? height;
  final int? weight;
  final int? generationId;
  final bool isDefault;
  const PokemonRow({
    required this.id,
    required this.dexNumber,
    required this.name,
    this.spriteUrl,
    this.artworkUrl,
    required this.updatedAt,
    this.height,
    this.weight,
    this.generationId,
    required this.isDefault,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['dex_number'] = Variable<int>(dexNumber);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || spriteUrl != null) {
      map['sprite_url'] = Variable<String>(spriteUrl);
    }
    if (!nullToAbsent || artworkUrl != null) {
      map['artwork_url'] = Variable<String>(artworkUrl);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || height != null) {
      map['height'] = Variable<int>(height);
    }
    if (!nullToAbsent || weight != null) {
      map['weight'] = Variable<int>(weight);
    }
    if (!nullToAbsent || generationId != null) {
      map['generation_id'] = Variable<int>(generationId);
    }
    map['is_default'] = Variable<bool>(isDefault);
    return map;
  }

  PokemonTableCompanion toCompanion(bool nullToAbsent) {
    return PokemonTableCompanion(
      id: Value(id),
      dexNumber: Value(dexNumber),
      name: Value(name),
      spriteUrl: spriteUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(spriteUrl),
      artworkUrl: artworkUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(artworkUrl),
      updatedAt: Value(updatedAt),
      height: height == null && nullToAbsent
          ? const Value.absent()
          : Value(height),
      weight: weight == null && nullToAbsent
          ? const Value.absent()
          : Value(weight),
      generationId: generationId == null && nullToAbsent
          ? const Value.absent()
          : Value(generationId),
      isDefault: Value(isDefault),
    );
  }

  factory PokemonRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PokemonRow(
      id: serializer.fromJson<int>(json['id']),
      dexNumber: serializer.fromJson<int>(json['dexNumber']),
      name: serializer.fromJson<String>(json['name']),
      spriteUrl: serializer.fromJson<String?>(json['spriteUrl']),
      artworkUrl: serializer.fromJson<String?>(json['artworkUrl']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      height: serializer.fromJson<int?>(json['height']),
      weight: serializer.fromJson<int?>(json['weight']),
      generationId: serializer.fromJson<int?>(json['generationId']),
      isDefault: serializer.fromJson<bool>(json['isDefault']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'dexNumber': serializer.toJson<int>(dexNumber),
      'name': serializer.toJson<String>(name),
      'spriteUrl': serializer.toJson<String?>(spriteUrl),
      'artworkUrl': serializer.toJson<String?>(artworkUrl),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'height': serializer.toJson<int?>(height),
      'weight': serializer.toJson<int?>(weight),
      'generationId': serializer.toJson<int?>(generationId),
      'isDefault': serializer.toJson<bool>(isDefault),
    };
  }

  PokemonRow copyWith({
    int? id,
    int? dexNumber,
    String? name,
    Value<String?> spriteUrl = const Value.absent(),
    Value<String?> artworkUrl = const Value.absent(),
    DateTime? updatedAt,
    Value<int?> height = const Value.absent(),
    Value<int?> weight = const Value.absent(),
    Value<int?> generationId = const Value.absent(),
    bool? isDefault,
  }) => PokemonRow(
    id: id ?? this.id,
    dexNumber: dexNumber ?? this.dexNumber,
    name: name ?? this.name,
    spriteUrl: spriteUrl.present ? spriteUrl.value : this.spriteUrl,
    artworkUrl: artworkUrl.present ? artworkUrl.value : this.artworkUrl,
    updatedAt: updatedAt ?? this.updatedAt,
    height: height.present ? height.value : this.height,
    weight: weight.present ? weight.value : this.weight,
    generationId: generationId.present ? generationId.value : this.generationId,
    isDefault: isDefault ?? this.isDefault,
  );
  PokemonRow copyWithCompanion(PokemonTableCompanion data) {
    return PokemonRow(
      id: data.id.present ? data.id.value : this.id,
      dexNumber: data.dexNumber.present ? data.dexNumber.value : this.dexNumber,
      name: data.name.present ? data.name.value : this.name,
      spriteUrl: data.spriteUrl.present ? data.spriteUrl.value : this.spriteUrl,
      artworkUrl: data.artworkUrl.present
          ? data.artworkUrl.value
          : this.artworkUrl,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      height: data.height.present ? data.height.value : this.height,
      weight: data.weight.present ? data.weight.value : this.weight,
      generationId: data.generationId.present
          ? data.generationId.value
          : this.generationId,
      isDefault: data.isDefault.present ? data.isDefault.value : this.isDefault,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PokemonRow(')
          ..write('id: $id, ')
          ..write('dexNumber: $dexNumber, ')
          ..write('name: $name, ')
          ..write('spriteUrl: $spriteUrl, ')
          ..write('artworkUrl: $artworkUrl, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('height: $height, ')
          ..write('weight: $weight, ')
          ..write('generationId: $generationId, ')
          ..write('isDefault: $isDefault')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    dexNumber,
    name,
    spriteUrl,
    artworkUrl,
    updatedAt,
    height,
    weight,
    generationId,
    isDefault,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PokemonRow &&
          other.id == this.id &&
          other.dexNumber == this.dexNumber &&
          other.name == this.name &&
          other.spriteUrl == this.spriteUrl &&
          other.artworkUrl == this.artworkUrl &&
          other.updatedAt == this.updatedAt &&
          other.height == this.height &&
          other.weight == this.weight &&
          other.generationId == this.generationId &&
          other.isDefault == this.isDefault);
}

class PokemonTableCompanion extends UpdateCompanion<PokemonRow> {
  final Value<int> id;
  final Value<int> dexNumber;
  final Value<String> name;
  final Value<String?> spriteUrl;
  final Value<String?> artworkUrl;
  final Value<DateTime> updatedAt;
  final Value<int?> height;
  final Value<int?> weight;
  final Value<int?> generationId;
  final Value<bool> isDefault;
  const PokemonTableCompanion({
    this.id = const Value.absent(),
    this.dexNumber = const Value.absent(),
    this.name = const Value.absent(),
    this.spriteUrl = const Value.absent(),
    this.artworkUrl = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.height = const Value.absent(),
    this.weight = const Value.absent(),
    this.generationId = const Value.absent(),
    this.isDefault = const Value.absent(),
  });
  PokemonTableCompanion.insert({
    this.id = const Value.absent(),
    required int dexNumber,
    required String name,
    this.spriteUrl = const Value.absent(),
    this.artworkUrl = const Value.absent(),
    required DateTime updatedAt,
    this.height = const Value.absent(),
    this.weight = const Value.absent(),
    this.generationId = const Value.absent(),
    this.isDefault = const Value.absent(),
  }) : dexNumber = Value(dexNumber),
       name = Value(name),
       updatedAt = Value(updatedAt);
  static Insertable<PokemonRow> custom({
    Expression<int>? id,
    Expression<int>? dexNumber,
    Expression<String>? name,
    Expression<String>? spriteUrl,
    Expression<String>? artworkUrl,
    Expression<DateTime>? updatedAt,
    Expression<int>? height,
    Expression<int>? weight,
    Expression<int>? generationId,
    Expression<bool>? isDefault,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (dexNumber != null) 'dex_number': dexNumber,
      if (name != null) 'name': name,
      if (spriteUrl != null) 'sprite_url': spriteUrl,
      if (artworkUrl != null) 'artwork_url': artworkUrl,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (height != null) 'height': height,
      if (weight != null) 'weight': weight,
      if (generationId != null) 'generation_id': generationId,
      if (isDefault != null) 'is_default': isDefault,
    });
  }

  PokemonTableCompanion copyWith({
    Value<int>? id,
    Value<int>? dexNumber,
    Value<String>? name,
    Value<String?>? spriteUrl,
    Value<String?>? artworkUrl,
    Value<DateTime>? updatedAt,
    Value<int?>? height,
    Value<int?>? weight,
    Value<int?>? generationId,
    Value<bool>? isDefault,
  }) {
    return PokemonTableCompanion(
      id: id ?? this.id,
      dexNumber: dexNumber ?? this.dexNumber,
      name: name ?? this.name,
      spriteUrl: spriteUrl ?? this.spriteUrl,
      artworkUrl: artworkUrl ?? this.artworkUrl,
      updatedAt: updatedAt ?? this.updatedAt,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      generationId: generationId ?? this.generationId,
      isDefault: isDefault ?? this.isDefault,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (dexNumber.present) {
      map['dex_number'] = Variable<int>(dexNumber.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (spriteUrl.present) {
      map['sprite_url'] = Variable<String>(spriteUrl.value);
    }
    if (artworkUrl.present) {
      map['artwork_url'] = Variable<String>(artworkUrl.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (height.present) {
      map['height'] = Variable<int>(height.value);
    }
    if (weight.present) {
      map['weight'] = Variable<int>(weight.value);
    }
    if (generationId.present) {
      map['generation_id'] = Variable<int>(generationId.value);
    }
    if (isDefault.present) {
      map['is_default'] = Variable<bool>(isDefault.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PokemonTableCompanion(')
          ..write('id: $id, ')
          ..write('dexNumber: $dexNumber, ')
          ..write('name: $name, ')
          ..write('spriteUrl: $spriteUrl, ')
          ..write('artworkUrl: $artworkUrl, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('height: $height, ')
          ..write('weight: $weight, ')
          ..write('generationId: $generationId, ')
          ..write('isDefault: $isDefault')
          ..write(')'))
        .toString();
  }
}

class $TypesTableTable extends TypesTable
    with TableInfo<$TypesTableTable, TypeRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TypesTableTable(this.attachedDatabase, [this._alias]);
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
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'types';
  @override
  VerificationContext validateIntegrity(
    Insertable<TypeRow> instance, {
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TypeRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TypeRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
    );
  }

  @override
  $TypesTableTable createAlias(String alias) {
    return $TypesTableTable(attachedDatabase, alias);
  }
}

class TypeRow extends DataClass implements Insertable<TypeRow> {
  final int id;
  final String name;
  const TypeRow({required this.id, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  TypesTableCompanion toCompanion(bool nullToAbsent) {
    return TypesTableCompanion(id: Value(id), name: Value(name));
  }

  factory TypeRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TypeRow(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  TypeRow copyWith({int? id, String? name}) =>
      TypeRow(id: id ?? this.id, name: name ?? this.name);
  TypeRow copyWithCompanion(TypesTableCompanion data) {
    return TypeRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TypeRow(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TypeRow && other.id == this.id && other.name == this.name);
}

class TypesTableCompanion extends UpdateCompanion<TypeRow> {
  final Value<int> id;
  final Value<String> name;
  const TypesTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  TypesTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
  }) : name = Value(name);
  static Insertable<TypeRow> custom({
    Expression<int>? id,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
    });
  }

  TypesTableCompanion copyWith({Value<int>? id, Value<String>? name}) {
    return TypesTableCompanion(id: id ?? this.id, name: name ?? this.name);
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
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TypesTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $PokemonTypesTableTable extends PokemonTypesTable
    with TableInfo<$PokemonTypesTableTable, PokemonTypeRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PokemonTypesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _pokemonIdMeta = const VerificationMeta(
    'pokemonId',
  );
  @override
  late final GeneratedColumn<int> pokemonId = GeneratedColumn<int>(
    'pokemon_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES pokemon (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _typeIdMeta = const VerificationMeta('typeId');
  @override
  late final GeneratedColumn<int> typeId = GeneratedColumn<int>(
    'type_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES types (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _slotMeta = const VerificationMeta('slot');
  @override
  late final GeneratedColumn<int> slot = GeneratedColumn<int>(
    'slot',
    aliasedName,
    false,
    check: () => slot.isIn([1, 2]),
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [pokemonId, typeId, slot];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pokemon_types';
  @override
  VerificationContext validateIntegrity(
    Insertable<PokemonTypeRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('pokemon_id')) {
      context.handle(
        _pokemonIdMeta,
        pokemonId.isAcceptableOrUnknown(data['pokemon_id']!, _pokemonIdMeta),
      );
    } else if (isInserting) {
      context.missing(_pokemonIdMeta);
    }
    if (data.containsKey('type_id')) {
      context.handle(
        _typeIdMeta,
        typeId.isAcceptableOrUnknown(data['type_id']!, _typeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_typeIdMeta);
    }
    if (data.containsKey('slot')) {
      context.handle(
        _slotMeta,
        slot.isAcceptableOrUnknown(data['slot']!, _slotMeta),
      );
    } else if (isInserting) {
      context.missing(_slotMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {pokemonId, slot};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {pokemonId, typeId},
  ];
  @override
  PokemonTypeRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PokemonTypeRow(
      pokemonId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pokemon_id'],
      )!,
      typeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}type_id'],
      )!,
      slot: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}slot'],
      )!,
    );
  }

  @override
  $PokemonTypesTableTable createAlias(String alias) {
    return $PokemonTypesTableTable(attachedDatabase, alias);
  }
}

class PokemonTypeRow extends DataClass implements Insertable<PokemonTypeRow> {
  final int pokemonId;
  final int typeId;
  final int slot;
  const PokemonTypeRow({
    required this.pokemonId,
    required this.typeId,
    required this.slot,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['pokemon_id'] = Variable<int>(pokemonId);
    map['type_id'] = Variable<int>(typeId);
    map['slot'] = Variable<int>(slot);
    return map;
  }

  PokemonTypesTableCompanion toCompanion(bool nullToAbsent) {
    return PokemonTypesTableCompanion(
      pokemonId: Value(pokemonId),
      typeId: Value(typeId),
      slot: Value(slot),
    );
  }

  factory PokemonTypeRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PokemonTypeRow(
      pokemonId: serializer.fromJson<int>(json['pokemonId']),
      typeId: serializer.fromJson<int>(json['typeId']),
      slot: serializer.fromJson<int>(json['slot']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'pokemonId': serializer.toJson<int>(pokemonId),
      'typeId': serializer.toJson<int>(typeId),
      'slot': serializer.toJson<int>(slot),
    };
  }

  PokemonTypeRow copyWith({int? pokemonId, int? typeId, int? slot}) =>
      PokemonTypeRow(
        pokemonId: pokemonId ?? this.pokemonId,
        typeId: typeId ?? this.typeId,
        slot: slot ?? this.slot,
      );
  PokemonTypeRow copyWithCompanion(PokemonTypesTableCompanion data) {
    return PokemonTypeRow(
      pokemonId: data.pokemonId.present ? data.pokemonId.value : this.pokemonId,
      typeId: data.typeId.present ? data.typeId.value : this.typeId,
      slot: data.slot.present ? data.slot.value : this.slot,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PokemonTypeRow(')
          ..write('pokemonId: $pokemonId, ')
          ..write('typeId: $typeId, ')
          ..write('slot: $slot')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(pokemonId, typeId, slot);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PokemonTypeRow &&
          other.pokemonId == this.pokemonId &&
          other.typeId == this.typeId &&
          other.slot == this.slot);
}

class PokemonTypesTableCompanion extends UpdateCompanion<PokemonTypeRow> {
  final Value<int> pokemonId;
  final Value<int> typeId;
  final Value<int> slot;
  final Value<int> rowid;
  const PokemonTypesTableCompanion({
    this.pokemonId = const Value.absent(),
    this.typeId = const Value.absent(),
    this.slot = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PokemonTypesTableCompanion.insert({
    required int pokemonId,
    required int typeId,
    required int slot,
    this.rowid = const Value.absent(),
  }) : pokemonId = Value(pokemonId),
       typeId = Value(typeId),
       slot = Value(slot);
  static Insertable<PokemonTypeRow> custom({
    Expression<int>? pokemonId,
    Expression<int>? typeId,
    Expression<int>? slot,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (pokemonId != null) 'pokemon_id': pokemonId,
      if (typeId != null) 'type_id': typeId,
      if (slot != null) 'slot': slot,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PokemonTypesTableCompanion copyWith({
    Value<int>? pokemonId,
    Value<int>? typeId,
    Value<int>? slot,
    Value<int>? rowid,
  }) {
    return PokemonTypesTableCompanion(
      pokemonId: pokemonId ?? this.pokemonId,
      typeId: typeId ?? this.typeId,
      slot: slot ?? this.slot,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (pokemonId.present) {
      map['pokemon_id'] = Variable<int>(pokemonId.value);
    }
    if (typeId.present) {
      map['type_id'] = Variable<int>(typeId.value);
    }
    if (slot.present) {
      map['slot'] = Variable<int>(slot.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PokemonTypesTableCompanion(')
          ..write('pokemonId: $pokemonId, ')
          ..write('typeId: $typeId, ')
          ..write('slot: $slot, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TypeEfficaciesTableTable extends TypeEfficaciesTable
    with TableInfo<$TypeEfficaciesTableTable, TypeEfficacyRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TypeEfficaciesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _defendingTypeIdMeta = const VerificationMeta(
    'defendingTypeId',
  );
  @override
  late final GeneratedColumn<int> defendingTypeId = GeneratedColumn<int>(
    'defending_type_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES types (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _attackingTypeIdMeta = const VerificationMeta(
    'attackingTypeId',
  );
  @override
  late final GeneratedColumn<int> attackingTypeId = GeneratedColumn<int>(
    'attacking_type_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES types (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _damageFactorMeta = const VerificationMeta(
    'damageFactor',
  );
  @override
  late final GeneratedColumn<int> damageFactor = GeneratedColumn<int>(
    'damage_factor',
    aliasedName,
    false,
    check: () => damageFactor.isIn([0, 50, 100, 200]),
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    defendingTypeId,
    attackingTypeId,
    damageFactor,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'type_efficacies';
  @override
  VerificationContext validateIntegrity(
    Insertable<TypeEfficacyRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('defending_type_id')) {
      context.handle(
        _defendingTypeIdMeta,
        defendingTypeId.isAcceptableOrUnknown(
          data['defending_type_id']!,
          _defendingTypeIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_defendingTypeIdMeta);
    }
    if (data.containsKey('attacking_type_id')) {
      context.handle(
        _attackingTypeIdMeta,
        attackingTypeId.isAcceptableOrUnknown(
          data['attacking_type_id']!,
          _attackingTypeIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_attackingTypeIdMeta);
    }
    if (data.containsKey('damage_factor')) {
      context.handle(
        _damageFactorMeta,
        damageFactor.isAcceptableOrUnknown(
          data['damage_factor']!,
          _damageFactorMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_damageFactorMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {defendingTypeId, attackingTypeId};
  @override
  TypeEfficacyRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TypeEfficacyRow(
      defendingTypeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}defending_type_id'],
      )!,
      attackingTypeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}attacking_type_id'],
      )!,
      damageFactor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}damage_factor'],
      )!,
    );
  }

  @override
  $TypeEfficaciesTableTable createAlias(String alias) {
    return $TypeEfficaciesTableTable(attachedDatabase, alias);
  }
}

class TypeEfficacyRow extends DataClass implements Insertable<TypeEfficacyRow> {
  final int defendingTypeId;
  final int attackingTypeId;
  final int damageFactor;
  const TypeEfficacyRow({
    required this.defendingTypeId,
    required this.attackingTypeId,
    required this.damageFactor,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['defending_type_id'] = Variable<int>(defendingTypeId);
    map['attacking_type_id'] = Variable<int>(attackingTypeId);
    map['damage_factor'] = Variable<int>(damageFactor);
    return map;
  }

  TypeEfficaciesTableCompanion toCompanion(bool nullToAbsent) {
    return TypeEfficaciesTableCompanion(
      defendingTypeId: Value(defendingTypeId),
      attackingTypeId: Value(attackingTypeId),
      damageFactor: Value(damageFactor),
    );
  }

  factory TypeEfficacyRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TypeEfficacyRow(
      defendingTypeId: serializer.fromJson<int>(json['defendingTypeId']),
      attackingTypeId: serializer.fromJson<int>(json['attackingTypeId']),
      damageFactor: serializer.fromJson<int>(json['damageFactor']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'defendingTypeId': serializer.toJson<int>(defendingTypeId),
      'attackingTypeId': serializer.toJson<int>(attackingTypeId),
      'damageFactor': serializer.toJson<int>(damageFactor),
    };
  }

  TypeEfficacyRow copyWith({
    int? defendingTypeId,
    int? attackingTypeId,
    int? damageFactor,
  }) => TypeEfficacyRow(
    defendingTypeId: defendingTypeId ?? this.defendingTypeId,
    attackingTypeId: attackingTypeId ?? this.attackingTypeId,
    damageFactor: damageFactor ?? this.damageFactor,
  );
  TypeEfficacyRow copyWithCompanion(TypeEfficaciesTableCompanion data) {
    return TypeEfficacyRow(
      defendingTypeId: data.defendingTypeId.present
          ? data.defendingTypeId.value
          : this.defendingTypeId,
      attackingTypeId: data.attackingTypeId.present
          ? data.attackingTypeId.value
          : this.attackingTypeId,
      damageFactor: data.damageFactor.present
          ? data.damageFactor.value
          : this.damageFactor,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TypeEfficacyRow(')
          ..write('defendingTypeId: $defendingTypeId, ')
          ..write('attackingTypeId: $attackingTypeId, ')
          ..write('damageFactor: $damageFactor')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(defendingTypeId, attackingTypeId, damageFactor);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TypeEfficacyRow &&
          other.defendingTypeId == this.defendingTypeId &&
          other.attackingTypeId == this.attackingTypeId &&
          other.damageFactor == this.damageFactor);
}

class TypeEfficaciesTableCompanion extends UpdateCompanion<TypeEfficacyRow> {
  final Value<int> defendingTypeId;
  final Value<int> attackingTypeId;
  final Value<int> damageFactor;
  final Value<int> rowid;
  const TypeEfficaciesTableCompanion({
    this.defendingTypeId = const Value.absent(),
    this.attackingTypeId = const Value.absent(),
    this.damageFactor = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TypeEfficaciesTableCompanion.insert({
    required int defendingTypeId,
    required int attackingTypeId,
    required int damageFactor,
    this.rowid = const Value.absent(),
  }) : defendingTypeId = Value(defendingTypeId),
       attackingTypeId = Value(attackingTypeId),
       damageFactor = Value(damageFactor);
  static Insertable<TypeEfficacyRow> custom({
    Expression<int>? defendingTypeId,
    Expression<int>? attackingTypeId,
    Expression<int>? damageFactor,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (defendingTypeId != null) 'defending_type_id': defendingTypeId,
      if (attackingTypeId != null) 'attacking_type_id': attackingTypeId,
      if (damageFactor != null) 'damage_factor': damageFactor,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TypeEfficaciesTableCompanion copyWith({
    Value<int>? defendingTypeId,
    Value<int>? attackingTypeId,
    Value<int>? damageFactor,
    Value<int>? rowid,
  }) {
    return TypeEfficaciesTableCompanion(
      defendingTypeId: defendingTypeId ?? this.defendingTypeId,
      attackingTypeId: attackingTypeId ?? this.attackingTypeId,
      damageFactor: damageFactor ?? this.damageFactor,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (defendingTypeId.present) {
      map['defending_type_id'] = Variable<int>(defendingTypeId.value);
    }
    if (attackingTypeId.present) {
      map['attacking_type_id'] = Variable<int>(attackingTypeId.value);
    }
    if (damageFactor.present) {
      map['damage_factor'] = Variable<int>(damageFactor.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TypeEfficaciesTableCompanion(')
          ..write('defendingTypeId: $defendingTypeId, ')
          ..write('attackingTypeId: $attackingTypeId, ')
          ..write('damageFactor: $damageFactor, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $StatsTableTable extends StatsTable
    with TableInfo<$StatsTableTable, StatRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StatsTableTable(this.attachedDatabase, [this._alias]);
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
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'stats';
  @override
  VerificationContext validateIntegrity(
    Insertable<StatRow> instance, {
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StatRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StatRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
    );
  }

  @override
  $StatsTableTable createAlias(String alias) {
    return $StatsTableTable(attachedDatabase, alias);
  }
}

class StatRow extends DataClass implements Insertable<StatRow> {
  final int id;
  final String name;
  const StatRow({required this.id, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  StatsTableCompanion toCompanion(bool nullToAbsent) {
    return StatsTableCompanion(id: Value(id), name: Value(name));
  }

  factory StatRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StatRow(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  StatRow copyWith({int? id, String? name}) =>
      StatRow(id: id ?? this.id, name: name ?? this.name);
  StatRow copyWithCompanion(StatsTableCompanion data) {
    return StatRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StatRow(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StatRow && other.id == this.id && other.name == this.name);
}

class StatsTableCompanion extends UpdateCompanion<StatRow> {
  final Value<int> id;
  final Value<String> name;
  const StatsTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  StatsTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
  }) : name = Value(name);
  static Insertable<StatRow> custom({
    Expression<int>? id,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
    });
  }

  StatsTableCompanion copyWith({Value<int>? id, Value<String>? name}) {
    return StatsTableCompanion(id: id ?? this.id, name: name ?? this.name);
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
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StatsTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $PokemonStatsTableTable extends PokemonStatsTable
    with TableInfo<$PokemonStatsTableTable, PokemonStatRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PokemonStatsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _pokemonIdMeta = const VerificationMeta(
    'pokemonId',
  );
  @override
  late final GeneratedColumn<int> pokemonId = GeneratedColumn<int>(
    'pokemon_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES pokemon (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _statIdMeta = const VerificationMeta('statId');
  @override
  late final GeneratedColumn<int> statId = GeneratedColumn<int>(
    'stat_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES stats (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _baseStatMeta = const VerificationMeta(
    'baseStat',
  );
  @override
  late final GeneratedColumn<int> baseStat = GeneratedColumn<int>(
    'base_stat',
    aliasedName,
    false,
    check: () => ComparableExpr(baseStat).isBetweenValues(1, 255),
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _effortMeta = const VerificationMeta('effort');
  @override
  late final GeneratedColumn<int> effort = GeneratedColumn<int>(
    'effort',
    aliasedName,
    false,
    check: () => ComparableExpr(effort).isBetweenValues(0, 3),
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [pokemonId, statId, baseStat, effort];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pokemon_stats';
  @override
  VerificationContext validateIntegrity(
    Insertable<PokemonStatRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('pokemon_id')) {
      context.handle(
        _pokemonIdMeta,
        pokemonId.isAcceptableOrUnknown(data['pokemon_id']!, _pokemonIdMeta),
      );
    } else if (isInserting) {
      context.missing(_pokemonIdMeta);
    }
    if (data.containsKey('stat_id')) {
      context.handle(
        _statIdMeta,
        statId.isAcceptableOrUnknown(data['stat_id']!, _statIdMeta),
      );
    } else if (isInserting) {
      context.missing(_statIdMeta);
    }
    if (data.containsKey('base_stat')) {
      context.handle(
        _baseStatMeta,
        baseStat.isAcceptableOrUnknown(data['base_stat']!, _baseStatMeta),
      );
    } else if (isInserting) {
      context.missing(_baseStatMeta);
    }
    if (data.containsKey('effort')) {
      context.handle(
        _effortMeta,
        effort.isAcceptableOrUnknown(data['effort']!, _effortMeta),
      );
    } else if (isInserting) {
      context.missing(_effortMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {pokemonId, statId};
  @override
  PokemonStatRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PokemonStatRow(
      pokemonId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pokemon_id'],
      )!,
      statId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}stat_id'],
      )!,
      baseStat: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}base_stat'],
      )!,
      effort: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}effort'],
      )!,
    );
  }

  @override
  $PokemonStatsTableTable createAlias(String alias) {
    return $PokemonStatsTableTable(attachedDatabase, alias);
  }
}

class PokemonStatRow extends DataClass implements Insertable<PokemonStatRow> {
  final int pokemonId;
  final int statId;
  final int baseStat;
  final int effort;
  const PokemonStatRow({
    required this.pokemonId,
    required this.statId,
    required this.baseStat,
    required this.effort,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['pokemon_id'] = Variable<int>(pokemonId);
    map['stat_id'] = Variable<int>(statId);
    map['base_stat'] = Variable<int>(baseStat);
    map['effort'] = Variable<int>(effort);
    return map;
  }

  PokemonStatsTableCompanion toCompanion(bool nullToAbsent) {
    return PokemonStatsTableCompanion(
      pokemonId: Value(pokemonId),
      statId: Value(statId),
      baseStat: Value(baseStat),
      effort: Value(effort),
    );
  }

  factory PokemonStatRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PokemonStatRow(
      pokemonId: serializer.fromJson<int>(json['pokemonId']),
      statId: serializer.fromJson<int>(json['statId']),
      baseStat: serializer.fromJson<int>(json['baseStat']),
      effort: serializer.fromJson<int>(json['effort']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'pokemonId': serializer.toJson<int>(pokemonId),
      'statId': serializer.toJson<int>(statId),
      'baseStat': serializer.toJson<int>(baseStat),
      'effort': serializer.toJson<int>(effort),
    };
  }

  PokemonStatRow copyWith({
    int? pokemonId,
    int? statId,
    int? baseStat,
    int? effort,
  }) => PokemonStatRow(
    pokemonId: pokemonId ?? this.pokemonId,
    statId: statId ?? this.statId,
    baseStat: baseStat ?? this.baseStat,
    effort: effort ?? this.effort,
  );
  PokemonStatRow copyWithCompanion(PokemonStatsTableCompanion data) {
    return PokemonStatRow(
      pokemonId: data.pokemonId.present ? data.pokemonId.value : this.pokemonId,
      statId: data.statId.present ? data.statId.value : this.statId,
      baseStat: data.baseStat.present ? data.baseStat.value : this.baseStat,
      effort: data.effort.present ? data.effort.value : this.effort,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PokemonStatRow(')
          ..write('pokemonId: $pokemonId, ')
          ..write('statId: $statId, ')
          ..write('baseStat: $baseStat, ')
          ..write('effort: $effort')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(pokemonId, statId, baseStat, effort);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PokemonStatRow &&
          other.pokemonId == this.pokemonId &&
          other.statId == this.statId &&
          other.baseStat == this.baseStat &&
          other.effort == this.effort);
}

class PokemonStatsTableCompanion extends UpdateCompanion<PokemonStatRow> {
  final Value<int> pokemonId;
  final Value<int> statId;
  final Value<int> baseStat;
  final Value<int> effort;
  final Value<int> rowid;
  const PokemonStatsTableCompanion({
    this.pokemonId = const Value.absent(),
    this.statId = const Value.absent(),
    this.baseStat = const Value.absent(),
    this.effort = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PokemonStatsTableCompanion.insert({
    required int pokemonId,
    required int statId,
    required int baseStat,
    required int effort,
    this.rowid = const Value.absent(),
  }) : pokemonId = Value(pokemonId),
       statId = Value(statId),
       baseStat = Value(baseStat),
       effort = Value(effort);
  static Insertable<PokemonStatRow> custom({
    Expression<int>? pokemonId,
    Expression<int>? statId,
    Expression<int>? baseStat,
    Expression<int>? effort,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (pokemonId != null) 'pokemon_id': pokemonId,
      if (statId != null) 'stat_id': statId,
      if (baseStat != null) 'base_stat': baseStat,
      if (effort != null) 'effort': effort,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PokemonStatsTableCompanion copyWith({
    Value<int>? pokemonId,
    Value<int>? statId,
    Value<int>? baseStat,
    Value<int>? effort,
    Value<int>? rowid,
  }) {
    return PokemonStatsTableCompanion(
      pokemonId: pokemonId ?? this.pokemonId,
      statId: statId ?? this.statId,
      baseStat: baseStat ?? this.baseStat,
      effort: effort ?? this.effort,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (pokemonId.present) {
      map['pokemon_id'] = Variable<int>(pokemonId.value);
    }
    if (statId.present) {
      map['stat_id'] = Variable<int>(statId.value);
    }
    if (baseStat.present) {
      map['base_stat'] = Variable<int>(baseStat.value);
    }
    if (effort.present) {
      map['effort'] = Variable<int>(effort.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PokemonStatsTableCompanion(')
          ..write('pokemonId: $pokemonId, ')
          ..write('statId: $statId, ')
          ..write('baseStat: $baseStat, ')
          ..write('effort: $effort, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $EggGroupsTableTable extends EggGroupsTable
    with TableInfo<$EggGroupsTableTable, EggGroupRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EggGroupsTableTable(this.attachedDatabase, [this._alias]);
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
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'egg_groups';
  @override
  VerificationContext validateIntegrity(
    Insertable<EggGroupRow> instance, {
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EggGroupRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EggGroupRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
    );
  }

  @override
  $EggGroupsTableTable createAlias(String alias) {
    return $EggGroupsTableTable(attachedDatabase, alias);
  }
}

class EggGroupRow extends DataClass implements Insertable<EggGroupRow> {
  final int id;
  final String name;
  const EggGroupRow({required this.id, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  EggGroupsTableCompanion toCompanion(bool nullToAbsent) {
    return EggGroupsTableCompanion(id: Value(id), name: Value(name));
  }

  factory EggGroupRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EggGroupRow(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  EggGroupRow copyWith({int? id, String? name}) =>
      EggGroupRow(id: id ?? this.id, name: name ?? this.name);
  EggGroupRow copyWithCompanion(EggGroupsTableCompanion data) {
    return EggGroupRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EggGroupRow(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EggGroupRow && other.id == this.id && other.name == this.name);
}

class EggGroupsTableCompanion extends UpdateCompanion<EggGroupRow> {
  final Value<int> id;
  final Value<String> name;
  const EggGroupsTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  EggGroupsTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
  }) : name = Value(name);
  static Insertable<EggGroupRow> custom({
    Expression<int>? id,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
    });
  }

  EggGroupsTableCompanion copyWith({Value<int>? id, Value<String>? name}) {
    return EggGroupsTableCompanion(id: id ?? this.id, name: name ?? this.name);
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
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EggGroupsTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $PokemonEggGroupsTableTable extends PokemonEggGroupsTable
    with TableInfo<$PokemonEggGroupsTableTable, PokemonEggGroupRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PokemonEggGroupsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _pokemonIdMeta = const VerificationMeta(
    'pokemonId',
  );
  @override
  late final GeneratedColumn<int> pokemonId = GeneratedColumn<int>(
    'pokemon_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES pokemon (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _eggGroupIdMeta = const VerificationMeta(
    'eggGroupId',
  );
  @override
  late final GeneratedColumn<int> eggGroupId = GeneratedColumn<int>(
    'egg_group_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES egg_groups (id) ON DELETE CASCADE',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [pokemonId, eggGroupId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pokemon_egg_groups';
  @override
  VerificationContext validateIntegrity(
    Insertable<PokemonEggGroupRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('pokemon_id')) {
      context.handle(
        _pokemonIdMeta,
        pokemonId.isAcceptableOrUnknown(data['pokemon_id']!, _pokemonIdMeta),
      );
    } else if (isInserting) {
      context.missing(_pokemonIdMeta);
    }
    if (data.containsKey('egg_group_id')) {
      context.handle(
        _eggGroupIdMeta,
        eggGroupId.isAcceptableOrUnknown(
          data['egg_group_id']!,
          _eggGroupIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_eggGroupIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {pokemonId, eggGroupId};
  @override
  PokemonEggGroupRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PokemonEggGroupRow(
      pokemonId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pokemon_id'],
      )!,
      eggGroupId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}egg_group_id'],
      )!,
    );
  }

  @override
  $PokemonEggGroupsTableTable createAlias(String alias) {
    return $PokemonEggGroupsTableTable(attachedDatabase, alias);
  }
}

class PokemonEggGroupRow extends DataClass
    implements Insertable<PokemonEggGroupRow> {
  final int pokemonId;
  final int eggGroupId;
  const PokemonEggGroupRow({required this.pokemonId, required this.eggGroupId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['pokemon_id'] = Variable<int>(pokemonId);
    map['egg_group_id'] = Variable<int>(eggGroupId);
    return map;
  }

  PokemonEggGroupsTableCompanion toCompanion(bool nullToAbsent) {
    return PokemonEggGroupsTableCompanion(
      pokemonId: Value(pokemonId),
      eggGroupId: Value(eggGroupId),
    );
  }

  factory PokemonEggGroupRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PokemonEggGroupRow(
      pokemonId: serializer.fromJson<int>(json['pokemonId']),
      eggGroupId: serializer.fromJson<int>(json['eggGroupId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'pokemonId': serializer.toJson<int>(pokemonId),
      'eggGroupId': serializer.toJson<int>(eggGroupId),
    };
  }

  PokemonEggGroupRow copyWith({int? pokemonId, int? eggGroupId}) =>
      PokemonEggGroupRow(
        pokemonId: pokemonId ?? this.pokemonId,
        eggGroupId: eggGroupId ?? this.eggGroupId,
      );
  PokemonEggGroupRow copyWithCompanion(PokemonEggGroupsTableCompanion data) {
    return PokemonEggGroupRow(
      pokemonId: data.pokemonId.present ? data.pokemonId.value : this.pokemonId,
      eggGroupId: data.eggGroupId.present
          ? data.eggGroupId.value
          : this.eggGroupId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PokemonEggGroupRow(')
          ..write('pokemonId: $pokemonId, ')
          ..write('eggGroupId: $eggGroupId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(pokemonId, eggGroupId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PokemonEggGroupRow &&
          other.pokemonId == this.pokemonId &&
          other.eggGroupId == this.eggGroupId);
}

class PokemonEggGroupsTableCompanion
    extends UpdateCompanion<PokemonEggGroupRow> {
  final Value<int> pokemonId;
  final Value<int> eggGroupId;
  final Value<int> rowid;
  const PokemonEggGroupsTableCompanion({
    this.pokemonId = const Value.absent(),
    this.eggGroupId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PokemonEggGroupsTableCompanion.insert({
    required int pokemonId,
    required int eggGroupId,
    this.rowid = const Value.absent(),
  }) : pokemonId = Value(pokemonId),
       eggGroupId = Value(eggGroupId);
  static Insertable<PokemonEggGroupRow> custom({
    Expression<int>? pokemonId,
    Expression<int>? eggGroupId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (pokemonId != null) 'pokemon_id': pokemonId,
      if (eggGroupId != null) 'egg_group_id': eggGroupId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PokemonEggGroupsTableCompanion copyWith({
    Value<int>? pokemonId,
    Value<int>? eggGroupId,
    Value<int>? rowid,
  }) {
    return PokemonEggGroupsTableCompanion(
      pokemonId: pokemonId ?? this.pokemonId,
      eggGroupId: eggGroupId ?? this.eggGroupId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (pokemonId.present) {
      map['pokemon_id'] = Variable<int>(pokemonId.value);
    }
    if (eggGroupId.present) {
      map['egg_group_id'] = Variable<int>(eggGroupId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PokemonEggGroupsTableCompanion(')
          ..write('pokemonId: $pokemonId, ')
          ..write('eggGroupId: $eggGroupId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AbilitiesTableTable extends AbilitiesTable
    with TableInfo<$AbilitiesTableTable, AbilityRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AbilitiesTableTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _nameEsMeta = const VerificationMeta('nameEs');
  @override
  late final GeneratedColumn<String> nameEs = GeneratedColumn<String>(
    'name_es',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameEnMeta = const VerificationMeta('nameEn');
  @override
  late final GeneratedColumn<String> nameEn = GeneratedColumn<String>(
    'name_en',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _effectEsMeta = const VerificationMeta(
    'effectEs',
  );
  @override
  late final GeneratedColumn<String> effectEs = GeneratedColumn<String>(
    'effect_es',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _effectEnMeta = const VerificationMeta(
    'effectEn',
  );
  @override
  late final GeneratedColumn<String> effectEn = GeneratedColumn<String>(
    'effect_en',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    nameEs,
    nameEn,
    effectEs,
    effectEn,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'abilities';
  @override
  VerificationContext validateIntegrity(
    Insertable<AbilityRow> instance, {
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
    if (data.containsKey('name_es')) {
      context.handle(
        _nameEsMeta,
        nameEs.isAcceptableOrUnknown(data['name_es']!, _nameEsMeta),
      );
    }
    if (data.containsKey('name_en')) {
      context.handle(
        _nameEnMeta,
        nameEn.isAcceptableOrUnknown(data['name_en']!, _nameEnMeta),
      );
    }
    if (data.containsKey('effect_es')) {
      context.handle(
        _effectEsMeta,
        effectEs.isAcceptableOrUnknown(data['effect_es']!, _effectEsMeta),
      );
    }
    if (data.containsKey('effect_en')) {
      context.handle(
        _effectEnMeta,
        effectEn.isAcceptableOrUnknown(data['effect_en']!, _effectEnMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AbilityRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AbilityRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      nameEs: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_es'],
      ),
      nameEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_en'],
      ),
      effectEs: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}effect_es'],
      ),
      effectEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}effect_en'],
      ),
    );
  }

  @override
  $AbilitiesTableTable createAlias(String alias) {
    return $AbilitiesTableTable(attachedDatabase, alias);
  }
}

class AbilityRow extends DataClass implements Insertable<AbilityRow> {
  final int id;
  final String name;
  final String? nameEs;
  final String? nameEn;
  final String? effectEs;
  final String? effectEn;
  const AbilityRow({
    required this.id,
    required this.name,
    this.nameEs,
    this.nameEn,
    this.effectEs,
    this.effectEn,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || nameEs != null) {
      map['name_es'] = Variable<String>(nameEs);
    }
    if (!nullToAbsent || nameEn != null) {
      map['name_en'] = Variable<String>(nameEn);
    }
    if (!nullToAbsent || effectEs != null) {
      map['effect_es'] = Variable<String>(effectEs);
    }
    if (!nullToAbsent || effectEn != null) {
      map['effect_en'] = Variable<String>(effectEn);
    }
    return map;
  }

  AbilitiesTableCompanion toCompanion(bool nullToAbsent) {
    return AbilitiesTableCompanion(
      id: Value(id),
      name: Value(name),
      nameEs: nameEs == null && nullToAbsent
          ? const Value.absent()
          : Value(nameEs),
      nameEn: nameEn == null && nullToAbsent
          ? const Value.absent()
          : Value(nameEn),
      effectEs: effectEs == null && nullToAbsent
          ? const Value.absent()
          : Value(effectEs),
      effectEn: effectEn == null && nullToAbsent
          ? const Value.absent()
          : Value(effectEn),
    );
  }

  factory AbilityRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AbilityRow(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      nameEs: serializer.fromJson<String?>(json['nameEs']),
      nameEn: serializer.fromJson<String?>(json['nameEn']),
      effectEs: serializer.fromJson<String?>(json['effectEs']),
      effectEn: serializer.fromJson<String?>(json['effectEn']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'nameEs': serializer.toJson<String?>(nameEs),
      'nameEn': serializer.toJson<String?>(nameEn),
      'effectEs': serializer.toJson<String?>(effectEs),
      'effectEn': serializer.toJson<String?>(effectEn),
    };
  }

  AbilityRow copyWith({
    int? id,
    String? name,
    Value<String?> nameEs = const Value.absent(),
    Value<String?> nameEn = const Value.absent(),
    Value<String?> effectEs = const Value.absent(),
    Value<String?> effectEn = const Value.absent(),
  }) => AbilityRow(
    id: id ?? this.id,
    name: name ?? this.name,
    nameEs: nameEs.present ? nameEs.value : this.nameEs,
    nameEn: nameEn.present ? nameEn.value : this.nameEn,
    effectEs: effectEs.present ? effectEs.value : this.effectEs,
    effectEn: effectEn.present ? effectEn.value : this.effectEn,
  );
  AbilityRow copyWithCompanion(AbilitiesTableCompanion data) {
    return AbilityRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      nameEs: data.nameEs.present ? data.nameEs.value : this.nameEs,
      nameEn: data.nameEn.present ? data.nameEn.value : this.nameEn,
      effectEs: data.effectEs.present ? data.effectEs.value : this.effectEs,
      effectEn: data.effectEn.present ? data.effectEn.value : this.effectEn,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AbilityRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('nameEs: $nameEs, ')
          ..write('nameEn: $nameEn, ')
          ..write('effectEs: $effectEs, ')
          ..write('effectEn: $effectEn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, nameEs, nameEn, effectEs, effectEn);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AbilityRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.nameEs == this.nameEs &&
          other.nameEn == this.nameEn &&
          other.effectEs == this.effectEs &&
          other.effectEn == this.effectEn);
}

class AbilitiesTableCompanion extends UpdateCompanion<AbilityRow> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> nameEs;
  final Value<String?> nameEn;
  final Value<String?> effectEs;
  final Value<String?> effectEn;
  const AbilitiesTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.nameEs = const Value.absent(),
    this.nameEn = const Value.absent(),
    this.effectEs = const Value.absent(),
    this.effectEn = const Value.absent(),
  });
  AbilitiesTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.nameEs = const Value.absent(),
    this.nameEn = const Value.absent(),
    this.effectEs = const Value.absent(),
    this.effectEn = const Value.absent(),
  }) : name = Value(name);
  static Insertable<AbilityRow> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? nameEs,
    Expression<String>? nameEn,
    Expression<String>? effectEs,
    Expression<String>? effectEn,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (nameEs != null) 'name_es': nameEs,
      if (nameEn != null) 'name_en': nameEn,
      if (effectEs != null) 'effect_es': effectEs,
      if (effectEn != null) 'effect_en': effectEn,
    });
  }

  AbilitiesTableCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? nameEs,
    Value<String?>? nameEn,
    Value<String?>? effectEs,
    Value<String?>? effectEn,
  }) {
    return AbilitiesTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      nameEs: nameEs ?? this.nameEs,
      nameEn: nameEn ?? this.nameEn,
      effectEs: effectEs ?? this.effectEs,
      effectEn: effectEn ?? this.effectEn,
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
    if (nameEs.present) {
      map['name_es'] = Variable<String>(nameEs.value);
    }
    if (nameEn.present) {
      map['name_en'] = Variable<String>(nameEn.value);
    }
    if (effectEs.present) {
      map['effect_es'] = Variable<String>(effectEs.value);
    }
    if (effectEn.present) {
      map['effect_en'] = Variable<String>(effectEn.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AbilitiesTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('nameEs: $nameEs, ')
          ..write('nameEn: $nameEn, ')
          ..write('effectEs: $effectEs, ')
          ..write('effectEn: $effectEn')
          ..write(')'))
        .toString();
  }
}

class $PokemonAbilitiesTableTable extends PokemonAbilitiesTable
    with TableInfo<$PokemonAbilitiesTableTable, PokemonAbilityRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PokemonAbilitiesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _pokemonIdMeta = const VerificationMeta(
    'pokemonId',
  );
  @override
  late final GeneratedColumn<int> pokemonId = GeneratedColumn<int>(
    'pokemon_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES pokemon (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _abilityIdMeta = const VerificationMeta(
    'abilityId',
  );
  @override
  late final GeneratedColumn<int> abilityId = GeneratedColumn<int>(
    'ability_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES abilities (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _slotMeta = const VerificationMeta('slot');
  @override
  late final GeneratedColumn<int> slot = GeneratedColumn<int>(
    'slot',
    aliasedName,
    false,
    check: () => ComparableExpr(slot).isBetweenValues(1, 3),
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isHiddenMeta = const VerificationMeta(
    'isHidden',
  );
  @override
  late final GeneratedColumn<bool> isHidden = GeneratedColumn<bool>(
    'is_hidden',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_hidden" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [pokemonId, abilityId, slot, isHidden];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pokemon_abilities';
  @override
  VerificationContext validateIntegrity(
    Insertable<PokemonAbilityRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('pokemon_id')) {
      context.handle(
        _pokemonIdMeta,
        pokemonId.isAcceptableOrUnknown(data['pokemon_id']!, _pokemonIdMeta),
      );
    } else if (isInserting) {
      context.missing(_pokemonIdMeta);
    }
    if (data.containsKey('ability_id')) {
      context.handle(
        _abilityIdMeta,
        abilityId.isAcceptableOrUnknown(data['ability_id']!, _abilityIdMeta),
      );
    } else if (isInserting) {
      context.missing(_abilityIdMeta);
    }
    if (data.containsKey('slot')) {
      context.handle(
        _slotMeta,
        slot.isAcceptableOrUnknown(data['slot']!, _slotMeta),
      );
    } else if (isInserting) {
      context.missing(_slotMeta);
    }
    if (data.containsKey('is_hidden')) {
      context.handle(
        _isHiddenMeta,
        isHidden.isAcceptableOrUnknown(data['is_hidden']!, _isHiddenMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {pokemonId, slot};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {pokemonId, abilityId},
  ];
  @override
  PokemonAbilityRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PokemonAbilityRow(
      pokemonId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pokemon_id'],
      )!,
      abilityId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ability_id'],
      )!,
      slot: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}slot'],
      )!,
      isHidden: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_hidden'],
      )!,
    );
  }

  @override
  $PokemonAbilitiesTableTable createAlias(String alias) {
    return $PokemonAbilitiesTableTable(attachedDatabase, alias);
  }
}

class PokemonAbilityRow extends DataClass
    implements Insertable<PokemonAbilityRow> {
  final int pokemonId;
  final int abilityId;
  final int slot;
  final bool isHidden;
  const PokemonAbilityRow({
    required this.pokemonId,
    required this.abilityId,
    required this.slot,
    required this.isHidden,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['pokemon_id'] = Variable<int>(pokemonId);
    map['ability_id'] = Variable<int>(abilityId);
    map['slot'] = Variable<int>(slot);
    map['is_hidden'] = Variable<bool>(isHidden);
    return map;
  }

  PokemonAbilitiesTableCompanion toCompanion(bool nullToAbsent) {
    return PokemonAbilitiesTableCompanion(
      pokemonId: Value(pokemonId),
      abilityId: Value(abilityId),
      slot: Value(slot),
      isHidden: Value(isHidden),
    );
  }

  factory PokemonAbilityRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PokemonAbilityRow(
      pokemonId: serializer.fromJson<int>(json['pokemonId']),
      abilityId: serializer.fromJson<int>(json['abilityId']),
      slot: serializer.fromJson<int>(json['slot']),
      isHidden: serializer.fromJson<bool>(json['isHidden']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'pokemonId': serializer.toJson<int>(pokemonId),
      'abilityId': serializer.toJson<int>(abilityId),
      'slot': serializer.toJson<int>(slot),
      'isHidden': serializer.toJson<bool>(isHidden),
    };
  }

  PokemonAbilityRow copyWith({
    int? pokemonId,
    int? abilityId,
    int? slot,
    bool? isHidden,
  }) => PokemonAbilityRow(
    pokemonId: pokemonId ?? this.pokemonId,
    abilityId: abilityId ?? this.abilityId,
    slot: slot ?? this.slot,
    isHidden: isHidden ?? this.isHidden,
  );
  PokemonAbilityRow copyWithCompanion(PokemonAbilitiesTableCompanion data) {
    return PokemonAbilityRow(
      pokemonId: data.pokemonId.present ? data.pokemonId.value : this.pokemonId,
      abilityId: data.abilityId.present ? data.abilityId.value : this.abilityId,
      slot: data.slot.present ? data.slot.value : this.slot,
      isHidden: data.isHidden.present ? data.isHidden.value : this.isHidden,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PokemonAbilityRow(')
          ..write('pokemonId: $pokemonId, ')
          ..write('abilityId: $abilityId, ')
          ..write('slot: $slot, ')
          ..write('isHidden: $isHidden')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(pokemonId, abilityId, slot, isHidden);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PokemonAbilityRow &&
          other.pokemonId == this.pokemonId &&
          other.abilityId == this.abilityId &&
          other.slot == this.slot &&
          other.isHidden == this.isHidden);
}

class PokemonAbilitiesTableCompanion
    extends UpdateCompanion<PokemonAbilityRow> {
  final Value<int> pokemonId;
  final Value<int> abilityId;
  final Value<int> slot;
  final Value<bool> isHidden;
  final Value<int> rowid;
  const PokemonAbilitiesTableCompanion({
    this.pokemonId = const Value.absent(),
    this.abilityId = const Value.absent(),
    this.slot = const Value.absent(),
    this.isHidden = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PokemonAbilitiesTableCompanion.insert({
    required int pokemonId,
    required int abilityId,
    required int slot,
    this.isHidden = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : pokemonId = Value(pokemonId),
       abilityId = Value(abilityId),
       slot = Value(slot);
  static Insertable<PokemonAbilityRow> custom({
    Expression<int>? pokemonId,
    Expression<int>? abilityId,
    Expression<int>? slot,
    Expression<bool>? isHidden,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (pokemonId != null) 'pokemon_id': pokemonId,
      if (abilityId != null) 'ability_id': abilityId,
      if (slot != null) 'slot': slot,
      if (isHidden != null) 'is_hidden': isHidden,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PokemonAbilitiesTableCompanion copyWith({
    Value<int>? pokemonId,
    Value<int>? abilityId,
    Value<int>? slot,
    Value<bool>? isHidden,
    Value<int>? rowid,
  }) {
    return PokemonAbilitiesTableCompanion(
      pokemonId: pokemonId ?? this.pokemonId,
      abilityId: abilityId ?? this.abilityId,
      slot: slot ?? this.slot,
      isHidden: isHidden ?? this.isHidden,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (pokemonId.present) {
      map['pokemon_id'] = Variable<int>(pokemonId.value);
    }
    if (abilityId.present) {
      map['ability_id'] = Variable<int>(abilityId.value);
    }
    if (slot.present) {
      map['slot'] = Variable<int>(slot.value);
    }
    if (isHidden.present) {
      map['is_hidden'] = Variable<bool>(isHidden.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PokemonAbilitiesTableCompanion(')
          ..write('pokemonId: $pokemonId, ')
          ..write('abilityId: $abilityId, ')
          ..write('slot: $slot, ')
          ..write('isHidden: $isHidden, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $EvolutionSpeciesTableTable extends EvolutionSpeciesTable
    with TableInfo<$EvolutionSpeciesTableTable, EvolutionSpeciesRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EvolutionSpeciesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _speciesIdMeta = const VerificationMeta(
    'speciesId',
  );
  @override
  late final GeneratedColumn<int> speciesId = GeneratedColumn<int>(
    'species_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _chainIdMeta = const VerificationMeta(
    'chainId',
  );
  @override
  late final GeneratedColumn<int> chainId = GeneratedColumn<int>(
    'chain_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _evolvesFromIdMeta = const VerificationMeta(
    'evolvesFromId',
  );
  @override
  late final GeneratedColumn<int> evolvesFromId = GeneratedColumn<int>(
    'evolves_from_id',
    aliasedName,
    true,
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
  @override
  List<GeneratedColumn> get $columns => [
    speciesId,
    chainId,
    evolvesFromId,
    name,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'evolution_species';
  @override
  VerificationContext validateIntegrity(
    Insertable<EvolutionSpeciesRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('species_id')) {
      context.handle(
        _speciesIdMeta,
        speciesId.isAcceptableOrUnknown(data['species_id']!, _speciesIdMeta),
      );
    }
    if (data.containsKey('chain_id')) {
      context.handle(
        _chainIdMeta,
        chainId.isAcceptableOrUnknown(data['chain_id']!, _chainIdMeta),
      );
    } else if (isInserting) {
      context.missing(_chainIdMeta);
    }
    if (data.containsKey('evolves_from_id')) {
      context.handle(
        _evolvesFromIdMeta,
        evolvesFromId.isAcceptableOrUnknown(
          data['evolves_from_id']!,
          _evolvesFromIdMeta,
        ),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {speciesId};
  @override
  EvolutionSpeciesRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EvolutionSpeciesRow(
      speciesId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}species_id'],
      )!,
      chainId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}chain_id'],
      )!,
      evolvesFromId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}evolves_from_id'],
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
    );
  }

  @override
  $EvolutionSpeciesTableTable createAlias(String alias) {
    return $EvolutionSpeciesTableTable(attachedDatabase, alias);
  }
}

class EvolutionSpeciesRow extends DataClass
    implements Insertable<EvolutionSpeciesRow> {
  final int speciesId;
  final int chainId;
  final int? evolvesFromId;
  final String name;
  const EvolutionSpeciesRow({
    required this.speciesId,
    required this.chainId,
    this.evolvesFromId,
    required this.name,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['species_id'] = Variable<int>(speciesId);
    map['chain_id'] = Variable<int>(chainId);
    if (!nullToAbsent || evolvesFromId != null) {
      map['evolves_from_id'] = Variable<int>(evolvesFromId);
    }
    map['name'] = Variable<String>(name);
    return map;
  }

  EvolutionSpeciesTableCompanion toCompanion(bool nullToAbsent) {
    return EvolutionSpeciesTableCompanion(
      speciesId: Value(speciesId),
      chainId: Value(chainId),
      evolvesFromId: evolvesFromId == null && nullToAbsent
          ? const Value.absent()
          : Value(evolvesFromId),
      name: Value(name),
    );
  }

  factory EvolutionSpeciesRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EvolutionSpeciesRow(
      speciesId: serializer.fromJson<int>(json['speciesId']),
      chainId: serializer.fromJson<int>(json['chainId']),
      evolvesFromId: serializer.fromJson<int?>(json['evolvesFromId']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'speciesId': serializer.toJson<int>(speciesId),
      'chainId': serializer.toJson<int>(chainId),
      'evolvesFromId': serializer.toJson<int?>(evolvesFromId),
      'name': serializer.toJson<String>(name),
    };
  }

  EvolutionSpeciesRow copyWith({
    int? speciesId,
    int? chainId,
    Value<int?> evolvesFromId = const Value.absent(),
    String? name,
  }) => EvolutionSpeciesRow(
    speciesId: speciesId ?? this.speciesId,
    chainId: chainId ?? this.chainId,
    evolvesFromId: evolvesFromId.present
        ? evolvesFromId.value
        : this.evolvesFromId,
    name: name ?? this.name,
  );
  EvolutionSpeciesRow copyWithCompanion(EvolutionSpeciesTableCompanion data) {
    return EvolutionSpeciesRow(
      speciesId: data.speciesId.present ? data.speciesId.value : this.speciesId,
      chainId: data.chainId.present ? data.chainId.value : this.chainId,
      evolvesFromId: data.evolvesFromId.present
          ? data.evolvesFromId.value
          : this.evolvesFromId,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EvolutionSpeciesRow(')
          ..write('speciesId: $speciesId, ')
          ..write('chainId: $chainId, ')
          ..write('evolvesFromId: $evolvesFromId, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(speciesId, chainId, evolvesFromId, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EvolutionSpeciesRow &&
          other.speciesId == this.speciesId &&
          other.chainId == this.chainId &&
          other.evolvesFromId == this.evolvesFromId &&
          other.name == this.name);
}

class EvolutionSpeciesTableCompanion
    extends UpdateCompanion<EvolutionSpeciesRow> {
  final Value<int> speciesId;
  final Value<int> chainId;
  final Value<int?> evolvesFromId;
  final Value<String> name;
  const EvolutionSpeciesTableCompanion({
    this.speciesId = const Value.absent(),
    this.chainId = const Value.absent(),
    this.evolvesFromId = const Value.absent(),
    this.name = const Value.absent(),
  });
  EvolutionSpeciesTableCompanion.insert({
    this.speciesId = const Value.absent(),
    required int chainId,
    this.evolvesFromId = const Value.absent(),
    required String name,
  }) : chainId = Value(chainId),
       name = Value(name);
  static Insertable<EvolutionSpeciesRow> custom({
    Expression<int>? speciesId,
    Expression<int>? chainId,
    Expression<int>? evolvesFromId,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (speciesId != null) 'species_id': speciesId,
      if (chainId != null) 'chain_id': chainId,
      if (evolvesFromId != null) 'evolves_from_id': evolvesFromId,
      if (name != null) 'name': name,
    });
  }

  EvolutionSpeciesTableCompanion copyWith({
    Value<int>? speciesId,
    Value<int>? chainId,
    Value<int?>? evolvesFromId,
    Value<String>? name,
  }) {
    return EvolutionSpeciesTableCompanion(
      speciesId: speciesId ?? this.speciesId,
      chainId: chainId ?? this.chainId,
      evolvesFromId: evolvesFromId ?? this.evolvesFromId,
      name: name ?? this.name,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (speciesId.present) {
      map['species_id'] = Variable<int>(speciesId.value);
    }
    if (chainId.present) {
      map['chain_id'] = Variable<int>(chainId.value);
    }
    if (evolvesFromId.present) {
      map['evolves_from_id'] = Variable<int>(evolvesFromId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EvolutionSpeciesTableCompanion(')
          ..write('speciesId: $speciesId, ')
          ..write('chainId: $chainId, ')
          ..write('evolvesFromId: $evolvesFromId, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $EvolutionMethodsTableTable extends EvolutionMethodsTable
    with TableInfo<$EvolutionMethodsTableTable, EvolutionMethodRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EvolutionMethodsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _speciesIdMeta = const VerificationMeta(
    'speciesId',
  );
  @override
  late final GeneratedColumn<int> speciesId = GeneratedColumn<int>(
    'species_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES evolution_species (species_id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _triggerMeta = const VerificationMeta(
    'trigger',
  );
  @override
  late final GeneratedColumn<String> trigger = GeneratedColumn<String>(
    'trigger',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _minLevelMeta = const VerificationMeta(
    'minLevel',
  );
  @override
  late final GeneratedColumn<int> minLevel = GeneratedColumn<int>(
    'min_level',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _itemMeta = const VerificationMeta('item');
  @override
  late final GeneratedColumn<String> item = GeneratedColumn<String>(
    'item',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _heldItemMeta = const VerificationMeta(
    'heldItem',
  );
  @override
  late final GeneratedColumn<String> heldItem = GeneratedColumn<String>(
    'held_item',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _minHappinessMeta = const VerificationMeta(
    'minHappiness',
  );
  @override
  late final GeneratedColumn<int> minHappiness = GeneratedColumn<int>(
    'min_happiness',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _timeOfDayMeta = const VerificationMeta(
    'timeOfDay',
  );
  @override
  late final GeneratedColumn<String> timeOfDay = GeneratedColumn<String>(
    'time_of_day',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _locationMeta = const VerificationMeta(
    'location',
  );
  @override
  late final GeneratedColumn<String> location = GeneratedColumn<String>(
    'location',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _knownMoveMeta = const VerificationMeta(
    'knownMove',
  );
  @override
  late final GeneratedColumn<String> knownMove = GeneratedColumn<String>(
    'known_move',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _knownMoveTypeMeta = const VerificationMeta(
    'knownMoveType',
  );
  @override
  late final GeneratedColumn<String> knownMoveType = GeneratedColumn<String>(
    'known_move_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    speciesId,
    trigger,
    minLevel,
    item,
    heldItem,
    minHappiness,
    timeOfDay,
    location,
    knownMove,
    knownMoveType,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'evolution_methods';
  @override
  VerificationContext validateIntegrity(
    Insertable<EvolutionMethodRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('species_id')) {
      context.handle(
        _speciesIdMeta,
        speciesId.isAcceptableOrUnknown(data['species_id']!, _speciesIdMeta),
      );
    } else if (isInserting) {
      context.missing(_speciesIdMeta);
    }
    if (data.containsKey('trigger')) {
      context.handle(
        _triggerMeta,
        trigger.isAcceptableOrUnknown(data['trigger']!, _triggerMeta),
      );
    } else if (isInserting) {
      context.missing(_triggerMeta);
    }
    if (data.containsKey('min_level')) {
      context.handle(
        _minLevelMeta,
        minLevel.isAcceptableOrUnknown(data['min_level']!, _minLevelMeta),
      );
    }
    if (data.containsKey('item')) {
      context.handle(
        _itemMeta,
        item.isAcceptableOrUnknown(data['item']!, _itemMeta),
      );
    }
    if (data.containsKey('held_item')) {
      context.handle(
        _heldItemMeta,
        heldItem.isAcceptableOrUnknown(data['held_item']!, _heldItemMeta),
      );
    }
    if (data.containsKey('min_happiness')) {
      context.handle(
        _minHappinessMeta,
        minHappiness.isAcceptableOrUnknown(
          data['min_happiness']!,
          _minHappinessMeta,
        ),
      );
    }
    if (data.containsKey('time_of_day')) {
      context.handle(
        _timeOfDayMeta,
        timeOfDay.isAcceptableOrUnknown(data['time_of_day']!, _timeOfDayMeta),
      );
    }
    if (data.containsKey('location')) {
      context.handle(
        _locationMeta,
        location.isAcceptableOrUnknown(data['location']!, _locationMeta),
      );
    }
    if (data.containsKey('known_move')) {
      context.handle(
        _knownMoveMeta,
        knownMove.isAcceptableOrUnknown(data['known_move']!, _knownMoveMeta),
      );
    }
    if (data.containsKey('known_move_type')) {
      context.handle(
        _knownMoveTypeMeta,
        knownMoveType.isAcceptableOrUnknown(
          data['known_move_type']!,
          _knownMoveTypeMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EvolutionMethodRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EvolutionMethodRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      speciesId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}species_id'],
      )!,
      trigger: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}trigger'],
      )!,
      minLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}min_level'],
      ),
      item: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}item'],
      ),
      heldItem: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}held_item'],
      ),
      minHappiness: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}min_happiness'],
      ),
      timeOfDay: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}time_of_day'],
      ),
      location: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location'],
      ),
      knownMove: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}known_move'],
      ),
      knownMoveType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}known_move_type'],
      ),
    );
  }

  @override
  $EvolutionMethodsTableTable createAlias(String alias) {
    return $EvolutionMethodsTableTable(attachedDatabase, alias);
  }
}

class EvolutionMethodRow extends DataClass
    implements Insertable<EvolutionMethodRow> {
  final int id;
  final int speciesId;
  final String trigger;
  final int? minLevel;
  final String? item;
  final String? heldItem;
  final int? minHappiness;
  final String? timeOfDay;
  final String? location;
  final String? knownMove;
  final String? knownMoveType;
  const EvolutionMethodRow({
    required this.id,
    required this.speciesId,
    required this.trigger,
    this.minLevel,
    this.item,
    this.heldItem,
    this.minHappiness,
    this.timeOfDay,
    this.location,
    this.knownMove,
    this.knownMoveType,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['species_id'] = Variable<int>(speciesId);
    map['trigger'] = Variable<String>(trigger);
    if (!nullToAbsent || minLevel != null) {
      map['min_level'] = Variable<int>(minLevel);
    }
    if (!nullToAbsent || item != null) {
      map['item'] = Variable<String>(item);
    }
    if (!nullToAbsent || heldItem != null) {
      map['held_item'] = Variable<String>(heldItem);
    }
    if (!nullToAbsent || minHappiness != null) {
      map['min_happiness'] = Variable<int>(minHappiness);
    }
    if (!nullToAbsent || timeOfDay != null) {
      map['time_of_day'] = Variable<String>(timeOfDay);
    }
    if (!nullToAbsent || location != null) {
      map['location'] = Variable<String>(location);
    }
    if (!nullToAbsent || knownMove != null) {
      map['known_move'] = Variable<String>(knownMove);
    }
    if (!nullToAbsent || knownMoveType != null) {
      map['known_move_type'] = Variable<String>(knownMoveType);
    }
    return map;
  }

  EvolutionMethodsTableCompanion toCompanion(bool nullToAbsent) {
    return EvolutionMethodsTableCompanion(
      id: Value(id),
      speciesId: Value(speciesId),
      trigger: Value(trigger),
      minLevel: minLevel == null && nullToAbsent
          ? const Value.absent()
          : Value(minLevel),
      item: item == null && nullToAbsent ? const Value.absent() : Value(item),
      heldItem: heldItem == null && nullToAbsent
          ? const Value.absent()
          : Value(heldItem),
      minHappiness: minHappiness == null && nullToAbsent
          ? const Value.absent()
          : Value(minHappiness),
      timeOfDay: timeOfDay == null && nullToAbsent
          ? const Value.absent()
          : Value(timeOfDay),
      location: location == null && nullToAbsent
          ? const Value.absent()
          : Value(location),
      knownMove: knownMove == null && nullToAbsent
          ? const Value.absent()
          : Value(knownMove),
      knownMoveType: knownMoveType == null && nullToAbsent
          ? const Value.absent()
          : Value(knownMoveType),
    );
  }

  factory EvolutionMethodRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EvolutionMethodRow(
      id: serializer.fromJson<int>(json['id']),
      speciesId: serializer.fromJson<int>(json['speciesId']),
      trigger: serializer.fromJson<String>(json['trigger']),
      minLevel: serializer.fromJson<int?>(json['minLevel']),
      item: serializer.fromJson<String?>(json['item']),
      heldItem: serializer.fromJson<String?>(json['heldItem']),
      minHappiness: serializer.fromJson<int?>(json['minHappiness']),
      timeOfDay: serializer.fromJson<String?>(json['timeOfDay']),
      location: serializer.fromJson<String?>(json['location']),
      knownMove: serializer.fromJson<String?>(json['knownMove']),
      knownMoveType: serializer.fromJson<String?>(json['knownMoveType']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'speciesId': serializer.toJson<int>(speciesId),
      'trigger': serializer.toJson<String>(trigger),
      'minLevel': serializer.toJson<int?>(minLevel),
      'item': serializer.toJson<String?>(item),
      'heldItem': serializer.toJson<String?>(heldItem),
      'minHappiness': serializer.toJson<int?>(minHappiness),
      'timeOfDay': serializer.toJson<String?>(timeOfDay),
      'location': serializer.toJson<String?>(location),
      'knownMove': serializer.toJson<String?>(knownMove),
      'knownMoveType': serializer.toJson<String?>(knownMoveType),
    };
  }

  EvolutionMethodRow copyWith({
    int? id,
    int? speciesId,
    String? trigger,
    Value<int?> minLevel = const Value.absent(),
    Value<String?> item = const Value.absent(),
    Value<String?> heldItem = const Value.absent(),
    Value<int?> minHappiness = const Value.absent(),
    Value<String?> timeOfDay = const Value.absent(),
    Value<String?> location = const Value.absent(),
    Value<String?> knownMove = const Value.absent(),
    Value<String?> knownMoveType = const Value.absent(),
  }) => EvolutionMethodRow(
    id: id ?? this.id,
    speciesId: speciesId ?? this.speciesId,
    trigger: trigger ?? this.trigger,
    minLevel: minLevel.present ? minLevel.value : this.minLevel,
    item: item.present ? item.value : this.item,
    heldItem: heldItem.present ? heldItem.value : this.heldItem,
    minHappiness: minHappiness.present ? minHappiness.value : this.minHappiness,
    timeOfDay: timeOfDay.present ? timeOfDay.value : this.timeOfDay,
    location: location.present ? location.value : this.location,
    knownMove: knownMove.present ? knownMove.value : this.knownMove,
    knownMoveType: knownMoveType.present
        ? knownMoveType.value
        : this.knownMoveType,
  );
  EvolutionMethodRow copyWithCompanion(EvolutionMethodsTableCompanion data) {
    return EvolutionMethodRow(
      id: data.id.present ? data.id.value : this.id,
      speciesId: data.speciesId.present ? data.speciesId.value : this.speciesId,
      trigger: data.trigger.present ? data.trigger.value : this.trigger,
      minLevel: data.minLevel.present ? data.minLevel.value : this.minLevel,
      item: data.item.present ? data.item.value : this.item,
      heldItem: data.heldItem.present ? data.heldItem.value : this.heldItem,
      minHappiness: data.minHappiness.present
          ? data.minHappiness.value
          : this.minHappiness,
      timeOfDay: data.timeOfDay.present ? data.timeOfDay.value : this.timeOfDay,
      location: data.location.present ? data.location.value : this.location,
      knownMove: data.knownMove.present ? data.knownMove.value : this.knownMove,
      knownMoveType: data.knownMoveType.present
          ? data.knownMoveType.value
          : this.knownMoveType,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EvolutionMethodRow(')
          ..write('id: $id, ')
          ..write('speciesId: $speciesId, ')
          ..write('trigger: $trigger, ')
          ..write('minLevel: $minLevel, ')
          ..write('item: $item, ')
          ..write('heldItem: $heldItem, ')
          ..write('minHappiness: $minHappiness, ')
          ..write('timeOfDay: $timeOfDay, ')
          ..write('location: $location, ')
          ..write('knownMove: $knownMove, ')
          ..write('knownMoveType: $knownMoveType')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    speciesId,
    trigger,
    minLevel,
    item,
    heldItem,
    minHappiness,
    timeOfDay,
    location,
    knownMove,
    knownMoveType,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EvolutionMethodRow &&
          other.id == this.id &&
          other.speciesId == this.speciesId &&
          other.trigger == this.trigger &&
          other.minLevel == this.minLevel &&
          other.item == this.item &&
          other.heldItem == this.heldItem &&
          other.minHappiness == this.minHappiness &&
          other.timeOfDay == this.timeOfDay &&
          other.location == this.location &&
          other.knownMove == this.knownMove &&
          other.knownMoveType == this.knownMoveType);
}

class EvolutionMethodsTableCompanion
    extends UpdateCompanion<EvolutionMethodRow> {
  final Value<int> id;
  final Value<int> speciesId;
  final Value<String> trigger;
  final Value<int?> minLevel;
  final Value<String?> item;
  final Value<String?> heldItem;
  final Value<int?> minHappiness;
  final Value<String?> timeOfDay;
  final Value<String?> location;
  final Value<String?> knownMove;
  final Value<String?> knownMoveType;
  const EvolutionMethodsTableCompanion({
    this.id = const Value.absent(),
    this.speciesId = const Value.absent(),
    this.trigger = const Value.absent(),
    this.minLevel = const Value.absent(),
    this.item = const Value.absent(),
    this.heldItem = const Value.absent(),
    this.minHappiness = const Value.absent(),
    this.timeOfDay = const Value.absent(),
    this.location = const Value.absent(),
    this.knownMove = const Value.absent(),
    this.knownMoveType = const Value.absent(),
  });
  EvolutionMethodsTableCompanion.insert({
    this.id = const Value.absent(),
    required int speciesId,
    required String trigger,
    this.minLevel = const Value.absent(),
    this.item = const Value.absent(),
    this.heldItem = const Value.absent(),
    this.minHappiness = const Value.absent(),
    this.timeOfDay = const Value.absent(),
    this.location = const Value.absent(),
    this.knownMove = const Value.absent(),
    this.knownMoveType = const Value.absent(),
  }) : speciesId = Value(speciesId),
       trigger = Value(trigger);
  static Insertable<EvolutionMethodRow> custom({
    Expression<int>? id,
    Expression<int>? speciesId,
    Expression<String>? trigger,
    Expression<int>? minLevel,
    Expression<String>? item,
    Expression<String>? heldItem,
    Expression<int>? minHappiness,
    Expression<String>? timeOfDay,
    Expression<String>? location,
    Expression<String>? knownMove,
    Expression<String>? knownMoveType,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (speciesId != null) 'species_id': speciesId,
      if (trigger != null) 'trigger': trigger,
      if (minLevel != null) 'min_level': minLevel,
      if (item != null) 'item': item,
      if (heldItem != null) 'held_item': heldItem,
      if (minHappiness != null) 'min_happiness': minHappiness,
      if (timeOfDay != null) 'time_of_day': timeOfDay,
      if (location != null) 'location': location,
      if (knownMove != null) 'known_move': knownMove,
      if (knownMoveType != null) 'known_move_type': knownMoveType,
    });
  }

  EvolutionMethodsTableCompanion copyWith({
    Value<int>? id,
    Value<int>? speciesId,
    Value<String>? trigger,
    Value<int?>? minLevel,
    Value<String?>? item,
    Value<String?>? heldItem,
    Value<int?>? minHappiness,
    Value<String?>? timeOfDay,
    Value<String?>? location,
    Value<String?>? knownMove,
    Value<String?>? knownMoveType,
  }) {
    return EvolutionMethodsTableCompanion(
      id: id ?? this.id,
      speciesId: speciesId ?? this.speciesId,
      trigger: trigger ?? this.trigger,
      minLevel: minLevel ?? this.minLevel,
      item: item ?? this.item,
      heldItem: heldItem ?? this.heldItem,
      minHappiness: minHappiness ?? this.minHappiness,
      timeOfDay: timeOfDay ?? this.timeOfDay,
      location: location ?? this.location,
      knownMove: knownMove ?? this.knownMove,
      knownMoveType: knownMoveType ?? this.knownMoveType,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (speciesId.present) {
      map['species_id'] = Variable<int>(speciesId.value);
    }
    if (trigger.present) {
      map['trigger'] = Variable<String>(trigger.value);
    }
    if (minLevel.present) {
      map['min_level'] = Variable<int>(minLevel.value);
    }
    if (item.present) {
      map['item'] = Variable<String>(item.value);
    }
    if (heldItem.present) {
      map['held_item'] = Variable<String>(heldItem.value);
    }
    if (minHappiness.present) {
      map['min_happiness'] = Variable<int>(minHappiness.value);
    }
    if (timeOfDay.present) {
      map['time_of_day'] = Variable<String>(timeOfDay.value);
    }
    if (location.present) {
      map['location'] = Variable<String>(location.value);
    }
    if (knownMove.present) {
      map['known_move'] = Variable<String>(knownMove.value);
    }
    if (knownMoveType.present) {
      map['known_move_type'] = Variable<String>(knownMoveType.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EvolutionMethodsTableCompanion(')
          ..write('id: $id, ')
          ..write('speciesId: $speciesId, ')
          ..write('trigger: $trigger, ')
          ..write('minLevel: $minLevel, ')
          ..write('item: $item, ')
          ..write('heldItem: $heldItem, ')
          ..write('minHappiness: $minHappiness, ')
          ..write('timeOfDay: $timeOfDay, ')
          ..write('location: $location, ')
          ..write('knownMove: $knownMove, ')
          ..write('knownMoveType: $knownMoveType')
          ..write(')'))
        .toString();
  }
}

class $MovesTableTable extends MovesTable
    with TableInfo<$MovesTableTable, MoveRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MovesTableTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _nameEsMeta = const VerificationMeta('nameEs');
  @override
  late final GeneratedColumn<String> nameEs = GeneratedColumn<String>(
    'name_es',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameEnMeta = const VerificationMeta('nameEn');
  @override
  late final GeneratedColumn<String> nameEn = GeneratedColumn<String>(
    'name_en',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _typeIdMeta = const VerificationMeta('typeId');
  @override
  late final GeneratedColumn<int> typeId = GeneratedColumn<int>(
    'type_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _powerMeta = const VerificationMeta('power');
  @override
  late final GeneratedColumn<int> power = GeneratedColumn<int>(
    'power',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _accuracyMeta = const VerificationMeta(
    'accuracy',
  );
  @override
  late final GeneratedColumn<int> accuracy = GeneratedColumn<int>(
    'accuracy',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ppMeta = const VerificationMeta('pp');
  @override
  late final GeneratedColumn<int> pp = GeneratedColumn<int>(
    'pp',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _damageClassMeta = const VerificationMeta(
    'damageClass',
  );
  @override
  late final GeneratedColumn<String> damageClass = GeneratedColumn<String>(
    'damage_class',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    nameEs,
    nameEn,
    typeId,
    power,
    accuracy,
    pp,
    damageClass,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'moves';
  @override
  VerificationContext validateIntegrity(
    Insertable<MoveRow> instance, {
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
    if (data.containsKey('name_es')) {
      context.handle(
        _nameEsMeta,
        nameEs.isAcceptableOrUnknown(data['name_es']!, _nameEsMeta),
      );
    }
    if (data.containsKey('name_en')) {
      context.handle(
        _nameEnMeta,
        nameEn.isAcceptableOrUnknown(data['name_en']!, _nameEnMeta),
      );
    }
    if (data.containsKey('type_id')) {
      context.handle(
        _typeIdMeta,
        typeId.isAcceptableOrUnknown(data['type_id']!, _typeIdMeta),
      );
    }
    if (data.containsKey('power')) {
      context.handle(
        _powerMeta,
        power.isAcceptableOrUnknown(data['power']!, _powerMeta),
      );
    }
    if (data.containsKey('accuracy')) {
      context.handle(
        _accuracyMeta,
        accuracy.isAcceptableOrUnknown(data['accuracy']!, _accuracyMeta),
      );
    }
    if (data.containsKey('pp')) {
      context.handle(_ppMeta, pp.isAcceptableOrUnknown(data['pp']!, _ppMeta));
    }
    if (data.containsKey('damage_class')) {
      context.handle(
        _damageClassMeta,
        damageClass.isAcceptableOrUnknown(
          data['damage_class']!,
          _damageClassMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MoveRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MoveRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      nameEs: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_es'],
      ),
      nameEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_en'],
      ),
      typeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}type_id'],
      ),
      power: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}power'],
      ),
      accuracy: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}accuracy'],
      ),
      pp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pp'],
      ),
      damageClass: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}damage_class'],
      ),
    );
  }

  @override
  $MovesTableTable createAlias(String alias) {
    return $MovesTableTable(attachedDatabase, alias);
  }
}

class MoveRow extends DataClass implements Insertable<MoveRow> {
  final int id;
  final String name;
  final String? nameEs;
  final String? nameEn;
  final int? typeId;
  final int? power;
  final int? accuracy;
  final int? pp;
  final String? damageClass;
  const MoveRow({
    required this.id,
    required this.name,
    this.nameEs,
    this.nameEn,
    this.typeId,
    this.power,
    this.accuracy,
    this.pp,
    this.damageClass,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || nameEs != null) {
      map['name_es'] = Variable<String>(nameEs);
    }
    if (!nullToAbsent || nameEn != null) {
      map['name_en'] = Variable<String>(nameEn);
    }
    if (!nullToAbsent || typeId != null) {
      map['type_id'] = Variable<int>(typeId);
    }
    if (!nullToAbsent || power != null) {
      map['power'] = Variable<int>(power);
    }
    if (!nullToAbsent || accuracy != null) {
      map['accuracy'] = Variable<int>(accuracy);
    }
    if (!nullToAbsent || pp != null) {
      map['pp'] = Variable<int>(pp);
    }
    if (!nullToAbsent || damageClass != null) {
      map['damage_class'] = Variable<String>(damageClass);
    }
    return map;
  }

  MovesTableCompanion toCompanion(bool nullToAbsent) {
    return MovesTableCompanion(
      id: Value(id),
      name: Value(name),
      nameEs: nameEs == null && nullToAbsent
          ? const Value.absent()
          : Value(nameEs),
      nameEn: nameEn == null && nullToAbsent
          ? const Value.absent()
          : Value(nameEn),
      typeId: typeId == null && nullToAbsent
          ? const Value.absent()
          : Value(typeId),
      power: power == null && nullToAbsent
          ? const Value.absent()
          : Value(power),
      accuracy: accuracy == null && nullToAbsent
          ? const Value.absent()
          : Value(accuracy),
      pp: pp == null && nullToAbsent ? const Value.absent() : Value(pp),
      damageClass: damageClass == null && nullToAbsent
          ? const Value.absent()
          : Value(damageClass),
    );
  }

  factory MoveRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MoveRow(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      nameEs: serializer.fromJson<String?>(json['nameEs']),
      nameEn: serializer.fromJson<String?>(json['nameEn']),
      typeId: serializer.fromJson<int?>(json['typeId']),
      power: serializer.fromJson<int?>(json['power']),
      accuracy: serializer.fromJson<int?>(json['accuracy']),
      pp: serializer.fromJson<int?>(json['pp']),
      damageClass: serializer.fromJson<String?>(json['damageClass']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'nameEs': serializer.toJson<String?>(nameEs),
      'nameEn': serializer.toJson<String?>(nameEn),
      'typeId': serializer.toJson<int?>(typeId),
      'power': serializer.toJson<int?>(power),
      'accuracy': serializer.toJson<int?>(accuracy),
      'pp': serializer.toJson<int?>(pp),
      'damageClass': serializer.toJson<String?>(damageClass),
    };
  }

  MoveRow copyWith({
    int? id,
    String? name,
    Value<String?> nameEs = const Value.absent(),
    Value<String?> nameEn = const Value.absent(),
    Value<int?> typeId = const Value.absent(),
    Value<int?> power = const Value.absent(),
    Value<int?> accuracy = const Value.absent(),
    Value<int?> pp = const Value.absent(),
    Value<String?> damageClass = const Value.absent(),
  }) => MoveRow(
    id: id ?? this.id,
    name: name ?? this.name,
    nameEs: nameEs.present ? nameEs.value : this.nameEs,
    nameEn: nameEn.present ? nameEn.value : this.nameEn,
    typeId: typeId.present ? typeId.value : this.typeId,
    power: power.present ? power.value : this.power,
    accuracy: accuracy.present ? accuracy.value : this.accuracy,
    pp: pp.present ? pp.value : this.pp,
    damageClass: damageClass.present ? damageClass.value : this.damageClass,
  );
  MoveRow copyWithCompanion(MovesTableCompanion data) {
    return MoveRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      nameEs: data.nameEs.present ? data.nameEs.value : this.nameEs,
      nameEn: data.nameEn.present ? data.nameEn.value : this.nameEn,
      typeId: data.typeId.present ? data.typeId.value : this.typeId,
      power: data.power.present ? data.power.value : this.power,
      accuracy: data.accuracy.present ? data.accuracy.value : this.accuracy,
      pp: data.pp.present ? data.pp.value : this.pp,
      damageClass: data.damageClass.present
          ? data.damageClass.value
          : this.damageClass,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MoveRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('nameEs: $nameEs, ')
          ..write('nameEn: $nameEn, ')
          ..write('typeId: $typeId, ')
          ..write('power: $power, ')
          ..write('accuracy: $accuracy, ')
          ..write('pp: $pp, ')
          ..write('damageClass: $damageClass')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    nameEs,
    nameEn,
    typeId,
    power,
    accuracy,
    pp,
    damageClass,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MoveRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.nameEs == this.nameEs &&
          other.nameEn == this.nameEn &&
          other.typeId == this.typeId &&
          other.power == this.power &&
          other.accuracy == this.accuracy &&
          other.pp == this.pp &&
          other.damageClass == this.damageClass);
}

class MovesTableCompanion extends UpdateCompanion<MoveRow> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> nameEs;
  final Value<String?> nameEn;
  final Value<int?> typeId;
  final Value<int?> power;
  final Value<int?> accuracy;
  final Value<int?> pp;
  final Value<String?> damageClass;
  const MovesTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.nameEs = const Value.absent(),
    this.nameEn = const Value.absent(),
    this.typeId = const Value.absent(),
    this.power = const Value.absent(),
    this.accuracy = const Value.absent(),
    this.pp = const Value.absent(),
    this.damageClass = const Value.absent(),
  });
  MovesTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.nameEs = const Value.absent(),
    this.nameEn = const Value.absent(),
    this.typeId = const Value.absent(),
    this.power = const Value.absent(),
    this.accuracy = const Value.absent(),
    this.pp = const Value.absent(),
    this.damageClass = const Value.absent(),
  }) : name = Value(name);
  static Insertable<MoveRow> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? nameEs,
    Expression<String>? nameEn,
    Expression<int>? typeId,
    Expression<int>? power,
    Expression<int>? accuracy,
    Expression<int>? pp,
    Expression<String>? damageClass,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (nameEs != null) 'name_es': nameEs,
      if (nameEn != null) 'name_en': nameEn,
      if (typeId != null) 'type_id': typeId,
      if (power != null) 'power': power,
      if (accuracy != null) 'accuracy': accuracy,
      if (pp != null) 'pp': pp,
      if (damageClass != null) 'damage_class': damageClass,
    });
  }

  MovesTableCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? nameEs,
    Value<String?>? nameEn,
    Value<int?>? typeId,
    Value<int?>? power,
    Value<int?>? accuracy,
    Value<int?>? pp,
    Value<String?>? damageClass,
  }) {
    return MovesTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      nameEs: nameEs ?? this.nameEs,
      nameEn: nameEn ?? this.nameEn,
      typeId: typeId ?? this.typeId,
      power: power ?? this.power,
      accuracy: accuracy ?? this.accuracy,
      pp: pp ?? this.pp,
      damageClass: damageClass ?? this.damageClass,
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
    if (nameEs.present) {
      map['name_es'] = Variable<String>(nameEs.value);
    }
    if (nameEn.present) {
      map['name_en'] = Variable<String>(nameEn.value);
    }
    if (typeId.present) {
      map['type_id'] = Variable<int>(typeId.value);
    }
    if (power.present) {
      map['power'] = Variable<int>(power.value);
    }
    if (accuracy.present) {
      map['accuracy'] = Variable<int>(accuracy.value);
    }
    if (pp.present) {
      map['pp'] = Variable<int>(pp.value);
    }
    if (damageClass.present) {
      map['damage_class'] = Variable<String>(damageClass.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MovesTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('nameEs: $nameEs, ')
          ..write('nameEn: $nameEn, ')
          ..write('typeId: $typeId, ')
          ..write('power: $power, ')
          ..write('accuracy: $accuracy, ')
          ..write('pp: $pp, ')
          ..write('damageClass: $damageClass')
          ..write(')'))
        .toString();
  }
}

class $PokemonMovesTableTable extends PokemonMovesTable
    with TableInfo<$PokemonMovesTableTable, PokemonMoveRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PokemonMovesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _pokemonIdMeta = const VerificationMeta(
    'pokemonId',
  );
  @override
  late final GeneratedColumn<int> pokemonId = GeneratedColumn<int>(
    'pokemon_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES pokemon (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _moveIdMeta = const VerificationMeta('moveId');
  @override
  late final GeneratedColumn<int> moveId = GeneratedColumn<int>(
    'move_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES moves (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _methodMeta = const VerificationMeta('method');
  @override
  late final GeneratedColumn<String> method = GeneratedColumn<String>(
    'method',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _levelMeta = const VerificationMeta('level');
  @override
  late final GeneratedColumn<int> level = GeneratedColumn<int>(
    'level',
    aliasedName,
    false,
    check: () => ComparableExpr(level).isBetweenValues(0, 100),
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [pokemonId, moveId, method, level];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pokemon_moves';
  @override
  VerificationContext validateIntegrity(
    Insertable<PokemonMoveRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('pokemon_id')) {
      context.handle(
        _pokemonIdMeta,
        pokemonId.isAcceptableOrUnknown(data['pokemon_id']!, _pokemonIdMeta),
      );
    } else if (isInserting) {
      context.missing(_pokemonIdMeta);
    }
    if (data.containsKey('move_id')) {
      context.handle(
        _moveIdMeta,
        moveId.isAcceptableOrUnknown(data['move_id']!, _moveIdMeta),
      );
    } else if (isInserting) {
      context.missing(_moveIdMeta);
    }
    if (data.containsKey('method')) {
      context.handle(
        _methodMeta,
        method.isAcceptableOrUnknown(data['method']!, _methodMeta),
      );
    } else if (isInserting) {
      context.missing(_methodMeta);
    }
    if (data.containsKey('level')) {
      context.handle(
        _levelMeta,
        level.isAcceptableOrUnknown(data['level']!, _levelMeta),
      );
    } else if (isInserting) {
      context.missing(_levelMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {pokemonId, method, level, moveId};
  @override
  PokemonMoveRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PokemonMoveRow(
      pokemonId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pokemon_id'],
      )!,
      moveId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}move_id'],
      )!,
      method: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}method'],
      )!,
      level: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}level'],
      )!,
    );
  }

  @override
  $PokemonMovesTableTable createAlias(String alias) {
    return $PokemonMovesTableTable(attachedDatabase, alias);
  }
}

class PokemonMoveRow extends DataClass implements Insertable<PokemonMoveRow> {
  final int pokemonId;
  final int moveId;
  final String method;
  final int level;
  const PokemonMoveRow({
    required this.pokemonId,
    required this.moveId,
    required this.method,
    required this.level,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['pokemon_id'] = Variable<int>(pokemonId);
    map['move_id'] = Variable<int>(moveId);
    map['method'] = Variable<String>(method);
    map['level'] = Variable<int>(level);
    return map;
  }

  PokemonMovesTableCompanion toCompanion(bool nullToAbsent) {
    return PokemonMovesTableCompanion(
      pokemonId: Value(pokemonId),
      moveId: Value(moveId),
      method: Value(method),
      level: Value(level),
    );
  }

  factory PokemonMoveRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PokemonMoveRow(
      pokemonId: serializer.fromJson<int>(json['pokemonId']),
      moveId: serializer.fromJson<int>(json['moveId']),
      method: serializer.fromJson<String>(json['method']),
      level: serializer.fromJson<int>(json['level']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'pokemonId': serializer.toJson<int>(pokemonId),
      'moveId': serializer.toJson<int>(moveId),
      'method': serializer.toJson<String>(method),
      'level': serializer.toJson<int>(level),
    };
  }

  PokemonMoveRow copyWith({
    int? pokemonId,
    int? moveId,
    String? method,
    int? level,
  }) => PokemonMoveRow(
    pokemonId: pokemonId ?? this.pokemonId,
    moveId: moveId ?? this.moveId,
    method: method ?? this.method,
    level: level ?? this.level,
  );
  PokemonMoveRow copyWithCompanion(PokemonMovesTableCompanion data) {
    return PokemonMoveRow(
      pokemonId: data.pokemonId.present ? data.pokemonId.value : this.pokemonId,
      moveId: data.moveId.present ? data.moveId.value : this.moveId,
      method: data.method.present ? data.method.value : this.method,
      level: data.level.present ? data.level.value : this.level,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PokemonMoveRow(')
          ..write('pokemonId: $pokemonId, ')
          ..write('moveId: $moveId, ')
          ..write('method: $method, ')
          ..write('level: $level')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(pokemonId, moveId, method, level);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PokemonMoveRow &&
          other.pokemonId == this.pokemonId &&
          other.moveId == this.moveId &&
          other.method == this.method &&
          other.level == this.level);
}

class PokemonMovesTableCompanion extends UpdateCompanion<PokemonMoveRow> {
  final Value<int> pokemonId;
  final Value<int> moveId;
  final Value<String> method;
  final Value<int> level;
  final Value<int> rowid;
  const PokemonMovesTableCompanion({
    this.pokemonId = const Value.absent(),
    this.moveId = const Value.absent(),
    this.method = const Value.absent(),
    this.level = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PokemonMovesTableCompanion.insert({
    required int pokemonId,
    required int moveId,
    required String method,
    required int level,
    this.rowid = const Value.absent(),
  }) : pokemonId = Value(pokemonId),
       moveId = Value(moveId),
       method = Value(method),
       level = Value(level);
  static Insertable<PokemonMoveRow> custom({
    Expression<int>? pokemonId,
    Expression<int>? moveId,
    Expression<String>? method,
    Expression<int>? level,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (pokemonId != null) 'pokemon_id': pokemonId,
      if (moveId != null) 'move_id': moveId,
      if (method != null) 'method': method,
      if (level != null) 'level': level,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PokemonMovesTableCompanion copyWith({
    Value<int>? pokemonId,
    Value<int>? moveId,
    Value<String>? method,
    Value<int>? level,
    Value<int>? rowid,
  }) {
    return PokemonMovesTableCompanion(
      pokemonId: pokemonId ?? this.pokemonId,
      moveId: moveId ?? this.moveId,
      method: method ?? this.method,
      level: level ?? this.level,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (pokemonId.present) {
      map['pokemon_id'] = Variable<int>(pokemonId.value);
    }
    if (moveId.present) {
      map['move_id'] = Variable<int>(moveId.value);
    }
    if (method.present) {
      map['method'] = Variable<String>(method.value);
    }
    if (level.present) {
      map['level'] = Variable<int>(level.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PokemonMovesTableCompanion(')
          ..write('pokemonId: $pokemonId, ')
          ..write('moveId: $moveId, ')
          ..write('method: $method, ')
          ..write('level: $level, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TriviaResultsTableTable extends TriviaResultsTable
    with TableInfo<$TriviaResultsTableTable, TriviaResultRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TriviaResultsTableTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _scoreMeta = const VerificationMeta('score');
  @override
  late final GeneratedColumn<int> score = GeneratedColumn<int>(
    'score',
    aliasedName,
    false,
    check: () => ComparableExpr(score).isBiggerOrEqualValue(0),
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _correctAnswersMeta = const VerificationMeta(
    'correctAnswers',
  );
  @override
  late final GeneratedColumn<int> correctAnswers = GeneratedColumn<int>(
    'correct_answers',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalQuestionsMeta = const VerificationMeta(
    'totalQuestions',
  );
  @override
  late final GeneratedColumn<int> totalQuestions = GeneratedColumn<int>(
    'total_questions',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _playedAtMeta = const VerificationMeta(
    'playedAt',
  );
  @override
  late final GeneratedColumn<DateTime> playedAt = GeneratedColumn<DateTime>(
    'played_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    score,
    correctAnswers,
    totalQuestions,
    playedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'trivia_results';
  @override
  VerificationContext validateIntegrity(
    Insertable<TriviaResultRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('score')) {
      context.handle(
        _scoreMeta,
        score.isAcceptableOrUnknown(data['score']!, _scoreMeta),
      );
    } else if (isInserting) {
      context.missing(_scoreMeta);
    }
    if (data.containsKey('correct_answers')) {
      context.handle(
        _correctAnswersMeta,
        correctAnswers.isAcceptableOrUnknown(
          data['correct_answers']!,
          _correctAnswersMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_correctAnswersMeta);
    }
    if (data.containsKey('total_questions')) {
      context.handle(
        _totalQuestionsMeta,
        totalQuestions.isAcceptableOrUnknown(
          data['total_questions']!,
          _totalQuestionsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalQuestionsMeta);
    }
    if (data.containsKey('played_at')) {
      context.handle(
        _playedAtMeta,
        playedAt.isAcceptableOrUnknown(data['played_at']!, _playedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TriviaResultRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TriviaResultRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      score: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}score'],
      )!,
      correctAnswers: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}correct_answers'],
      )!,
      totalQuestions: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_questions'],
      )!,
      playedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}played_at'],
      )!,
    );
  }

  @override
  $TriviaResultsTableTable createAlias(String alias) {
    return $TriviaResultsTableTable(attachedDatabase, alias);
  }
}

class TriviaResultRow extends DataClass implements Insertable<TriviaResultRow> {
  final int id;
  final int score;
  final int correctAnswers;
  final int totalQuestions;
  final DateTime playedAt;
  const TriviaResultRow({
    required this.id,
    required this.score,
    required this.correctAnswers,
    required this.totalQuestions,
    required this.playedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['score'] = Variable<int>(score);
    map['correct_answers'] = Variable<int>(correctAnswers);
    map['total_questions'] = Variable<int>(totalQuestions);
    map['played_at'] = Variable<DateTime>(playedAt);
    return map;
  }

  TriviaResultsTableCompanion toCompanion(bool nullToAbsent) {
    return TriviaResultsTableCompanion(
      id: Value(id),
      score: Value(score),
      correctAnswers: Value(correctAnswers),
      totalQuestions: Value(totalQuestions),
      playedAt: Value(playedAt),
    );
  }

  factory TriviaResultRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TriviaResultRow(
      id: serializer.fromJson<int>(json['id']),
      score: serializer.fromJson<int>(json['score']),
      correctAnswers: serializer.fromJson<int>(json['correctAnswers']),
      totalQuestions: serializer.fromJson<int>(json['totalQuestions']),
      playedAt: serializer.fromJson<DateTime>(json['playedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'score': serializer.toJson<int>(score),
      'correctAnswers': serializer.toJson<int>(correctAnswers),
      'totalQuestions': serializer.toJson<int>(totalQuestions),
      'playedAt': serializer.toJson<DateTime>(playedAt),
    };
  }

  TriviaResultRow copyWith({
    int? id,
    int? score,
    int? correctAnswers,
    int? totalQuestions,
    DateTime? playedAt,
  }) => TriviaResultRow(
    id: id ?? this.id,
    score: score ?? this.score,
    correctAnswers: correctAnswers ?? this.correctAnswers,
    totalQuestions: totalQuestions ?? this.totalQuestions,
    playedAt: playedAt ?? this.playedAt,
  );
  TriviaResultRow copyWithCompanion(TriviaResultsTableCompanion data) {
    return TriviaResultRow(
      id: data.id.present ? data.id.value : this.id,
      score: data.score.present ? data.score.value : this.score,
      correctAnswers: data.correctAnswers.present
          ? data.correctAnswers.value
          : this.correctAnswers,
      totalQuestions: data.totalQuestions.present
          ? data.totalQuestions.value
          : this.totalQuestions,
      playedAt: data.playedAt.present ? data.playedAt.value : this.playedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TriviaResultRow(')
          ..write('id: $id, ')
          ..write('score: $score, ')
          ..write('correctAnswers: $correctAnswers, ')
          ..write('totalQuestions: $totalQuestions, ')
          ..write('playedAt: $playedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, score, correctAnswers, totalQuestions, playedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TriviaResultRow &&
          other.id == this.id &&
          other.score == this.score &&
          other.correctAnswers == this.correctAnswers &&
          other.totalQuestions == this.totalQuestions &&
          other.playedAt == this.playedAt);
}

class TriviaResultsTableCompanion extends UpdateCompanion<TriviaResultRow> {
  final Value<int> id;
  final Value<int> score;
  final Value<int> correctAnswers;
  final Value<int> totalQuestions;
  final Value<DateTime> playedAt;
  const TriviaResultsTableCompanion({
    this.id = const Value.absent(),
    this.score = const Value.absent(),
    this.correctAnswers = const Value.absent(),
    this.totalQuestions = const Value.absent(),
    this.playedAt = const Value.absent(),
  });
  TriviaResultsTableCompanion.insert({
    this.id = const Value.absent(),
    required int score,
    required int correctAnswers,
    required int totalQuestions,
    this.playedAt = const Value.absent(),
  }) : score = Value(score),
       correctAnswers = Value(correctAnswers),
       totalQuestions = Value(totalQuestions);
  static Insertable<TriviaResultRow> custom({
    Expression<int>? id,
    Expression<int>? score,
    Expression<int>? correctAnswers,
    Expression<int>? totalQuestions,
    Expression<DateTime>? playedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (score != null) 'score': score,
      if (correctAnswers != null) 'correct_answers': correctAnswers,
      if (totalQuestions != null) 'total_questions': totalQuestions,
      if (playedAt != null) 'played_at': playedAt,
    });
  }

  TriviaResultsTableCompanion copyWith({
    Value<int>? id,
    Value<int>? score,
    Value<int>? correctAnswers,
    Value<int>? totalQuestions,
    Value<DateTime>? playedAt,
  }) {
    return TriviaResultsTableCompanion(
      id: id ?? this.id,
      score: score ?? this.score,
      correctAnswers: correctAnswers ?? this.correctAnswers,
      totalQuestions: totalQuestions ?? this.totalQuestions,
      playedAt: playedAt ?? this.playedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (score.present) {
      map['score'] = Variable<int>(score.value);
    }
    if (correctAnswers.present) {
      map['correct_answers'] = Variable<int>(correctAnswers.value);
    }
    if (totalQuestions.present) {
      map['total_questions'] = Variable<int>(totalQuestions.value);
    }
    if (playedAt.present) {
      map['played_at'] = Variable<DateTime>(playedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TriviaResultsTableCompanion(')
          ..write('id: $id, ')
          ..write('score: $score, ')
          ..write('correctAnswers: $correctAnswers, ')
          ..write('totalQuestions: $totalQuestions, ')
          ..write('playedAt: $playedAt')
          ..write(')'))
        .toString();
  }
}

class $TriviaAnswersTableTable extends TriviaAnswersTable
    with TableInfo<$TriviaAnswersTableTable, TriviaAnswerRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TriviaAnswersTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _resultIdMeta = const VerificationMeta(
    'resultId',
  );
  @override
  late final GeneratedColumn<int> resultId = GeneratedColumn<int>(
    'result_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES trivia_results (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _questionNumberMeta = const VerificationMeta(
    'questionNumber',
  );
  @override
  late final GeneratedColumn<int> questionNumber = GeneratedColumn<int>(
    'question_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pokemonIdMeta = const VerificationMeta(
    'pokemonId',
  );
  @override
  late final GeneratedColumn<int> pokemonId = GeneratedColumn<int>(
    'pokemon_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _correctMeta = const VerificationMeta(
    'correct',
  );
  @override
  late final GeneratedColumn<bool> correct = GeneratedColumn<bool>(
    'correct',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("correct" IN (0, 1))',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    resultId,
    questionNumber,
    pokemonId,
    correct,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'trivia_answers';
  @override
  VerificationContext validateIntegrity(
    Insertable<TriviaAnswerRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('result_id')) {
      context.handle(
        _resultIdMeta,
        resultId.isAcceptableOrUnknown(data['result_id']!, _resultIdMeta),
      );
    } else if (isInserting) {
      context.missing(_resultIdMeta);
    }
    if (data.containsKey('question_number')) {
      context.handle(
        _questionNumberMeta,
        questionNumber.isAcceptableOrUnknown(
          data['question_number']!,
          _questionNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_questionNumberMeta);
    }
    if (data.containsKey('pokemon_id')) {
      context.handle(
        _pokemonIdMeta,
        pokemonId.isAcceptableOrUnknown(data['pokemon_id']!, _pokemonIdMeta),
      );
    } else if (isInserting) {
      context.missing(_pokemonIdMeta);
    }
    if (data.containsKey('correct')) {
      context.handle(
        _correctMeta,
        correct.isAcceptableOrUnknown(data['correct']!, _correctMeta),
      );
    } else if (isInserting) {
      context.missing(_correctMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {resultId, questionNumber};
  @override
  TriviaAnswerRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TriviaAnswerRow(
      resultId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}result_id'],
      )!,
      questionNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}question_number'],
      )!,
      pokemonId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pokemon_id'],
      )!,
      correct: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}correct'],
      )!,
    );
  }

  @override
  $TriviaAnswersTableTable createAlias(String alias) {
    return $TriviaAnswersTableTable(attachedDatabase, alias);
  }
}

class TriviaAnswerRow extends DataClass implements Insertable<TriviaAnswerRow> {
  final int resultId;
  final int questionNumber;
  final int pokemonId;
  final bool correct;
  const TriviaAnswerRow({
    required this.resultId,
    required this.questionNumber,
    required this.pokemonId,
    required this.correct,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['result_id'] = Variable<int>(resultId);
    map['question_number'] = Variable<int>(questionNumber);
    map['pokemon_id'] = Variable<int>(pokemonId);
    map['correct'] = Variable<bool>(correct);
    return map;
  }

  TriviaAnswersTableCompanion toCompanion(bool nullToAbsent) {
    return TriviaAnswersTableCompanion(
      resultId: Value(resultId),
      questionNumber: Value(questionNumber),
      pokemonId: Value(pokemonId),
      correct: Value(correct),
    );
  }

  factory TriviaAnswerRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TriviaAnswerRow(
      resultId: serializer.fromJson<int>(json['resultId']),
      questionNumber: serializer.fromJson<int>(json['questionNumber']),
      pokemonId: serializer.fromJson<int>(json['pokemonId']),
      correct: serializer.fromJson<bool>(json['correct']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'resultId': serializer.toJson<int>(resultId),
      'questionNumber': serializer.toJson<int>(questionNumber),
      'pokemonId': serializer.toJson<int>(pokemonId),
      'correct': serializer.toJson<bool>(correct),
    };
  }

  TriviaAnswerRow copyWith({
    int? resultId,
    int? questionNumber,
    int? pokemonId,
    bool? correct,
  }) => TriviaAnswerRow(
    resultId: resultId ?? this.resultId,
    questionNumber: questionNumber ?? this.questionNumber,
    pokemonId: pokemonId ?? this.pokemonId,
    correct: correct ?? this.correct,
  );
  TriviaAnswerRow copyWithCompanion(TriviaAnswersTableCompanion data) {
    return TriviaAnswerRow(
      resultId: data.resultId.present ? data.resultId.value : this.resultId,
      questionNumber: data.questionNumber.present
          ? data.questionNumber.value
          : this.questionNumber,
      pokemonId: data.pokemonId.present ? data.pokemonId.value : this.pokemonId,
      correct: data.correct.present ? data.correct.value : this.correct,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TriviaAnswerRow(')
          ..write('resultId: $resultId, ')
          ..write('questionNumber: $questionNumber, ')
          ..write('pokemonId: $pokemonId, ')
          ..write('correct: $correct')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(resultId, questionNumber, pokemonId, correct);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TriviaAnswerRow &&
          other.resultId == this.resultId &&
          other.questionNumber == this.questionNumber &&
          other.pokemonId == this.pokemonId &&
          other.correct == this.correct);
}

class TriviaAnswersTableCompanion extends UpdateCompanion<TriviaAnswerRow> {
  final Value<int> resultId;
  final Value<int> questionNumber;
  final Value<int> pokemonId;
  final Value<bool> correct;
  final Value<int> rowid;
  const TriviaAnswersTableCompanion({
    this.resultId = const Value.absent(),
    this.questionNumber = const Value.absent(),
    this.pokemonId = const Value.absent(),
    this.correct = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TriviaAnswersTableCompanion.insert({
    required int resultId,
    required int questionNumber,
    required int pokemonId,
    required bool correct,
    this.rowid = const Value.absent(),
  }) : resultId = Value(resultId),
       questionNumber = Value(questionNumber),
       pokemonId = Value(pokemonId),
       correct = Value(correct);
  static Insertable<TriviaAnswerRow> custom({
    Expression<int>? resultId,
    Expression<int>? questionNumber,
    Expression<int>? pokemonId,
    Expression<bool>? correct,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (resultId != null) 'result_id': resultId,
      if (questionNumber != null) 'question_number': questionNumber,
      if (pokemonId != null) 'pokemon_id': pokemonId,
      if (correct != null) 'correct': correct,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TriviaAnswersTableCompanion copyWith({
    Value<int>? resultId,
    Value<int>? questionNumber,
    Value<int>? pokemonId,
    Value<bool>? correct,
    Value<int>? rowid,
  }) {
    return TriviaAnswersTableCompanion(
      resultId: resultId ?? this.resultId,
      questionNumber: questionNumber ?? this.questionNumber,
      pokemonId: pokemonId ?? this.pokemonId,
      correct: correct ?? this.correct,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (resultId.present) {
      map['result_id'] = Variable<int>(resultId.value);
    }
    if (questionNumber.present) {
      map['question_number'] = Variable<int>(questionNumber.value);
    }
    if (pokemonId.present) {
      map['pokemon_id'] = Variable<int>(pokemonId.value);
    }
    if (correct.present) {
      map['correct'] = Variable<bool>(correct.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TriviaAnswersTableCompanion(')
          ..write('resultId: $resultId, ')
          ..write('questionNumber: $questionNumber, ')
          ..write('pokemonId: $pokemonId, ')
          ..write('correct: $correct, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AchievementsTableTable extends AchievementsTable
    with TableInfo<$AchievementsTableTable, AchievementRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AchievementsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unlockedAtMeta = const VerificationMeta(
    'unlockedAt',
  );
  @override
  late final GeneratedColumn<DateTime> unlockedAt = GeneratedColumn<DateTime>(
    'unlocked_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [id, unlockedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'achievements';
  @override
  VerificationContext validateIntegrity(
    Insertable<AchievementRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('unlocked_at')) {
      context.handle(
        _unlockedAtMeta,
        unlockedAt.isAcceptableOrUnknown(data['unlocked_at']!, _unlockedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AchievementRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AchievementRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      unlockedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}unlocked_at'],
      )!,
    );
  }

  @override
  $AchievementsTableTable createAlias(String alias) {
    return $AchievementsTableTable(attachedDatabase, alias);
  }
}

class AchievementRow extends DataClass implements Insertable<AchievementRow> {
  final String id;
  final DateTime unlockedAt;
  const AchievementRow({required this.id, required this.unlockedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['unlocked_at'] = Variable<DateTime>(unlockedAt);
    return map;
  }

  AchievementsTableCompanion toCompanion(bool nullToAbsent) {
    return AchievementsTableCompanion(
      id: Value(id),
      unlockedAt: Value(unlockedAt),
    );
  }

  factory AchievementRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AchievementRow(
      id: serializer.fromJson<String>(json['id']),
      unlockedAt: serializer.fromJson<DateTime>(json['unlockedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'unlockedAt': serializer.toJson<DateTime>(unlockedAt),
    };
  }

  AchievementRow copyWith({String? id, DateTime? unlockedAt}) => AchievementRow(
    id: id ?? this.id,
    unlockedAt: unlockedAt ?? this.unlockedAt,
  );
  AchievementRow copyWithCompanion(AchievementsTableCompanion data) {
    return AchievementRow(
      id: data.id.present ? data.id.value : this.id,
      unlockedAt: data.unlockedAt.present
          ? data.unlockedAt.value
          : this.unlockedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AchievementRow(')
          ..write('id: $id, ')
          ..write('unlockedAt: $unlockedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, unlockedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AchievementRow &&
          other.id == this.id &&
          other.unlockedAt == this.unlockedAt);
}

class AchievementsTableCompanion extends UpdateCompanion<AchievementRow> {
  final Value<String> id;
  final Value<DateTime> unlockedAt;
  final Value<int> rowid;
  const AchievementsTableCompanion({
    this.id = const Value.absent(),
    this.unlockedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AchievementsTableCompanion.insert({
    required String id,
    this.unlockedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id);
  static Insertable<AchievementRow> custom({
    Expression<String>? id,
    Expression<DateTime>? unlockedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (unlockedAt != null) 'unlocked_at': unlockedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AchievementsTableCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? unlockedAt,
    Value<int>? rowid,
  }) {
    return AchievementsTableCompanion(
      id: id ?? this.id,
      unlockedAt: unlockedAt ?? this.unlockedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (unlockedAt.present) {
      map['unlocked_at'] = Variable<DateTime>(unlockedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AchievementsTableCompanion(')
          ..write('id: $id, ')
          ..write('unlockedAt: $unlockedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PreferencesTableTable extends PreferencesTable
    with TableInfo<$PreferencesTableTable, PreferenceRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PreferencesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [key, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'preferences';
  @override
  VerificationContext validateIntegrity(
    Insertable<PreferenceRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  PreferenceRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PreferenceRow(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
    );
  }

  @override
  $PreferencesTableTable createAlias(String alias) {
    return $PreferencesTableTable(attachedDatabase, alias);
  }
}

class PreferenceRow extends DataClass implements Insertable<PreferenceRow> {
  final String key;
  final String value;
  const PreferenceRow({required this.key, required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    return map;
  }

  PreferencesTableCompanion toCompanion(bool nullToAbsent) {
    return PreferencesTableCompanion(key: Value(key), value: Value(value));
  }

  factory PreferenceRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PreferenceRow(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
    };
  }

  PreferenceRow copyWith({String? key, String? value}) =>
      PreferenceRow(key: key ?? this.key, value: value ?? this.value);
  PreferenceRow copyWithCompanion(PreferencesTableCompanion data) {
    return PreferenceRow(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PreferenceRow(')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PreferenceRow &&
          other.key == this.key &&
          other.value == this.value);
}

class PreferencesTableCompanion extends UpdateCompanion<PreferenceRow> {
  final Value<String> key;
  final Value<String> value;
  final Value<int> rowid;
  const PreferencesTableCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PreferencesTableCompanion.insert({
    required String key,
    required String value,
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       value = Value(value);
  static Insertable<PreferenceRow> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PreferencesTableCompanion copyWith({
    Value<String>? key,
    Value<String>? value,
    Value<int>? rowid,
  }) {
    return PreferencesTableCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PreferencesTableCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $SyncMetadataTableTable syncMetadataTable =
      $SyncMetadataTableTable(this);
  late final $FavoritesTableTable favoritesTable = $FavoritesTableTable(this);
  late final $PokemonTableTable pokemonTable = $PokemonTableTable(this);
  late final $TypesTableTable typesTable = $TypesTableTable(this);
  late final $PokemonTypesTableTable pokemonTypesTable =
      $PokemonTypesTableTable(this);
  late final $TypeEfficaciesTableTable typeEfficaciesTable =
      $TypeEfficaciesTableTable(this);
  late final $StatsTableTable statsTable = $StatsTableTable(this);
  late final $PokemonStatsTableTable pokemonStatsTable =
      $PokemonStatsTableTable(this);
  late final $EggGroupsTableTable eggGroupsTable = $EggGroupsTableTable(this);
  late final $PokemonEggGroupsTableTable pokemonEggGroupsTable =
      $PokemonEggGroupsTableTable(this);
  late final $AbilitiesTableTable abilitiesTable = $AbilitiesTableTable(this);
  late final $PokemonAbilitiesTableTable pokemonAbilitiesTable =
      $PokemonAbilitiesTableTable(this);
  late final $EvolutionSpeciesTableTable evolutionSpeciesTable =
      $EvolutionSpeciesTableTable(this);
  late final $EvolutionMethodsTableTable evolutionMethodsTable =
      $EvolutionMethodsTableTable(this);
  late final $MovesTableTable movesTable = $MovesTableTable(this);
  late final $PokemonMovesTableTable pokemonMovesTable =
      $PokemonMovesTableTable(this);
  late final $TriviaResultsTableTable triviaResultsTable =
      $TriviaResultsTableTable(this);
  late final $TriviaAnswersTableTable triviaAnswersTable =
      $TriviaAnswersTableTable(this);
  late final $AchievementsTableTable achievementsTable =
      $AchievementsTableTable(this);
  late final $PreferencesTableTable preferencesTable = $PreferencesTableTable(
    this,
  );
  late final Index pokemonNameIdx = Index(
    'pokemon_name_idx',
    'CREATE INDEX pokemon_name_idx ON pokemon (name)',
  );
  late final Index pokemonDexNumberIdx = Index(
    'pokemon_dex_number_idx',
    'CREATE INDEX pokemon_dex_number_idx ON pokemon (dex_number)',
  );
  late final Index pokemonGenIdx = Index(
    'pokemon_gen_idx',
    'CREATE INDEX pokemon_gen_idx ON pokemon (generation_id)',
  );
  late final Index evolutionSpeciesChainIdx = Index(
    'evolution_species_chain_idx',
    'CREATE INDEX evolution_species_chain_idx ON evolution_species (chain_id)',
  );
  late final Index triviaResultsScoreIdx = Index(
    'trivia_results_score_idx',
    'CREATE INDEX trivia_results_score_idx ON trivia_results (score)',
  );
  late final SyncMetadataDao syncMetadataDao = SyncMetadataDao(
    this as AppDatabase,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    syncMetadataTable,
    favoritesTable,
    pokemonTable,
    typesTable,
    pokemonTypesTable,
    typeEfficaciesTable,
    statsTable,
    pokemonStatsTable,
    eggGroupsTable,
    pokemonEggGroupsTable,
    abilitiesTable,
    pokemonAbilitiesTable,
    evolutionSpeciesTable,
    evolutionMethodsTable,
    movesTable,
    pokemonMovesTable,
    triviaResultsTable,
    triviaAnswersTable,
    achievementsTable,
    preferencesTable,
    pokemonNameIdx,
    pokemonDexNumberIdx,
    pokemonGenIdx,
    evolutionSpeciesChainIdx,
    triviaResultsScoreIdx,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'pokemon',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('pokemon_types', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'types',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('pokemon_types', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'types',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('type_efficacies', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'types',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('type_efficacies', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'pokemon',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('pokemon_stats', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'stats',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('pokemon_stats', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'pokemon',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('pokemon_egg_groups', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'egg_groups',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('pokemon_egg_groups', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'pokemon',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('pokemon_abilities', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'abilities',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('pokemon_abilities', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'evolution_species',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('evolution_methods', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'pokemon',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('pokemon_moves', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'moves',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('pokemon_moves', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'trivia_results',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('trivia_answers', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$SyncMetadataTableTableCreateCompanionBuilder =
    SyncMetadataTableCompanion Function({
      required String resourceKey,
      Value<DateTime?> lastSuccessAt,
      Value<SyncState> status,
      Value<int> nextOffset,
      Value<int?> totalRemote,
      Value<int> rowid,
    });
typedef $$SyncMetadataTableTableUpdateCompanionBuilder =
    SyncMetadataTableCompanion Function({
      Value<String> resourceKey,
      Value<DateTime?> lastSuccessAt,
      Value<SyncState> status,
      Value<int> nextOffset,
      Value<int?> totalRemote,
      Value<int> rowid,
    });

class $$SyncMetadataTableTableFilterComposer
    extends Composer<_$AppDatabase, $SyncMetadataTableTable> {
  $$SyncMetadataTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get resourceKey => $composableBuilder(
    column: $table.resourceKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastSuccessAt => $composableBuilder(
    column: $table.lastSuccessAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<SyncState, SyncState, String> get status =>
      $composableBuilder(
        column: $table.status,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<int> get nextOffset => $composableBuilder(
    column: $table.nextOffset,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalRemote => $composableBuilder(
    column: $table.totalRemote,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SyncMetadataTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncMetadataTableTable> {
  $$SyncMetadataTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get resourceKey => $composableBuilder(
    column: $table.resourceKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastSuccessAt => $composableBuilder(
    column: $table.lastSuccessAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get nextOffset => $composableBuilder(
    column: $table.nextOffset,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalRemote => $composableBuilder(
    column: $table.totalRemote,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncMetadataTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncMetadataTableTable> {
  $$SyncMetadataTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get resourceKey => $composableBuilder(
    column: $table.resourceKey,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastSuccessAt => $composableBuilder(
    column: $table.lastSuccessAt,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<SyncState, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get nextOffset => $composableBuilder(
    column: $table.nextOffset,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalRemote => $composableBuilder(
    column: $table.totalRemote,
    builder: (column) => column,
  );
}

class $$SyncMetadataTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SyncMetadataTableTable,
          SyncMetadataRow,
          $$SyncMetadataTableTableFilterComposer,
          $$SyncMetadataTableTableOrderingComposer,
          $$SyncMetadataTableTableAnnotationComposer,
          $$SyncMetadataTableTableCreateCompanionBuilder,
          $$SyncMetadataTableTableUpdateCompanionBuilder,
          (
            SyncMetadataRow,
            BaseReferences<
              _$AppDatabase,
              $SyncMetadataTableTable,
              SyncMetadataRow
            >,
          ),
          SyncMetadataRow,
          PrefetchHooks Function()
        > {
  $$SyncMetadataTableTableTableManager(
    _$AppDatabase db,
    $SyncMetadataTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncMetadataTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncMetadataTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncMetadataTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> resourceKey = const Value.absent(),
                Value<DateTime?> lastSuccessAt = const Value.absent(),
                Value<SyncState> status = const Value.absent(),
                Value<int> nextOffset = const Value.absent(),
                Value<int?> totalRemote = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncMetadataTableCompanion(
                resourceKey: resourceKey,
                lastSuccessAt: lastSuccessAt,
                status: status,
                nextOffset: nextOffset,
                totalRemote: totalRemote,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String resourceKey,
                Value<DateTime?> lastSuccessAt = const Value.absent(),
                Value<SyncState> status = const Value.absent(),
                Value<int> nextOffset = const Value.absent(),
                Value<int?> totalRemote = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncMetadataTableCompanion.insert(
                resourceKey: resourceKey,
                lastSuccessAt: lastSuccessAt,
                status: status,
                nextOffset: nextOffset,
                totalRemote: totalRemote,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SyncMetadataTableTable, SyncMetadataRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $SyncMetadataTableTable,
                    SyncMetadataRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncMetadataTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SyncMetadataTableTable,
      SyncMetadataRow,
      $$SyncMetadataTableTableFilterComposer,
      $$SyncMetadataTableTableOrderingComposer,
      $$SyncMetadataTableTableAnnotationComposer,
      $$SyncMetadataTableTableCreateCompanionBuilder,
      $$SyncMetadataTableTableUpdateCompanionBuilder,
      (
        SyncMetadataRow,
        BaseReferences<_$AppDatabase, $SyncMetadataTableTable, SyncMetadataRow>,
      ),
      SyncMetadataRow,
      PrefetchHooks Function()
    >;
typedef $$FavoritesTableTableCreateCompanionBuilder =
    FavoritesTableCompanion Function({
      Value<int> pokemonId,
      Value<DateTime> createdAt,
    });
typedef $$FavoritesTableTableUpdateCompanionBuilder =
    FavoritesTableCompanion Function({
      Value<int> pokemonId,
      Value<DateTime> createdAt,
    });

class $$FavoritesTableTableFilterComposer
    extends Composer<_$AppDatabase, $FavoritesTableTable> {
  $$FavoritesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get pokemonId => $composableBuilder(
    column: $table.pokemonId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FavoritesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $FavoritesTableTable> {
  $$FavoritesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get pokemonId => $composableBuilder(
    column: $table.pokemonId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FavoritesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $FavoritesTableTable> {
  $$FavoritesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get pokemonId =>
      $composableBuilder(column: $table.pokemonId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$FavoritesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FavoritesTableTable,
          FavoriteRow,
          $$FavoritesTableTableFilterComposer,
          $$FavoritesTableTableOrderingComposer,
          $$FavoritesTableTableAnnotationComposer,
          $$FavoritesTableTableCreateCompanionBuilder,
          $$FavoritesTableTableUpdateCompanionBuilder,
          (
            FavoriteRow,
            BaseReferences<_$AppDatabase, $FavoritesTableTable, FavoriteRow>,
          ),
          FavoriteRow,
          PrefetchHooks Function()
        > {
  $$FavoritesTableTableTableManager(
    _$AppDatabase db,
    $FavoritesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FavoritesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FavoritesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FavoritesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> pokemonId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => FavoritesTableCompanion(
                pokemonId: pokemonId,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> pokemonId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => FavoritesTableCompanion.insert(
                pokemonId: pokemonId,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$FavoritesTableTable, FavoriteRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $FavoritesTableTable,
                    FavoriteRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FavoritesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FavoritesTableTable,
      FavoriteRow,
      $$FavoritesTableTableFilterComposer,
      $$FavoritesTableTableOrderingComposer,
      $$FavoritesTableTableAnnotationComposer,
      $$FavoritesTableTableCreateCompanionBuilder,
      $$FavoritesTableTableUpdateCompanionBuilder,
      (
        FavoriteRow,
        BaseReferences<_$AppDatabase, $FavoritesTableTable, FavoriteRow>,
      ),
      FavoriteRow,
      PrefetchHooks Function()
    >;
typedef $$PokemonTableTableCreateCompanionBuilder =
    PokemonTableCompanion Function({
      Value<int> id,
      required int dexNumber,
      required String name,
      Value<String?> spriteUrl,
      Value<String?> artworkUrl,
      required DateTime updatedAt,
      Value<int?> height,
      Value<int?> weight,
      Value<int?> generationId,
      Value<bool> isDefault,
    });
typedef $$PokemonTableTableUpdateCompanionBuilder =
    PokemonTableCompanion Function({
      Value<int> id,
      Value<int> dexNumber,
      Value<String> name,
      Value<String?> spriteUrl,
      Value<String?> artworkUrl,
      Value<DateTime> updatedAt,
      Value<int?> height,
      Value<int?> weight,
      Value<int?> generationId,
      Value<bool> isDefault,
    });

final class $$PokemonTableTableReferences
    extends BaseReferences<_$AppDatabase, $PokemonTableTable, PokemonRow> {
  $$PokemonTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$PokemonTypesTableTable, List<PokemonTypeRow>>
  _pokemonTypesTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.pokemonTypesTable,
        aliasName: 'pokemon__id__pokemon_types__pokemon_id',
      );

  $$PokemonTypesTableTableProcessedTableManager get pokemonTypesTableRefs {
    final manager = $$PokemonTypesTableTableTableManager(
      $_db,
      $_db.pokemonTypesTable,
    ).filter((f) => f.pokemonId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _pokemonTypesTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PokemonStatsTableTable, List<PokemonStatRow>>
  _pokemonStatsTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.pokemonStatsTable,
        aliasName: 'pokemon__id__pokemon_stats__pokemon_id',
      );

  $$PokemonStatsTableTableProcessedTableManager get pokemonStatsTableRefs {
    final manager = $$PokemonStatsTableTableTableManager(
      $_db,
      $_db.pokemonStatsTable,
    ).filter((f) => f.pokemonId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _pokemonStatsTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $PokemonEggGroupsTableTable,
    List<PokemonEggGroupRow>
  >
  _pokemonEggGroupsTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.pokemonEggGroupsTable,
        aliasName: 'pokemon__id__pokemon_egg_groups__pokemon_id',
      );

  $$PokemonEggGroupsTableTableProcessedTableManager
  get pokemonEggGroupsTableRefs {
    final manager = $$PokemonEggGroupsTableTableTableManager(
      $_db,
      $_db.pokemonEggGroupsTable,
    ).filter((f) => f.pokemonId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _pokemonEggGroupsTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $PokemonAbilitiesTableTable,
    List<PokemonAbilityRow>
  >
  _pokemonAbilitiesTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.pokemonAbilitiesTable,
        aliasName: 'pokemon__id__pokemon_abilities__pokemon_id',
      );

  $$PokemonAbilitiesTableTableProcessedTableManager
  get pokemonAbilitiesTableRefs {
    final manager = $$PokemonAbilitiesTableTableTableManager(
      $_db,
      $_db.pokemonAbilitiesTable,
    ).filter((f) => f.pokemonId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _pokemonAbilitiesTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PokemonMovesTableTable, List<PokemonMoveRow>>
  _pokemonMovesTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.pokemonMovesTable,
        aliasName: 'pokemon__id__pokemon_moves__pokemon_id',
      );

  $$PokemonMovesTableTableProcessedTableManager get pokemonMovesTableRefs {
    final manager = $$PokemonMovesTableTableTableManager(
      $_db,
      $_db.pokemonMovesTable,
    ).filter((f) => f.pokemonId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _pokemonMovesTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PokemonTableTableFilterComposer
    extends Composer<_$AppDatabase, $PokemonTableTable> {
  $$PokemonTableTableFilterComposer({
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

  ColumnFilters<int> get dexNumber => $composableBuilder(
    column: $table.dexNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get spriteUrl => $composableBuilder(
    column: $table.spriteUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get artworkUrl => $composableBuilder(
    column: $table.artworkUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get height => $composableBuilder(
    column: $table.height,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get weight => $composableBuilder(
    column: $table.weight,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get generationId => $composableBuilder(
    column: $table.generationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDefault => $composableBuilder(
    column: $table.isDefault,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> pokemonTypesTableRefs(
    Expression<bool> Function($$PokemonTypesTableTableFilterComposer f) f,
  ) {
    final $$PokemonTypesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pokemonTypesTable,
      getReferencedColumn: (t) => t.pokemonId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonTypesTableTableFilterComposer(
            $db: $db,
            $table: $db.pokemonTypesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> pokemonStatsTableRefs(
    Expression<bool> Function($$PokemonStatsTableTableFilterComposer f) f,
  ) {
    final $$PokemonStatsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pokemonStatsTable,
      getReferencedColumn: (t) => t.pokemonId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonStatsTableTableFilterComposer(
            $db: $db,
            $table: $db.pokemonStatsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> pokemonEggGroupsTableRefs(
    Expression<bool> Function($$PokemonEggGroupsTableTableFilterComposer f) f,
  ) {
    final $$PokemonEggGroupsTableTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.pokemonEggGroupsTable,
          getReferencedColumn: (t) => t.pokemonId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PokemonEggGroupsTableTableFilterComposer(
                $db: $db,
                $table: $db.pokemonEggGroupsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> pokemonAbilitiesTableRefs(
    Expression<bool> Function($$PokemonAbilitiesTableTableFilterComposer f) f,
  ) {
    final $$PokemonAbilitiesTableTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.pokemonAbilitiesTable,
          getReferencedColumn: (t) => t.pokemonId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PokemonAbilitiesTableTableFilterComposer(
                $db: $db,
                $table: $db.pokemonAbilitiesTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> pokemonMovesTableRefs(
    Expression<bool> Function($$PokemonMovesTableTableFilterComposer f) f,
  ) {
    final $$PokemonMovesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pokemonMovesTable,
      getReferencedColumn: (t) => t.pokemonId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonMovesTableTableFilterComposer(
            $db: $db,
            $table: $db.pokemonMovesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PokemonTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PokemonTableTable> {
  $$PokemonTableTableOrderingComposer({
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

  ColumnOrderings<int> get dexNumber => $composableBuilder(
    column: $table.dexNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get spriteUrl => $composableBuilder(
    column: $table.spriteUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get artworkUrl => $composableBuilder(
    column: $table.artworkUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get height => $composableBuilder(
    column: $table.height,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get weight => $composableBuilder(
    column: $table.weight,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get generationId => $composableBuilder(
    column: $table.generationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDefault => $composableBuilder(
    column: $table.isDefault,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PokemonTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PokemonTableTable> {
  $$PokemonTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get dexNumber =>
      $composableBuilder(column: $table.dexNumber, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get spriteUrl =>
      $composableBuilder(column: $table.spriteUrl, builder: (column) => column);

  GeneratedColumn<String> get artworkUrl => $composableBuilder(
    column: $table.artworkUrl,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<int> get height =>
      $composableBuilder(column: $table.height, builder: (column) => column);

  GeneratedColumn<int> get weight =>
      $composableBuilder(column: $table.weight, builder: (column) => column);

  GeneratedColumn<int> get generationId => $composableBuilder(
    column: $table.generationId,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isDefault =>
      $composableBuilder(column: $table.isDefault, builder: (column) => column);

  Expression<T> pokemonTypesTableRefs<T extends Object>(
    Expression<T> Function($$PokemonTypesTableTableAnnotationComposer a) f,
  ) {
    final $$PokemonTypesTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.pokemonTypesTable,
          getReferencedColumn: (t) => t.pokemonId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PokemonTypesTableTableAnnotationComposer(
                $db: $db,
                $table: $db.pokemonTypesTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> pokemonStatsTableRefs<T extends Object>(
    Expression<T> Function($$PokemonStatsTableTableAnnotationComposer a) f,
  ) {
    final $$PokemonStatsTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.pokemonStatsTable,
          getReferencedColumn: (t) => t.pokemonId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PokemonStatsTableTableAnnotationComposer(
                $db: $db,
                $table: $db.pokemonStatsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> pokemonEggGroupsTableRefs<T extends Object>(
    Expression<T> Function($$PokemonEggGroupsTableTableAnnotationComposer a) f,
  ) {
    final $$PokemonEggGroupsTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.pokemonEggGroupsTable,
          getReferencedColumn: (t) => t.pokemonId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PokemonEggGroupsTableTableAnnotationComposer(
                $db: $db,
                $table: $db.pokemonEggGroupsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> pokemonAbilitiesTableRefs<T extends Object>(
    Expression<T> Function($$PokemonAbilitiesTableTableAnnotationComposer a) f,
  ) {
    final $$PokemonAbilitiesTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.pokemonAbilitiesTable,
          getReferencedColumn: (t) => t.pokemonId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PokemonAbilitiesTableTableAnnotationComposer(
                $db: $db,
                $table: $db.pokemonAbilitiesTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> pokemonMovesTableRefs<T extends Object>(
    Expression<T> Function($$PokemonMovesTableTableAnnotationComposer a) f,
  ) {
    final $$PokemonMovesTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.pokemonMovesTable,
          getReferencedColumn: (t) => t.pokemonId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PokemonMovesTableTableAnnotationComposer(
                $db: $db,
                $table: $db.pokemonMovesTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$PokemonTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PokemonTableTable,
          PokemonRow,
          $$PokemonTableTableFilterComposer,
          $$PokemonTableTableOrderingComposer,
          $$PokemonTableTableAnnotationComposer,
          $$PokemonTableTableCreateCompanionBuilder,
          $$PokemonTableTableUpdateCompanionBuilder,
          (PokemonRow, $$PokemonTableTableReferences),
          PokemonRow,
          PrefetchHooks Function({
            bool pokemonTypesTableRefs,
            bool pokemonStatsTableRefs,
            bool pokemonEggGroupsTableRefs,
            bool pokemonAbilitiesTableRefs,
            bool pokemonMovesTableRefs,
          })
        > {
  $$PokemonTableTableTableManager(_$AppDatabase db, $PokemonTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PokemonTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PokemonTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PokemonTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> dexNumber = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> spriteUrl = const Value.absent(),
                Value<String?> artworkUrl = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int?> height = const Value.absent(),
                Value<int?> weight = const Value.absent(),
                Value<int?> generationId = const Value.absent(),
                Value<bool> isDefault = const Value.absent(),
              }) => PokemonTableCompanion(
                id: id,
                dexNumber: dexNumber,
                name: name,
                spriteUrl: spriteUrl,
                artworkUrl: artworkUrl,
                updatedAt: updatedAt,
                height: height,
                weight: weight,
                generationId: generationId,
                isDefault: isDefault,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int dexNumber,
                required String name,
                Value<String?> spriteUrl = const Value.absent(),
                Value<String?> artworkUrl = const Value.absent(),
                required DateTime updatedAt,
                Value<int?> height = const Value.absent(),
                Value<int?> weight = const Value.absent(),
                Value<int?> generationId = const Value.absent(),
                Value<bool> isDefault = const Value.absent(),
              }) => PokemonTableCompanion.insert(
                id: id,
                dexNumber: dexNumber,
                name: name,
                spriteUrl: spriteUrl,
                artworkUrl: artworkUrl,
                updatedAt: updatedAt,
                height: height,
                weight: weight,
                generationId: generationId,
                isDefault: isDefault,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PokemonTableTable, PokemonRow>(table),
                  $$PokemonTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                pokemonTypesTableRefs = false,
                pokemonStatsTableRefs = false,
                pokemonEggGroupsTableRefs = false,
                pokemonAbilitiesTableRefs = false,
                pokemonMovesTableRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (pokemonTypesTableRefs) db.pokemonTypesTable,
                    if (pokemonStatsTableRefs) db.pokemonStatsTable,
                    if (pokemonEggGroupsTableRefs) db.pokemonEggGroupsTable,
                    if (pokemonAbilitiesTableRefs) db.pokemonAbilitiesTable,
                    if (pokemonMovesTableRefs) db.pokemonMovesTable,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (pokemonTypesTableRefs)
                        await $_getPrefetchedDataByColumns<
                          PokemonRow,
                          $PokemonTableTable,
                          PokemonTypeRow,
                          $PokemonTypesTableTable
                        >(
                          currentTable: table,
                          referencedTable: $$PokemonTableTableReferences
                              ._pokemonTypesTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PokemonTableTableReferences(
                                db,
                                table,
                                p0,
                              ).pokemonTypesTableRefs,
                          currentColumn: 'id',
                          referencedColumn: 'pokemon_id',
                          typedResults: items,
                        ),
                      if (pokemonStatsTableRefs)
                        await $_getPrefetchedDataByColumns<
                          PokemonRow,
                          $PokemonTableTable,
                          PokemonStatRow,
                          $PokemonStatsTableTable
                        >(
                          currentTable: table,
                          referencedTable: $$PokemonTableTableReferences
                              ._pokemonStatsTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PokemonTableTableReferences(
                                db,
                                table,
                                p0,
                              ).pokemonStatsTableRefs,
                          currentColumn: 'id',
                          referencedColumn: 'pokemon_id',
                          typedResults: items,
                        ),
                      if (pokemonEggGroupsTableRefs)
                        await $_getPrefetchedDataByColumns<
                          PokemonRow,
                          $PokemonTableTable,
                          PokemonEggGroupRow,
                          $PokemonEggGroupsTableTable
                        >(
                          currentTable: table,
                          referencedTable: $$PokemonTableTableReferences
                              ._pokemonEggGroupsTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PokemonTableTableReferences(
                                db,
                                table,
                                p0,
                              ).pokemonEggGroupsTableRefs,
                          currentColumn: 'id',
                          referencedColumn: 'pokemon_id',
                          typedResults: items,
                        ),
                      if (pokemonAbilitiesTableRefs)
                        await $_getPrefetchedDataByColumns<
                          PokemonRow,
                          $PokemonTableTable,
                          PokemonAbilityRow,
                          $PokemonAbilitiesTableTable
                        >(
                          currentTable: table,
                          referencedTable: $$PokemonTableTableReferences
                              ._pokemonAbilitiesTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PokemonTableTableReferences(
                                db,
                                table,
                                p0,
                              ).pokemonAbilitiesTableRefs,
                          currentColumn: 'id',
                          referencedColumn: 'pokemon_id',
                          typedResults: items,
                        ),
                      if (pokemonMovesTableRefs)
                        await $_getPrefetchedDataByColumns<
                          PokemonRow,
                          $PokemonTableTable,
                          PokemonMoveRow,
                          $PokemonMovesTableTable
                        >(
                          currentTable: table,
                          referencedTable: $$PokemonTableTableReferences
                              ._pokemonMovesTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PokemonTableTableReferences(
                                db,
                                table,
                                p0,
                              ).pokemonMovesTableRefs,
                          currentColumn: 'id',
                          referencedColumn: 'pokemon_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$PokemonTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PokemonTableTable,
      PokemonRow,
      $$PokemonTableTableFilterComposer,
      $$PokemonTableTableOrderingComposer,
      $$PokemonTableTableAnnotationComposer,
      $$PokemonTableTableCreateCompanionBuilder,
      $$PokemonTableTableUpdateCompanionBuilder,
      (PokemonRow, $$PokemonTableTableReferences),
      PokemonRow,
      PrefetchHooks Function({
        bool pokemonTypesTableRefs,
        bool pokemonStatsTableRefs,
        bool pokemonEggGroupsTableRefs,
        bool pokemonAbilitiesTableRefs,
        bool pokemonMovesTableRefs,
      })
    >;
typedef $$TypesTableTableCreateCompanionBuilder = TypesTableCompanion Function({
  Value<int> id,
  required String name,
});
typedef $$TypesTableTableUpdateCompanionBuilder = TypesTableCompanion Function({
  Value<int> id,
  Value<String> name,
});

final class $$TypesTableTableReferences
    extends BaseReferences<_$AppDatabase, $TypesTableTable, TypeRow> {
  $$TypesTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$PokemonTypesTableTable, List<PokemonTypeRow>>
  _pokemonTypesTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.pokemonTypesTable,
        aliasName: 'types__id__pokemon_types__type_id',
      );

  $$PokemonTypesTableTableProcessedTableManager get pokemonTypesTableRefs {
    final manager = $$PokemonTypesTableTableTableManager(
      $_db,
      $_db.pokemonTypesTable,
    ).filter((f) => f.typeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _pokemonTypesTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$TypeEfficaciesTableTable, List<TypeEfficacyRow>>
  _defendingEfficaciesTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.typeEfficaciesTable,
    aliasName: 'types__id__type_efficacies__defending_type_id',
  );

  $$TypeEfficaciesTableTableProcessedTableManager get defendingEfficacies {
    final manager = $$TypeEfficaciesTableTableTableManager(
      $_db,
      $_db.typeEfficaciesTable,
    ).filter((f) => f.defendingTypeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _defendingEfficaciesTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$TypeEfficaciesTableTable, List<TypeEfficacyRow>>
  _attackingEfficaciesTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.typeEfficaciesTable,
    aliasName: 'types__id__type_efficacies__attacking_type_id',
  );

  $$TypeEfficaciesTableTableProcessedTableManager get attackingEfficacies {
    final manager = $$TypeEfficaciesTableTableTableManager(
      $_db,
      $_db.typeEfficaciesTable,
    ).filter((f) => f.attackingTypeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _attackingEfficaciesTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TypesTableTableFilterComposer
    extends Composer<_$AppDatabase, $TypesTableTable> {
  $$TypesTableTableFilterComposer({
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

  Expression<bool> pokemonTypesTableRefs(
    Expression<bool> Function($$PokemonTypesTableTableFilterComposer f) f,
  ) {
    final $$PokemonTypesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pokemonTypesTable,
      getReferencedColumn: (t) => t.typeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonTypesTableTableFilterComposer(
            $db: $db,
            $table: $db.pokemonTypesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> defendingEfficacies(
    Expression<bool> Function($$TypeEfficaciesTableTableFilterComposer f) f,
  ) {
    final $$TypeEfficaciesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.typeEfficaciesTable,
      getReferencedColumn: (t) => t.defendingTypeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TypeEfficaciesTableTableFilterComposer(
            $db: $db,
            $table: $db.typeEfficaciesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> attackingEfficacies(
    Expression<bool> Function($$TypeEfficaciesTableTableFilterComposer f) f,
  ) {
    final $$TypeEfficaciesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.typeEfficaciesTable,
      getReferencedColumn: (t) => t.attackingTypeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TypeEfficaciesTableTableFilterComposer(
            $db: $db,
            $table: $db.typeEfficaciesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TypesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $TypesTableTable> {
  $$TypesTableTableOrderingComposer({
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
}

class $$TypesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $TypesTableTable> {
  $$TypesTableTableAnnotationComposer({
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

  Expression<T> pokemonTypesTableRefs<T extends Object>(
    Expression<T> Function($$PokemonTypesTableTableAnnotationComposer a) f,
  ) {
    final $$PokemonTypesTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.pokemonTypesTable,
          getReferencedColumn: (t) => t.typeId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PokemonTypesTableTableAnnotationComposer(
                $db: $db,
                $table: $db.pokemonTypesTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> defendingEfficacies<T extends Object>(
    Expression<T> Function($$TypeEfficaciesTableTableAnnotationComposer a) f,
  ) {
    final $$TypeEfficaciesTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.typeEfficaciesTable,
          getReferencedColumn: (t) => t.defendingTypeId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$TypeEfficaciesTableTableAnnotationComposer(
                $db: $db,
                $table: $db.typeEfficaciesTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> attackingEfficacies<T extends Object>(
    Expression<T> Function($$TypeEfficaciesTableTableAnnotationComposer a) f,
  ) {
    final $$TypeEfficaciesTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.typeEfficaciesTable,
          getReferencedColumn: (t) => t.attackingTypeId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$TypeEfficaciesTableTableAnnotationComposer(
                $db: $db,
                $table: $db.typeEfficaciesTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$TypesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TypesTableTable,
          TypeRow,
          $$TypesTableTableFilterComposer,
          $$TypesTableTableOrderingComposer,
          $$TypesTableTableAnnotationComposer,
          $$TypesTableTableCreateCompanionBuilder,
          $$TypesTableTableUpdateCompanionBuilder,
          (TypeRow, $$TypesTableTableReferences),
          TypeRow,
          PrefetchHooks Function({
            bool pokemonTypesTableRefs,
            bool defendingEfficacies,
            bool attackingEfficacies,
          })
        > {
  $$TypesTableTableTableManager(_$AppDatabase db, $TypesTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TypesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TypesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TypesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
          }) => TypesTableCompanion(id: id, name: name),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
          }) => TypesTableCompanion.insert(id: id, name: name),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TypesTableTable, TypeRow>(table),
                  $$TypesTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                pokemonTypesTableRefs = false,
                defendingEfficacies = false,
                attackingEfficacies = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (pokemonTypesTableRefs) db.pokemonTypesTable,
                    if (defendingEfficacies) db.typeEfficaciesTable,
                    if (attackingEfficacies) db.typeEfficaciesTable,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (pokemonTypesTableRefs)
                        await $_getPrefetchedDataByColumns<
                          TypeRow,
                          $TypesTableTable,
                          PokemonTypeRow,
                          $PokemonTypesTableTable
                        >(
                          currentTable: table,
                          referencedTable: $$TypesTableTableReferences
                              ._pokemonTypesTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TypesTableTableReferences(
                                db,
                                table,
                                p0,
                              ).pokemonTypesTableRefs,
                          currentColumn: 'id',
                          referencedColumn: 'type_id',
                          typedResults: items,
                        ),
                      if (defendingEfficacies)
                        await $_getPrefetchedDataByColumns<
                          TypeRow,
                          $TypesTableTable,
                          TypeEfficacyRow,
                          $TypeEfficaciesTableTable
                        >(
                          currentTable: table,
                          referencedTable: $$TypesTableTableReferences
                              ._defendingEfficaciesTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TypesTableTableReferences(
                                db,
                                table,
                                p0,
                              ).defendingEfficacies,
                          currentColumn: 'id',
                          referencedColumn: 'defending_type_id',
                          typedResults: items,
                        ),
                      if (attackingEfficacies)
                        await $_getPrefetchedDataByColumns<
                          TypeRow,
                          $TypesTableTable,
                          TypeEfficacyRow,
                          $TypeEfficaciesTableTable
                        >(
                          currentTable: table,
                          referencedTable: $$TypesTableTableReferences
                              ._attackingEfficaciesTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TypesTableTableReferences(
                                db,
                                table,
                                p0,
                              ).attackingEfficacies,
                          currentColumn: 'id',
                          referencedColumn: 'attacking_type_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$TypesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TypesTableTable,
      TypeRow,
      $$TypesTableTableFilterComposer,
      $$TypesTableTableOrderingComposer,
      $$TypesTableTableAnnotationComposer,
      $$TypesTableTableCreateCompanionBuilder,
      $$TypesTableTableUpdateCompanionBuilder,
      (TypeRow, $$TypesTableTableReferences),
      TypeRow,
      PrefetchHooks Function({
        bool pokemonTypesTableRefs,
        bool defendingEfficacies,
        bool attackingEfficacies,
      })
    >;
typedef $$PokemonTypesTableTableCreateCompanionBuilder =
    PokemonTypesTableCompanion Function({
      required int pokemonId,
      required int typeId,
      required int slot,
      Value<int> rowid,
    });
typedef $$PokemonTypesTableTableUpdateCompanionBuilder =
    PokemonTypesTableCompanion Function({
      Value<int> pokemonId,
      Value<int> typeId,
      Value<int> slot,
      Value<int> rowid,
    });

final class $$PokemonTypesTableTableReferences
    extends
        BaseReferences<_$AppDatabase, $PokemonTypesTableTable, PokemonTypeRow> {
  $$PokemonTypesTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $PokemonTableTable _pokemonIdTable(_$AppDatabase db) =>
      db.pokemonTable.createAlias('pokemon_types__pokemon_id__pokemon__id');

  $$PokemonTableTableProcessedTableManager get pokemonId {
    final $_column = $_itemColumn<int>('pokemon_id')!;

    final manager = $$PokemonTableTableTableManager(
      $_db,
      $_db.pokemonTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_pokemonIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TypesTableTable _typeIdTable(_$AppDatabase db) =>
      db.typesTable.createAlias('pokemon_types__type_id__types__id');

  $$TypesTableTableProcessedTableManager get typeId {
    final $_column = $_itemColumn<int>('type_id')!;

    final manager = $$TypesTableTableTableManager(
      $_db,
      $_db.typesTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_typeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PokemonTypesTableTableFilterComposer
    extends Composer<_$AppDatabase, $PokemonTypesTableTable> {
  $$PokemonTypesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get slot => $composableBuilder(
    column: $table.slot,
    builder: (column) => ColumnFilters(column),
  );

  $$PokemonTableTableFilterComposer get pokemonId {
    final $$PokemonTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pokemonId,
      referencedTable: $db.pokemonTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonTableTableFilterComposer(
            $db: $db,
            $table: $db.pokemonTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TypesTableTableFilterComposer get typeId {
    final $$TypesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.typeId,
      referencedTable: $db.typesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TypesTableTableFilterComposer(
            $db: $db,
            $table: $db.typesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PokemonTypesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PokemonTypesTableTable> {
  $$PokemonTypesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get slot => $composableBuilder(
    column: $table.slot,
    builder: (column) => ColumnOrderings(column),
  );

  $$PokemonTableTableOrderingComposer get pokemonId {
    final $$PokemonTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pokemonId,
      referencedTable: $db.pokemonTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonTableTableOrderingComposer(
            $db: $db,
            $table: $db.pokemonTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TypesTableTableOrderingComposer get typeId {
    final $$TypesTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.typeId,
      referencedTable: $db.typesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TypesTableTableOrderingComposer(
            $db: $db,
            $table: $db.typesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PokemonTypesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PokemonTypesTableTable> {
  $$PokemonTypesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get slot =>
      $composableBuilder(column: $table.slot, builder: (column) => column);

  $$PokemonTableTableAnnotationComposer get pokemonId {
    final $$PokemonTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pokemonId,
      referencedTable: $db.pokemonTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonTableTableAnnotationComposer(
            $db: $db,
            $table: $db.pokemonTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TypesTableTableAnnotationComposer get typeId {
    final $$TypesTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.typeId,
      referencedTable: $db.typesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TypesTableTableAnnotationComposer(
            $db: $db,
            $table: $db.typesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PokemonTypesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PokemonTypesTableTable,
          PokemonTypeRow,
          $$PokemonTypesTableTableFilterComposer,
          $$PokemonTypesTableTableOrderingComposer,
          $$PokemonTypesTableTableAnnotationComposer,
          $$PokemonTypesTableTableCreateCompanionBuilder,
          $$PokemonTypesTableTableUpdateCompanionBuilder,
          (PokemonTypeRow, $$PokemonTypesTableTableReferences),
          PokemonTypeRow,
          PrefetchHooks Function({bool pokemonId, bool typeId})
        > {
  $$PokemonTypesTableTableTableManager(
    _$AppDatabase db,
    $PokemonTypesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PokemonTypesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PokemonTypesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PokemonTypesTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> pokemonId = const Value.absent(),
                Value<int> typeId = const Value.absent(),
                Value<int> slot = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PokemonTypesTableCompanion(
                pokemonId: pokemonId,
                typeId: typeId,
                slot: slot,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int pokemonId,
                required int typeId,
                required int slot,
                Value<int> rowid = const Value.absent(),
              }) => PokemonTypesTableCompanion.insert(
                pokemonId: pokemonId,
                typeId: typeId,
                slot: slot,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PokemonTypesTableTable, PokemonTypeRow>(table),
                  $$PokemonTypesTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({pokemonId = false, typeId = false}) {
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
                    if (pokemonId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.pokemonId,
                        referencedTable: $$PokemonTypesTableTableReferences
                            ._pokemonIdTable(db),
                        referencedColumn: $$PokemonTypesTableTableReferences
                            ._pokemonIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (typeId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.typeId,
                        referencedTable: $$PokemonTypesTableTableReferences
                            ._typeIdTable(db),
                        referencedColumn: $$PokemonTypesTableTableReferences
                            ._typeIdTable(db)
                            .id,
                      ) as T;
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

typedef $$PokemonTypesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PokemonTypesTableTable,
      PokemonTypeRow,
      $$PokemonTypesTableTableFilterComposer,
      $$PokemonTypesTableTableOrderingComposer,
      $$PokemonTypesTableTableAnnotationComposer,
      $$PokemonTypesTableTableCreateCompanionBuilder,
      $$PokemonTypesTableTableUpdateCompanionBuilder,
      (PokemonTypeRow, $$PokemonTypesTableTableReferences),
      PokemonTypeRow,
      PrefetchHooks Function({bool pokemonId, bool typeId})
    >;
typedef $$TypeEfficaciesTableTableCreateCompanionBuilder =
    TypeEfficaciesTableCompanion Function({
      required int defendingTypeId,
      required int attackingTypeId,
      required int damageFactor,
      Value<int> rowid,
    });
typedef $$TypeEfficaciesTableTableUpdateCompanionBuilder =
    TypeEfficaciesTableCompanion Function({
      Value<int> defendingTypeId,
      Value<int> attackingTypeId,
      Value<int> damageFactor,
      Value<int> rowid,
    });

final class $$TypeEfficaciesTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $TypeEfficaciesTableTable,
          TypeEfficacyRow
        > {
  $$TypeEfficaciesTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $TypesTableTable _defendingTypeIdTable(_$AppDatabase db) => db
      .typesTable
      .createAlias('type_efficacies__defending_type_id__types__id');

  $$TypesTableTableProcessedTableManager get defendingTypeId {
    final $_column = $_itemColumn<int>('defending_type_id')!;

    final manager = $$TypesTableTableTableManager(
      $_db,
      $_db.typesTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_defendingTypeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TypesTableTable _attackingTypeIdTable(_$AppDatabase db) => db
      .typesTable
      .createAlias('type_efficacies__attacking_type_id__types__id');

  $$TypesTableTableProcessedTableManager get attackingTypeId {
    final $_column = $_itemColumn<int>('attacking_type_id')!;

    final manager = $$TypesTableTableTableManager(
      $_db,
      $_db.typesTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_attackingTypeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TypeEfficaciesTableTableFilterComposer
    extends Composer<_$AppDatabase, $TypeEfficaciesTableTable> {
  $$TypeEfficaciesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get damageFactor => $composableBuilder(
    column: $table.damageFactor,
    builder: (column) => ColumnFilters(column),
  );

  $$TypesTableTableFilterComposer get defendingTypeId {
    final $$TypesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.defendingTypeId,
      referencedTable: $db.typesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TypesTableTableFilterComposer(
            $db: $db,
            $table: $db.typesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TypesTableTableFilterComposer get attackingTypeId {
    final $$TypesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.attackingTypeId,
      referencedTable: $db.typesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TypesTableTableFilterComposer(
            $db: $db,
            $table: $db.typesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TypeEfficaciesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $TypeEfficaciesTableTable> {
  $$TypeEfficaciesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get damageFactor => $composableBuilder(
    column: $table.damageFactor,
    builder: (column) => ColumnOrderings(column),
  );

  $$TypesTableTableOrderingComposer get defendingTypeId {
    final $$TypesTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.defendingTypeId,
      referencedTable: $db.typesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TypesTableTableOrderingComposer(
            $db: $db,
            $table: $db.typesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TypesTableTableOrderingComposer get attackingTypeId {
    final $$TypesTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.attackingTypeId,
      referencedTable: $db.typesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TypesTableTableOrderingComposer(
            $db: $db,
            $table: $db.typesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TypeEfficaciesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $TypeEfficaciesTableTable> {
  $$TypeEfficaciesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get damageFactor => $composableBuilder(
    column: $table.damageFactor,
    builder: (column) => column,
  );

  $$TypesTableTableAnnotationComposer get defendingTypeId {
    final $$TypesTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.defendingTypeId,
      referencedTable: $db.typesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TypesTableTableAnnotationComposer(
            $db: $db,
            $table: $db.typesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TypesTableTableAnnotationComposer get attackingTypeId {
    final $$TypesTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.attackingTypeId,
      referencedTable: $db.typesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TypesTableTableAnnotationComposer(
            $db: $db,
            $table: $db.typesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TypeEfficaciesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TypeEfficaciesTableTable,
          TypeEfficacyRow,
          $$TypeEfficaciesTableTableFilterComposer,
          $$TypeEfficaciesTableTableOrderingComposer,
          $$TypeEfficaciesTableTableAnnotationComposer,
          $$TypeEfficaciesTableTableCreateCompanionBuilder,
          $$TypeEfficaciesTableTableUpdateCompanionBuilder,
          (TypeEfficacyRow, $$TypeEfficaciesTableTableReferences),
          TypeEfficacyRow,
          PrefetchHooks Function({bool defendingTypeId, bool attackingTypeId})
        > {
  $$TypeEfficaciesTableTableTableManager(
    _$AppDatabase db,
    $TypeEfficaciesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TypeEfficaciesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TypeEfficaciesTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$TypeEfficaciesTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> defendingTypeId = const Value.absent(),
                Value<int> attackingTypeId = const Value.absent(),
                Value<int> damageFactor = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TypeEfficaciesTableCompanion(
                defendingTypeId: defendingTypeId,
                attackingTypeId: attackingTypeId,
                damageFactor: damageFactor,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int defendingTypeId,
                required int attackingTypeId,
                required int damageFactor,
                Value<int> rowid = const Value.absent(),
              }) => TypeEfficaciesTableCompanion.insert(
                defendingTypeId: defendingTypeId,
                attackingTypeId: attackingTypeId,
                damageFactor: damageFactor,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TypeEfficaciesTableTable, TypeEfficacyRow>(
                    table,
                  ),
                  $$TypeEfficaciesTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({defendingTypeId = false, attackingTypeId = false}) {
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
                        if (defendingTypeId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.defendingTypeId,
                            referencedTable:
                                $$TypeEfficaciesTableTableReferences
                                    ._defendingTypeIdTable(db),
                            referencedColumn:
                                $$TypeEfficaciesTableTableReferences
                                    ._defendingTypeIdTable(db)
                                    .id,
                          ) as T;
                        }
                        if (attackingTypeId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.attackingTypeId,
                            referencedTable:
                                $$TypeEfficaciesTableTableReferences
                                    ._attackingTypeIdTable(db),
                            referencedColumn:
                                $$TypeEfficaciesTableTableReferences
                                    ._attackingTypeIdTable(db)
                                    .id,
                          ) as T;
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

typedef $$TypeEfficaciesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TypeEfficaciesTableTable,
      TypeEfficacyRow,
      $$TypeEfficaciesTableTableFilterComposer,
      $$TypeEfficaciesTableTableOrderingComposer,
      $$TypeEfficaciesTableTableAnnotationComposer,
      $$TypeEfficaciesTableTableCreateCompanionBuilder,
      $$TypeEfficaciesTableTableUpdateCompanionBuilder,
      (TypeEfficacyRow, $$TypeEfficaciesTableTableReferences),
      TypeEfficacyRow,
      PrefetchHooks Function({bool defendingTypeId, bool attackingTypeId})
    >;
typedef $$StatsTableTableCreateCompanionBuilder = StatsTableCompanion Function({
  Value<int> id,
  required String name,
});
typedef $$StatsTableTableUpdateCompanionBuilder = StatsTableCompanion Function({
  Value<int> id,
  Value<String> name,
});

final class $$StatsTableTableReferences
    extends BaseReferences<_$AppDatabase, $StatsTableTable, StatRow> {
  $$StatsTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$PokemonStatsTableTable, List<PokemonStatRow>>
  _pokemonStatsTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.pokemonStatsTable,
        aliasName: 'stats__id__pokemon_stats__stat_id',
      );

  $$PokemonStatsTableTableProcessedTableManager get pokemonStatsTableRefs {
    final manager = $$PokemonStatsTableTableTableManager(
      $_db,
      $_db.pokemonStatsTable,
    ).filter((f) => f.statId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _pokemonStatsTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$StatsTableTableFilterComposer
    extends Composer<_$AppDatabase, $StatsTableTable> {
  $$StatsTableTableFilterComposer({
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

  Expression<bool> pokemonStatsTableRefs(
    Expression<bool> Function($$PokemonStatsTableTableFilterComposer f) f,
  ) {
    final $$PokemonStatsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pokemonStatsTable,
      getReferencedColumn: (t) => t.statId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonStatsTableTableFilterComposer(
            $db: $db,
            $table: $db.pokemonStatsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$StatsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $StatsTableTable> {
  $$StatsTableTableOrderingComposer({
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
}

class $$StatsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $StatsTableTable> {
  $$StatsTableTableAnnotationComposer({
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

  Expression<T> pokemonStatsTableRefs<T extends Object>(
    Expression<T> Function($$PokemonStatsTableTableAnnotationComposer a) f,
  ) {
    final $$PokemonStatsTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.pokemonStatsTable,
          getReferencedColumn: (t) => t.statId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PokemonStatsTableTableAnnotationComposer(
                $db: $db,
                $table: $db.pokemonStatsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$StatsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StatsTableTable,
          StatRow,
          $$StatsTableTableFilterComposer,
          $$StatsTableTableOrderingComposer,
          $$StatsTableTableAnnotationComposer,
          $$StatsTableTableCreateCompanionBuilder,
          $$StatsTableTableUpdateCompanionBuilder,
          (StatRow, $$StatsTableTableReferences),
          StatRow,
          PrefetchHooks Function({bool pokemonStatsTableRefs})
        > {
  $$StatsTableTableTableManager(_$AppDatabase db, $StatsTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StatsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StatsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StatsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
          }) => StatsTableCompanion(id: id, name: name),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
          }) => StatsTableCompanion.insert(id: id, name: name),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$StatsTableTable, StatRow>(table),
                  $$StatsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({pokemonStatsTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (pokemonStatsTableRefs) db.pokemonStatsTable,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (pokemonStatsTableRefs)
                    await $_getPrefetchedDataByColumns<
                      StatRow,
                      $StatsTableTable,
                      PokemonStatRow,
                      $PokemonStatsTableTable
                    >(
                      currentTable: table,
                      referencedTable: $$StatsTableTableReferences
                          ._pokemonStatsTableRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$StatsTableTableReferences(
                            db,
                            table,
                            p0,
                          ).pokemonStatsTableRefs,
                      currentColumn: 'id',
                      referencedColumn: 'stat_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$StatsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StatsTableTable,
      StatRow,
      $$StatsTableTableFilterComposer,
      $$StatsTableTableOrderingComposer,
      $$StatsTableTableAnnotationComposer,
      $$StatsTableTableCreateCompanionBuilder,
      $$StatsTableTableUpdateCompanionBuilder,
      (StatRow, $$StatsTableTableReferences),
      StatRow,
      PrefetchHooks Function({bool pokemonStatsTableRefs})
    >;
typedef $$PokemonStatsTableTableCreateCompanionBuilder =
    PokemonStatsTableCompanion Function({
      required int pokemonId,
      required int statId,
      required int baseStat,
      required int effort,
      Value<int> rowid,
    });
typedef $$PokemonStatsTableTableUpdateCompanionBuilder =
    PokemonStatsTableCompanion Function({
      Value<int> pokemonId,
      Value<int> statId,
      Value<int> baseStat,
      Value<int> effort,
      Value<int> rowid,
    });

final class $$PokemonStatsTableTableReferences
    extends
        BaseReferences<_$AppDatabase, $PokemonStatsTableTable, PokemonStatRow> {
  $$PokemonStatsTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $PokemonTableTable _pokemonIdTable(_$AppDatabase db) =>
      db.pokemonTable.createAlias('pokemon_stats__pokemon_id__pokemon__id');

  $$PokemonTableTableProcessedTableManager get pokemonId {
    final $_column = $_itemColumn<int>('pokemon_id')!;

    final manager = $$PokemonTableTableTableManager(
      $_db,
      $_db.pokemonTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_pokemonIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $StatsTableTable _statIdTable(_$AppDatabase db) =>
      db.statsTable.createAlias('pokemon_stats__stat_id__stats__id');

  $$StatsTableTableProcessedTableManager get statId {
    final $_column = $_itemColumn<int>('stat_id')!;

    final manager = $$StatsTableTableTableManager(
      $_db,
      $_db.statsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_statIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PokemonStatsTableTableFilterComposer
    extends Composer<_$AppDatabase, $PokemonStatsTableTable> {
  $$PokemonStatsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get baseStat => $composableBuilder(
    column: $table.baseStat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get effort => $composableBuilder(
    column: $table.effort,
    builder: (column) => ColumnFilters(column),
  );

  $$PokemonTableTableFilterComposer get pokemonId {
    final $$PokemonTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pokemonId,
      referencedTable: $db.pokemonTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonTableTableFilterComposer(
            $db: $db,
            $table: $db.pokemonTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$StatsTableTableFilterComposer get statId {
    final $$StatsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.statId,
      referencedTable: $db.statsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StatsTableTableFilterComposer(
            $db: $db,
            $table: $db.statsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PokemonStatsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PokemonStatsTableTable> {
  $$PokemonStatsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get baseStat => $composableBuilder(
    column: $table.baseStat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get effort => $composableBuilder(
    column: $table.effort,
    builder: (column) => ColumnOrderings(column),
  );

  $$PokemonTableTableOrderingComposer get pokemonId {
    final $$PokemonTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pokemonId,
      referencedTable: $db.pokemonTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonTableTableOrderingComposer(
            $db: $db,
            $table: $db.pokemonTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$StatsTableTableOrderingComposer get statId {
    final $$StatsTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.statId,
      referencedTable: $db.statsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StatsTableTableOrderingComposer(
            $db: $db,
            $table: $db.statsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PokemonStatsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PokemonStatsTableTable> {
  $$PokemonStatsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get baseStat =>
      $composableBuilder(column: $table.baseStat, builder: (column) => column);

  GeneratedColumn<int> get effort =>
      $composableBuilder(column: $table.effort, builder: (column) => column);

  $$PokemonTableTableAnnotationComposer get pokemonId {
    final $$PokemonTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pokemonId,
      referencedTable: $db.pokemonTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonTableTableAnnotationComposer(
            $db: $db,
            $table: $db.pokemonTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$StatsTableTableAnnotationComposer get statId {
    final $$StatsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.statId,
      referencedTable: $db.statsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StatsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.statsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PokemonStatsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PokemonStatsTableTable,
          PokemonStatRow,
          $$PokemonStatsTableTableFilterComposer,
          $$PokemonStatsTableTableOrderingComposer,
          $$PokemonStatsTableTableAnnotationComposer,
          $$PokemonStatsTableTableCreateCompanionBuilder,
          $$PokemonStatsTableTableUpdateCompanionBuilder,
          (PokemonStatRow, $$PokemonStatsTableTableReferences),
          PokemonStatRow,
          PrefetchHooks Function({bool pokemonId, bool statId})
        > {
  $$PokemonStatsTableTableTableManager(
    _$AppDatabase db,
    $PokemonStatsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PokemonStatsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PokemonStatsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PokemonStatsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> pokemonId = const Value.absent(),
                Value<int> statId = const Value.absent(),
                Value<int> baseStat = const Value.absent(),
                Value<int> effort = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PokemonStatsTableCompanion(
                pokemonId: pokemonId,
                statId: statId,
                baseStat: baseStat,
                effort: effort,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int pokemonId,
                required int statId,
                required int baseStat,
                required int effort,
                Value<int> rowid = const Value.absent(),
              }) => PokemonStatsTableCompanion.insert(
                pokemonId: pokemonId,
                statId: statId,
                baseStat: baseStat,
                effort: effort,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PokemonStatsTableTable, PokemonStatRow>(table),
                  $$PokemonStatsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({pokemonId = false, statId = false}) {
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
                    if (pokemonId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.pokemonId,
                        referencedTable: $$PokemonStatsTableTableReferences
                            ._pokemonIdTable(db),
                        referencedColumn: $$PokemonStatsTableTableReferences
                            ._pokemonIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (statId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.statId,
                        referencedTable: $$PokemonStatsTableTableReferences
                            ._statIdTable(db),
                        referencedColumn: $$PokemonStatsTableTableReferences
                            ._statIdTable(db)
                            .id,
                      ) as T;
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

typedef $$PokemonStatsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PokemonStatsTableTable,
      PokemonStatRow,
      $$PokemonStatsTableTableFilterComposer,
      $$PokemonStatsTableTableOrderingComposer,
      $$PokemonStatsTableTableAnnotationComposer,
      $$PokemonStatsTableTableCreateCompanionBuilder,
      $$PokemonStatsTableTableUpdateCompanionBuilder,
      (PokemonStatRow, $$PokemonStatsTableTableReferences),
      PokemonStatRow,
      PrefetchHooks Function({bool pokemonId, bool statId})
    >;
typedef $$EggGroupsTableTableCreateCompanionBuilder =
    EggGroupsTableCompanion Function({Value<int> id, required String name});
typedef $$EggGroupsTableTableUpdateCompanionBuilder =
    EggGroupsTableCompanion Function({Value<int> id, Value<String> name});

final class $$EggGroupsTableTableReferences
    extends BaseReferences<_$AppDatabase, $EggGroupsTableTable, EggGroupRow> {
  $$EggGroupsTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<
    $PokemonEggGroupsTableTable,
    List<PokemonEggGroupRow>
  >
  _pokemonEggGroupsTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.pokemonEggGroupsTable,
        aliasName: 'egg_groups__id__pokemon_egg_groups__egg_group_id',
      );

  $$PokemonEggGroupsTableTableProcessedTableManager
  get pokemonEggGroupsTableRefs {
    final manager = $$PokemonEggGroupsTableTableTableManager(
      $_db,
      $_db.pokemonEggGroupsTable,
    ).filter((f) => f.eggGroupId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _pokemonEggGroupsTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$EggGroupsTableTableFilterComposer
    extends Composer<_$AppDatabase, $EggGroupsTableTable> {
  $$EggGroupsTableTableFilterComposer({
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

  Expression<bool> pokemonEggGroupsTableRefs(
    Expression<bool> Function($$PokemonEggGroupsTableTableFilterComposer f) f,
  ) {
    final $$PokemonEggGroupsTableTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.pokemonEggGroupsTable,
          getReferencedColumn: (t) => t.eggGroupId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PokemonEggGroupsTableTableFilterComposer(
                $db: $db,
                $table: $db.pokemonEggGroupsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$EggGroupsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $EggGroupsTableTable> {
  $$EggGroupsTableTableOrderingComposer({
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
}

class $$EggGroupsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $EggGroupsTableTable> {
  $$EggGroupsTableTableAnnotationComposer({
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

  Expression<T> pokemonEggGroupsTableRefs<T extends Object>(
    Expression<T> Function($$PokemonEggGroupsTableTableAnnotationComposer a) f,
  ) {
    final $$PokemonEggGroupsTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.pokemonEggGroupsTable,
          getReferencedColumn: (t) => t.eggGroupId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PokemonEggGroupsTableTableAnnotationComposer(
                $db: $db,
                $table: $db.pokemonEggGroupsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$EggGroupsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EggGroupsTableTable,
          EggGroupRow,
          $$EggGroupsTableTableFilterComposer,
          $$EggGroupsTableTableOrderingComposer,
          $$EggGroupsTableTableAnnotationComposer,
          $$EggGroupsTableTableCreateCompanionBuilder,
          $$EggGroupsTableTableUpdateCompanionBuilder,
          (EggGroupRow, $$EggGroupsTableTableReferences),
          EggGroupRow,
          PrefetchHooks Function({bool pokemonEggGroupsTableRefs})
        > {
  $$EggGroupsTableTableTableManager(
    _$AppDatabase db,
    $EggGroupsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EggGroupsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EggGroupsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EggGroupsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
          }) => EggGroupsTableCompanion(id: id, name: name),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
          }) => EggGroupsTableCompanion.insert(id: id, name: name),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$EggGroupsTableTable, EggGroupRow>(table),
                  $$EggGroupsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({pokemonEggGroupsTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (pokemonEggGroupsTableRefs) db.pokemonEggGroupsTable,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (pokemonEggGroupsTableRefs)
                    await $_getPrefetchedDataByColumns<
                      EggGroupRow,
                      $EggGroupsTableTable,
                      PokemonEggGroupRow,
                      $PokemonEggGroupsTableTable
                    >(
                      currentTable: table,
                      referencedTable: $$EggGroupsTableTableReferences
                          ._pokemonEggGroupsTableRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$EggGroupsTableTableReferences(
                            db,
                            table,
                            p0,
                          ).pokemonEggGroupsTableRefs,
                      currentColumn: 'id',
                      referencedColumn: 'egg_group_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$EggGroupsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EggGroupsTableTable,
      EggGroupRow,
      $$EggGroupsTableTableFilterComposer,
      $$EggGroupsTableTableOrderingComposer,
      $$EggGroupsTableTableAnnotationComposer,
      $$EggGroupsTableTableCreateCompanionBuilder,
      $$EggGroupsTableTableUpdateCompanionBuilder,
      (EggGroupRow, $$EggGroupsTableTableReferences),
      EggGroupRow,
      PrefetchHooks Function({bool pokemonEggGroupsTableRefs})
    >;
typedef $$PokemonEggGroupsTableTableCreateCompanionBuilder =
    PokemonEggGroupsTableCompanion Function({
      required int pokemonId,
      required int eggGroupId,
      Value<int> rowid,
    });
typedef $$PokemonEggGroupsTableTableUpdateCompanionBuilder =
    PokemonEggGroupsTableCompanion Function({
      Value<int> pokemonId,
      Value<int> eggGroupId,
      Value<int> rowid,
    });

final class $$PokemonEggGroupsTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $PokemonEggGroupsTableTable,
          PokemonEggGroupRow
        > {
  $$PokemonEggGroupsTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $PokemonTableTable _pokemonIdTable(_$AppDatabase db) => db.pokemonTable
      .createAlias('pokemon_egg_groups__pokemon_id__pokemon__id');

  $$PokemonTableTableProcessedTableManager get pokemonId {
    final $_column = $_itemColumn<int>('pokemon_id')!;

    final manager = $$PokemonTableTableTableManager(
      $_db,
      $_db.pokemonTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_pokemonIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $EggGroupsTableTable _eggGroupIdTable(_$AppDatabase db) => db
      .eggGroupsTable
      .createAlias('pokemon_egg_groups__egg_group_id__egg_groups__id');

  $$EggGroupsTableTableProcessedTableManager get eggGroupId {
    final $_column = $_itemColumn<int>('egg_group_id')!;

    final manager = $$EggGroupsTableTableTableManager(
      $_db,
      $_db.eggGroupsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_eggGroupIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PokemonEggGroupsTableTableFilterComposer
    extends Composer<_$AppDatabase, $PokemonEggGroupsTableTable> {
  $$PokemonEggGroupsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$PokemonTableTableFilterComposer get pokemonId {
    final $$PokemonTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pokemonId,
      referencedTable: $db.pokemonTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonTableTableFilterComposer(
            $db: $db,
            $table: $db.pokemonTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$EggGroupsTableTableFilterComposer get eggGroupId {
    final $$EggGroupsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eggGroupId,
      referencedTable: $db.eggGroupsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EggGroupsTableTableFilterComposer(
            $db: $db,
            $table: $db.eggGroupsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PokemonEggGroupsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PokemonEggGroupsTableTable> {
  $$PokemonEggGroupsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$PokemonTableTableOrderingComposer get pokemonId {
    final $$PokemonTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pokemonId,
      referencedTable: $db.pokemonTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonTableTableOrderingComposer(
            $db: $db,
            $table: $db.pokemonTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$EggGroupsTableTableOrderingComposer get eggGroupId {
    final $$EggGroupsTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eggGroupId,
      referencedTable: $db.eggGroupsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EggGroupsTableTableOrderingComposer(
            $db: $db,
            $table: $db.eggGroupsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PokemonEggGroupsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PokemonEggGroupsTableTable> {
  $$PokemonEggGroupsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$PokemonTableTableAnnotationComposer get pokemonId {
    final $$PokemonTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pokemonId,
      referencedTable: $db.pokemonTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonTableTableAnnotationComposer(
            $db: $db,
            $table: $db.pokemonTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$EggGroupsTableTableAnnotationComposer get eggGroupId {
    final $$EggGroupsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eggGroupId,
      referencedTable: $db.eggGroupsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EggGroupsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.eggGroupsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PokemonEggGroupsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PokemonEggGroupsTableTable,
          PokemonEggGroupRow,
          $$PokemonEggGroupsTableTableFilterComposer,
          $$PokemonEggGroupsTableTableOrderingComposer,
          $$PokemonEggGroupsTableTableAnnotationComposer,
          $$PokemonEggGroupsTableTableCreateCompanionBuilder,
          $$PokemonEggGroupsTableTableUpdateCompanionBuilder,
          (PokemonEggGroupRow, $$PokemonEggGroupsTableTableReferences),
          PokemonEggGroupRow,
          PrefetchHooks Function({bool pokemonId, bool eggGroupId})
        > {
  $$PokemonEggGroupsTableTableTableManager(
    _$AppDatabase db,
    $PokemonEggGroupsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PokemonEggGroupsTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$PokemonEggGroupsTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$PokemonEggGroupsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> pokemonId = const Value.absent(),
                Value<int> eggGroupId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PokemonEggGroupsTableCompanion(
                pokemonId: pokemonId,
                eggGroupId: eggGroupId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int pokemonId,
                required int eggGroupId,
                Value<int> rowid = const Value.absent(),
              }) => PokemonEggGroupsTableCompanion.insert(
                pokemonId: pokemonId,
                eggGroupId: eggGroupId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PokemonEggGroupsTableTable, PokemonEggGroupRow>(
                    table,
                  ),
                  $$PokemonEggGroupsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({pokemonId = false, eggGroupId = false}) {
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
                    if (pokemonId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.pokemonId,
                        referencedTable: $$PokemonEggGroupsTableTableReferences
                            ._pokemonIdTable(db),
                        referencedColumn: $$PokemonEggGroupsTableTableReferences
                            ._pokemonIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (eggGroupId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.eggGroupId,
                        referencedTable: $$PokemonEggGroupsTableTableReferences
                            ._eggGroupIdTable(db),
                        referencedColumn: $$PokemonEggGroupsTableTableReferences
                            ._eggGroupIdTable(db)
                            .id,
                      ) as T;
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

typedef $$PokemonEggGroupsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PokemonEggGroupsTableTable,
      PokemonEggGroupRow,
      $$PokemonEggGroupsTableTableFilterComposer,
      $$PokemonEggGroupsTableTableOrderingComposer,
      $$PokemonEggGroupsTableTableAnnotationComposer,
      $$PokemonEggGroupsTableTableCreateCompanionBuilder,
      $$PokemonEggGroupsTableTableUpdateCompanionBuilder,
      (PokemonEggGroupRow, $$PokemonEggGroupsTableTableReferences),
      PokemonEggGroupRow,
      PrefetchHooks Function({bool pokemonId, bool eggGroupId})
    >;
typedef $$AbilitiesTableTableCreateCompanionBuilder =
    AbilitiesTableCompanion Function({
      Value<int> id,
      required String name,
      Value<String?> nameEs,
      Value<String?> nameEn,
      Value<String?> effectEs,
      Value<String?> effectEn,
    });
typedef $$AbilitiesTableTableUpdateCompanionBuilder =
    AbilitiesTableCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String?> nameEs,
      Value<String?> nameEn,
      Value<String?> effectEs,
      Value<String?> effectEn,
    });

final class $$AbilitiesTableTableReferences
    extends BaseReferences<_$AppDatabase, $AbilitiesTableTable, AbilityRow> {
  $$AbilitiesTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<
    $PokemonAbilitiesTableTable,
    List<PokemonAbilityRow>
  >
  _pokemonAbilitiesTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.pokemonAbilitiesTable,
        aliasName: 'abilities__id__pokemon_abilities__ability_id',
      );

  $$PokemonAbilitiesTableTableProcessedTableManager
  get pokemonAbilitiesTableRefs {
    final manager = $$PokemonAbilitiesTableTableTableManager(
      $_db,
      $_db.pokemonAbilitiesTable,
    ).filter((f) => f.abilityId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _pokemonAbilitiesTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$AbilitiesTableTableFilterComposer
    extends Composer<_$AppDatabase, $AbilitiesTableTable> {
  $$AbilitiesTableTableFilterComposer({
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

  ColumnFilters<String> get nameEs => $composableBuilder(
    column: $table.nameEs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get effectEs => $composableBuilder(
    column: $table.effectEs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get effectEn => $composableBuilder(
    column: $table.effectEn,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> pokemonAbilitiesTableRefs(
    Expression<bool> Function($$PokemonAbilitiesTableTableFilterComposer f) f,
  ) {
    final $$PokemonAbilitiesTableTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.pokemonAbilitiesTable,
          getReferencedColumn: (t) => t.abilityId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PokemonAbilitiesTableTableFilterComposer(
                $db: $db,
                $table: $db.pokemonAbilitiesTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$AbilitiesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $AbilitiesTableTable> {
  $$AbilitiesTableTableOrderingComposer({
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

  ColumnOrderings<String> get nameEs => $composableBuilder(
    column: $table.nameEs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get effectEs => $composableBuilder(
    column: $table.effectEs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get effectEn => $composableBuilder(
    column: $table.effectEn,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AbilitiesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $AbilitiesTableTable> {
  $$AbilitiesTableTableAnnotationComposer({
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

  GeneratedColumn<String> get nameEs =>
      $composableBuilder(column: $table.nameEs, builder: (column) => column);

  GeneratedColumn<String> get nameEn =>
      $composableBuilder(column: $table.nameEn, builder: (column) => column);

  GeneratedColumn<String> get effectEs =>
      $composableBuilder(column: $table.effectEs, builder: (column) => column);

  GeneratedColumn<String> get effectEn =>
      $composableBuilder(column: $table.effectEn, builder: (column) => column);

  Expression<T> pokemonAbilitiesTableRefs<T extends Object>(
    Expression<T> Function($$PokemonAbilitiesTableTableAnnotationComposer a) f,
  ) {
    final $$PokemonAbilitiesTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.pokemonAbilitiesTable,
          getReferencedColumn: (t) => t.abilityId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PokemonAbilitiesTableTableAnnotationComposer(
                $db: $db,
                $table: $db.pokemonAbilitiesTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$AbilitiesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AbilitiesTableTable,
          AbilityRow,
          $$AbilitiesTableTableFilterComposer,
          $$AbilitiesTableTableOrderingComposer,
          $$AbilitiesTableTableAnnotationComposer,
          $$AbilitiesTableTableCreateCompanionBuilder,
          $$AbilitiesTableTableUpdateCompanionBuilder,
          (AbilityRow, $$AbilitiesTableTableReferences),
          AbilityRow,
          PrefetchHooks Function({bool pokemonAbilitiesTableRefs})
        > {
  $$AbilitiesTableTableTableManager(
    _$AppDatabase db,
    $AbilitiesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AbilitiesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AbilitiesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AbilitiesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> nameEs = const Value.absent(),
                Value<String?> nameEn = const Value.absent(),
                Value<String?> effectEs = const Value.absent(),
                Value<String?> effectEn = const Value.absent(),
              }) => AbilitiesTableCompanion(
                id: id,
                name: name,
                nameEs: nameEs,
                nameEn: nameEn,
                effectEs: effectEs,
                effectEn: effectEn,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> nameEs = const Value.absent(),
                Value<String?> nameEn = const Value.absent(),
                Value<String?> effectEs = const Value.absent(),
                Value<String?> effectEn = const Value.absent(),
              }) => AbilitiesTableCompanion.insert(
                id: id,
                name: name,
                nameEs: nameEs,
                nameEn: nameEn,
                effectEs: effectEs,
                effectEn: effectEn,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AbilitiesTableTable, AbilityRow>(table),
                  $$AbilitiesTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({pokemonAbilitiesTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (pokemonAbilitiesTableRefs) db.pokemonAbilitiesTable,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (pokemonAbilitiesTableRefs)
                    await $_getPrefetchedDataByColumns<
                      AbilityRow,
                      $AbilitiesTableTable,
                      PokemonAbilityRow,
                      $PokemonAbilitiesTableTable
                    >(
                      currentTable: table,
                      referencedTable: $$AbilitiesTableTableReferences
                          ._pokemonAbilitiesTableRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$AbilitiesTableTableReferences(
                            db,
                            table,
                            p0,
                          ).pokemonAbilitiesTableRefs,
                      currentColumn: 'id',
                      referencedColumn: 'ability_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$AbilitiesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AbilitiesTableTable,
      AbilityRow,
      $$AbilitiesTableTableFilterComposer,
      $$AbilitiesTableTableOrderingComposer,
      $$AbilitiesTableTableAnnotationComposer,
      $$AbilitiesTableTableCreateCompanionBuilder,
      $$AbilitiesTableTableUpdateCompanionBuilder,
      (AbilityRow, $$AbilitiesTableTableReferences),
      AbilityRow,
      PrefetchHooks Function({bool pokemonAbilitiesTableRefs})
    >;
typedef $$PokemonAbilitiesTableTableCreateCompanionBuilder =
    PokemonAbilitiesTableCompanion Function({
      required int pokemonId,
      required int abilityId,
      required int slot,
      Value<bool> isHidden,
      Value<int> rowid,
    });
typedef $$PokemonAbilitiesTableTableUpdateCompanionBuilder =
    PokemonAbilitiesTableCompanion Function({
      Value<int> pokemonId,
      Value<int> abilityId,
      Value<int> slot,
      Value<bool> isHidden,
      Value<int> rowid,
    });

final class $$PokemonAbilitiesTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $PokemonAbilitiesTableTable,
          PokemonAbilityRow
        > {
  $$PokemonAbilitiesTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $PokemonTableTable _pokemonIdTable(_$AppDatabase db) =>
      db.pokemonTable.createAlias('pokemon_abilities__pokemon_id__pokemon__id');

  $$PokemonTableTableProcessedTableManager get pokemonId {
    final $_column = $_itemColumn<int>('pokemon_id')!;

    final manager = $$PokemonTableTableTableManager(
      $_db,
      $_db.pokemonTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_pokemonIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $AbilitiesTableTable _abilityIdTable(_$AppDatabase db) => db
      .abilitiesTable
      .createAlias('pokemon_abilities__ability_id__abilities__id');

  $$AbilitiesTableTableProcessedTableManager get abilityId {
    final $_column = $_itemColumn<int>('ability_id')!;

    final manager = $$AbilitiesTableTableTableManager(
      $_db,
      $_db.abilitiesTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_abilityIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PokemonAbilitiesTableTableFilterComposer
    extends Composer<_$AppDatabase, $PokemonAbilitiesTableTable> {
  $$PokemonAbilitiesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get slot => $composableBuilder(
    column: $table.slot,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isHidden => $composableBuilder(
    column: $table.isHidden,
    builder: (column) => ColumnFilters(column),
  );

  $$PokemonTableTableFilterComposer get pokemonId {
    final $$PokemonTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pokemonId,
      referencedTable: $db.pokemonTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonTableTableFilterComposer(
            $db: $db,
            $table: $db.pokemonTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AbilitiesTableTableFilterComposer get abilityId {
    final $$AbilitiesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.abilityId,
      referencedTable: $db.abilitiesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AbilitiesTableTableFilterComposer(
            $db: $db,
            $table: $db.abilitiesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PokemonAbilitiesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PokemonAbilitiesTableTable> {
  $$PokemonAbilitiesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get slot => $composableBuilder(
    column: $table.slot,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isHidden => $composableBuilder(
    column: $table.isHidden,
    builder: (column) => ColumnOrderings(column),
  );

  $$PokemonTableTableOrderingComposer get pokemonId {
    final $$PokemonTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pokemonId,
      referencedTable: $db.pokemonTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonTableTableOrderingComposer(
            $db: $db,
            $table: $db.pokemonTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AbilitiesTableTableOrderingComposer get abilityId {
    final $$AbilitiesTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.abilityId,
      referencedTable: $db.abilitiesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AbilitiesTableTableOrderingComposer(
            $db: $db,
            $table: $db.abilitiesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PokemonAbilitiesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PokemonAbilitiesTableTable> {
  $$PokemonAbilitiesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get slot =>
      $composableBuilder(column: $table.slot, builder: (column) => column);

  GeneratedColumn<bool> get isHidden =>
      $composableBuilder(column: $table.isHidden, builder: (column) => column);

  $$PokemonTableTableAnnotationComposer get pokemonId {
    final $$PokemonTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pokemonId,
      referencedTable: $db.pokemonTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonTableTableAnnotationComposer(
            $db: $db,
            $table: $db.pokemonTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AbilitiesTableTableAnnotationComposer get abilityId {
    final $$AbilitiesTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.abilityId,
      referencedTable: $db.abilitiesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AbilitiesTableTableAnnotationComposer(
            $db: $db,
            $table: $db.abilitiesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PokemonAbilitiesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PokemonAbilitiesTableTable,
          PokemonAbilityRow,
          $$PokemonAbilitiesTableTableFilterComposer,
          $$PokemonAbilitiesTableTableOrderingComposer,
          $$PokemonAbilitiesTableTableAnnotationComposer,
          $$PokemonAbilitiesTableTableCreateCompanionBuilder,
          $$PokemonAbilitiesTableTableUpdateCompanionBuilder,
          (PokemonAbilityRow, $$PokemonAbilitiesTableTableReferences),
          PokemonAbilityRow,
          PrefetchHooks Function({bool pokemonId, bool abilityId})
        > {
  $$PokemonAbilitiesTableTableTableManager(
    _$AppDatabase db,
    $PokemonAbilitiesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PokemonAbilitiesTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$PokemonAbilitiesTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$PokemonAbilitiesTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> pokemonId = const Value.absent(),
                Value<int> abilityId = const Value.absent(),
                Value<int> slot = const Value.absent(),
                Value<bool> isHidden = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PokemonAbilitiesTableCompanion(
                pokemonId: pokemonId,
                abilityId: abilityId,
                slot: slot,
                isHidden: isHidden,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int pokemonId,
                required int abilityId,
                required int slot,
                Value<bool> isHidden = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PokemonAbilitiesTableCompanion.insert(
                pokemonId: pokemonId,
                abilityId: abilityId,
                slot: slot,
                isHidden: isHidden,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PokemonAbilitiesTableTable, PokemonAbilityRow>(
                    table,
                  ),
                  $$PokemonAbilitiesTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({pokemonId = false, abilityId = false}) {
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
                    if (pokemonId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.pokemonId,
                        referencedTable: $$PokemonAbilitiesTableTableReferences
                            ._pokemonIdTable(db),
                        referencedColumn: $$PokemonAbilitiesTableTableReferences
                            ._pokemonIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (abilityId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.abilityId,
                        referencedTable: $$PokemonAbilitiesTableTableReferences
                            ._abilityIdTable(db),
                        referencedColumn: $$PokemonAbilitiesTableTableReferences
                            ._abilityIdTable(db)
                            .id,
                      ) as T;
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

typedef $$PokemonAbilitiesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PokemonAbilitiesTableTable,
      PokemonAbilityRow,
      $$PokemonAbilitiesTableTableFilterComposer,
      $$PokemonAbilitiesTableTableOrderingComposer,
      $$PokemonAbilitiesTableTableAnnotationComposer,
      $$PokemonAbilitiesTableTableCreateCompanionBuilder,
      $$PokemonAbilitiesTableTableUpdateCompanionBuilder,
      (PokemonAbilityRow, $$PokemonAbilitiesTableTableReferences),
      PokemonAbilityRow,
      PrefetchHooks Function({bool pokemonId, bool abilityId})
    >;
typedef $$EvolutionSpeciesTableTableCreateCompanionBuilder =
    EvolutionSpeciesTableCompanion Function({
      Value<int> speciesId,
      required int chainId,
      Value<int?> evolvesFromId,
      required String name,
    });
typedef $$EvolutionSpeciesTableTableUpdateCompanionBuilder =
    EvolutionSpeciesTableCompanion Function({
      Value<int> speciesId,
      Value<int> chainId,
      Value<int?> evolvesFromId,
      Value<String> name,
    });

final class $$EvolutionSpeciesTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $EvolutionSpeciesTableTable,
          EvolutionSpeciesRow
        > {
  $$EvolutionSpeciesTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<
    $EvolutionMethodsTableTable,
    List<EvolutionMethodRow>
  >
  _evolutionMethodsTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.evolutionMethodsTable,
        aliasName:
            'evolution_species__species_id__evolution_methods__species_id',
      );

  $$EvolutionMethodsTableTableProcessedTableManager
  get evolutionMethodsTableRefs {
    final manager =
        $$EvolutionMethodsTableTableTableManager(
          $_db,
          $_db.evolutionMethodsTable,
        ).filter(
          (f) =>
              f.speciesId.speciesId.sqlEquals($_itemColumn<int>('species_id')!),
        );

    final cache = $_typedResult.readTableOrNull(
      _evolutionMethodsTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$EvolutionSpeciesTableTableFilterComposer
    extends Composer<_$AppDatabase, $EvolutionSpeciesTableTable> {
  $$EvolutionSpeciesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get speciesId => $composableBuilder(
    column: $table.speciesId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get chainId => $composableBuilder(
    column: $table.chainId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get evolvesFromId => $composableBuilder(
    column: $table.evolvesFromId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> evolutionMethodsTableRefs(
    Expression<bool> Function($$EvolutionMethodsTableTableFilterComposer f) f,
  ) {
    final $$EvolutionMethodsTableTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.speciesId,
          referencedTable: $db.evolutionMethodsTable,
          getReferencedColumn: (t) => t.speciesId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$EvolutionMethodsTableTableFilterComposer(
                $db: $db,
                $table: $db.evolutionMethodsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$EvolutionSpeciesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $EvolutionSpeciesTableTable> {
  $$EvolutionSpeciesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get speciesId => $composableBuilder(
    column: $table.speciesId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get chainId => $composableBuilder(
    column: $table.chainId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get evolvesFromId => $composableBuilder(
    column: $table.evolvesFromId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$EvolutionSpeciesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $EvolutionSpeciesTableTable> {
  $$EvolutionSpeciesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get speciesId =>
      $composableBuilder(column: $table.speciesId, builder: (column) => column);

  GeneratedColumn<int> get chainId =>
      $composableBuilder(column: $table.chainId, builder: (column) => column);

  GeneratedColumn<int> get evolvesFromId => $composableBuilder(
    column: $table.evolvesFromId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  Expression<T> evolutionMethodsTableRefs<T extends Object>(
    Expression<T> Function($$EvolutionMethodsTableTableAnnotationComposer a) f,
  ) {
    final $$EvolutionMethodsTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.speciesId,
          referencedTable: $db.evolutionMethodsTable,
          getReferencedColumn: (t) => t.speciesId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$EvolutionMethodsTableTableAnnotationComposer(
                $db: $db,
                $table: $db.evolutionMethodsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$EvolutionSpeciesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EvolutionSpeciesTableTable,
          EvolutionSpeciesRow,
          $$EvolutionSpeciesTableTableFilterComposer,
          $$EvolutionSpeciesTableTableOrderingComposer,
          $$EvolutionSpeciesTableTableAnnotationComposer,
          $$EvolutionSpeciesTableTableCreateCompanionBuilder,
          $$EvolutionSpeciesTableTableUpdateCompanionBuilder,
          (EvolutionSpeciesRow, $$EvolutionSpeciesTableTableReferences),
          EvolutionSpeciesRow,
          PrefetchHooks Function({bool evolutionMethodsTableRefs})
        > {
  $$EvolutionSpeciesTableTableTableManager(
    _$AppDatabase db,
    $EvolutionSpeciesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EvolutionSpeciesTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$EvolutionSpeciesTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$EvolutionSpeciesTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> speciesId = const Value.absent(),
                Value<int> chainId = const Value.absent(),
                Value<int?> evolvesFromId = const Value.absent(),
                Value<String> name = const Value.absent(),
              }) => EvolutionSpeciesTableCompanion(
                speciesId: speciesId,
                chainId: chainId,
                evolvesFromId: evolvesFromId,
                name: name,
              ),
          createCompanionCallback:
              ({
                Value<int> speciesId = const Value.absent(),
                required int chainId,
                Value<int?> evolvesFromId = const Value.absent(),
                required String name,
              }) => EvolutionSpeciesTableCompanion.insert(
                speciesId: speciesId,
                chainId: chainId,
                evolvesFromId: evolvesFromId,
                name: name,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$EvolutionSpeciesTableTable, EvolutionSpeciesRow>(
                    table,
                  ),
                  $$EvolutionSpeciesTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({evolutionMethodsTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (evolutionMethodsTableRefs) db.evolutionMethodsTable,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (evolutionMethodsTableRefs)
                    await $_getPrefetchedDataByColumns<
                      EvolutionSpeciesRow,
                      $EvolutionSpeciesTableTable,
                      EvolutionMethodRow,
                      $EvolutionMethodsTableTable
                    >(
                      currentTable: table,
                      referencedTable: $$EvolutionSpeciesTableTableReferences
                          ._evolutionMethodsTableRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$EvolutionSpeciesTableTableReferences(
                            db,
                            table,
                            p0,
                          ).evolutionMethodsTableRefs,
                      currentColumn: 'species_id',
                      referencedColumn: 'species_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$EvolutionSpeciesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EvolutionSpeciesTableTable,
      EvolutionSpeciesRow,
      $$EvolutionSpeciesTableTableFilterComposer,
      $$EvolutionSpeciesTableTableOrderingComposer,
      $$EvolutionSpeciesTableTableAnnotationComposer,
      $$EvolutionSpeciesTableTableCreateCompanionBuilder,
      $$EvolutionSpeciesTableTableUpdateCompanionBuilder,
      (EvolutionSpeciesRow, $$EvolutionSpeciesTableTableReferences),
      EvolutionSpeciesRow,
      PrefetchHooks Function({bool evolutionMethodsTableRefs})
    >;
typedef $$EvolutionMethodsTableTableCreateCompanionBuilder =
    EvolutionMethodsTableCompanion Function({
      Value<int> id,
      required int speciesId,
      required String trigger,
      Value<int?> minLevel,
      Value<String?> item,
      Value<String?> heldItem,
      Value<int?> minHappiness,
      Value<String?> timeOfDay,
      Value<String?> location,
      Value<String?> knownMove,
      Value<String?> knownMoveType,
    });
typedef $$EvolutionMethodsTableTableUpdateCompanionBuilder =
    EvolutionMethodsTableCompanion Function({
      Value<int> id,
      Value<int> speciesId,
      Value<String> trigger,
      Value<int?> minLevel,
      Value<String?> item,
      Value<String?> heldItem,
      Value<int?> minHappiness,
      Value<String?> timeOfDay,
      Value<String?> location,
      Value<String?> knownMove,
      Value<String?> knownMoveType,
    });

final class $$EvolutionMethodsTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $EvolutionMethodsTableTable,
          EvolutionMethodRow
        > {
  $$EvolutionMethodsTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $EvolutionSpeciesTableTable _speciesIdTable(_$AppDatabase db) =>
      db.evolutionSpeciesTable.createAlias(
        'evolution_methods__species_id__evolution_species__species_id',
      );

  $$EvolutionSpeciesTableTableProcessedTableManager get speciesId {
    final $_column = $_itemColumn<int>('species_id')!;

    final manager = $$EvolutionSpeciesTableTableTableManager(
      $_db,
      $_db.evolutionSpeciesTable,
    ).filter((f) => f.speciesId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_speciesIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$EvolutionMethodsTableTableFilterComposer
    extends Composer<_$AppDatabase, $EvolutionMethodsTableTable> {
  $$EvolutionMethodsTableTableFilterComposer({
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

  ColumnFilters<String> get trigger => $composableBuilder(
    column: $table.trigger,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get minLevel => $composableBuilder(
    column: $table.minLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get item => $composableBuilder(
    column: $table.item,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get heldItem => $composableBuilder(
    column: $table.heldItem,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get minHappiness => $composableBuilder(
    column: $table.minHappiness,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get timeOfDay => $composableBuilder(
    column: $table.timeOfDay,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get knownMove => $composableBuilder(
    column: $table.knownMove,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get knownMoveType => $composableBuilder(
    column: $table.knownMoveType,
    builder: (column) => ColumnFilters(column),
  );

  $$EvolutionSpeciesTableTableFilterComposer get speciesId {
    final $$EvolutionSpeciesTableTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.speciesId,
          referencedTable: $db.evolutionSpeciesTable,
          getReferencedColumn: (t) => t.speciesId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$EvolutionSpeciesTableTableFilterComposer(
                $db: $db,
                $table: $db.evolutionSpeciesTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$EvolutionMethodsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $EvolutionMethodsTableTable> {
  $$EvolutionMethodsTableTableOrderingComposer({
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

  ColumnOrderings<String> get trigger => $composableBuilder(
    column: $table.trigger,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get minLevel => $composableBuilder(
    column: $table.minLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get item => $composableBuilder(
    column: $table.item,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get heldItem => $composableBuilder(
    column: $table.heldItem,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get minHappiness => $composableBuilder(
    column: $table.minHappiness,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get timeOfDay => $composableBuilder(
    column: $table.timeOfDay,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get knownMove => $composableBuilder(
    column: $table.knownMove,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get knownMoveType => $composableBuilder(
    column: $table.knownMoveType,
    builder: (column) => ColumnOrderings(column),
  );

  $$EvolutionSpeciesTableTableOrderingComposer get speciesId {
    final $$EvolutionSpeciesTableTableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.speciesId,
          referencedTable: $db.evolutionSpeciesTable,
          getReferencedColumn: (t) => t.speciesId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$EvolutionSpeciesTableTableOrderingComposer(
                $db: $db,
                $table: $db.evolutionSpeciesTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$EvolutionMethodsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $EvolutionMethodsTableTable> {
  $$EvolutionMethodsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get trigger =>
      $composableBuilder(column: $table.trigger, builder: (column) => column);

  GeneratedColumn<int> get minLevel =>
      $composableBuilder(column: $table.minLevel, builder: (column) => column);

  GeneratedColumn<String> get item =>
      $composableBuilder(column: $table.item, builder: (column) => column);

  GeneratedColumn<String> get heldItem =>
      $composableBuilder(column: $table.heldItem, builder: (column) => column);

  GeneratedColumn<int> get minHappiness => $composableBuilder(
    column: $table.minHappiness,
    builder: (column) => column,
  );

  GeneratedColumn<String> get timeOfDay =>
      $composableBuilder(column: $table.timeOfDay, builder: (column) => column);

  GeneratedColumn<String> get location =>
      $composableBuilder(column: $table.location, builder: (column) => column);

  GeneratedColumn<String> get knownMove =>
      $composableBuilder(column: $table.knownMove, builder: (column) => column);

  GeneratedColumn<String> get knownMoveType => $composableBuilder(
    column: $table.knownMoveType,
    builder: (column) => column,
  );

  $$EvolutionSpeciesTableTableAnnotationComposer get speciesId {
    final $$EvolutionSpeciesTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.speciesId,
          referencedTable: $db.evolutionSpeciesTable,
          getReferencedColumn: (t) => t.speciesId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$EvolutionSpeciesTableTableAnnotationComposer(
                $db: $db,
                $table: $db.evolutionSpeciesTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$EvolutionMethodsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EvolutionMethodsTableTable,
          EvolutionMethodRow,
          $$EvolutionMethodsTableTableFilterComposer,
          $$EvolutionMethodsTableTableOrderingComposer,
          $$EvolutionMethodsTableTableAnnotationComposer,
          $$EvolutionMethodsTableTableCreateCompanionBuilder,
          $$EvolutionMethodsTableTableUpdateCompanionBuilder,
          (EvolutionMethodRow, $$EvolutionMethodsTableTableReferences),
          EvolutionMethodRow,
          PrefetchHooks Function({bool speciesId})
        > {
  $$EvolutionMethodsTableTableTableManager(
    _$AppDatabase db,
    $EvolutionMethodsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EvolutionMethodsTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$EvolutionMethodsTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$EvolutionMethodsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> speciesId = const Value.absent(),
                Value<String> trigger = const Value.absent(),
                Value<int?> minLevel = const Value.absent(),
                Value<String?> item = const Value.absent(),
                Value<String?> heldItem = const Value.absent(),
                Value<int?> minHappiness = const Value.absent(),
                Value<String?> timeOfDay = const Value.absent(),
                Value<String?> location = const Value.absent(),
                Value<String?> knownMove = const Value.absent(),
                Value<String?> knownMoveType = const Value.absent(),
              }) => EvolutionMethodsTableCompanion(
                id: id,
                speciesId: speciesId,
                trigger: trigger,
                minLevel: minLevel,
                item: item,
                heldItem: heldItem,
                minHappiness: minHappiness,
                timeOfDay: timeOfDay,
                location: location,
                knownMove: knownMove,
                knownMoveType: knownMoveType,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int speciesId,
                required String trigger,
                Value<int?> minLevel = const Value.absent(),
                Value<String?> item = const Value.absent(),
                Value<String?> heldItem = const Value.absent(),
                Value<int?> minHappiness = const Value.absent(),
                Value<String?> timeOfDay = const Value.absent(),
                Value<String?> location = const Value.absent(),
                Value<String?> knownMove = const Value.absent(),
                Value<String?> knownMoveType = const Value.absent(),
              }) => EvolutionMethodsTableCompanion.insert(
                id: id,
                speciesId: speciesId,
                trigger: trigger,
                minLevel: minLevel,
                item: item,
                heldItem: heldItem,
                minHappiness: minHappiness,
                timeOfDay: timeOfDay,
                location: location,
                knownMove: knownMove,
                knownMoveType: knownMoveType,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$EvolutionMethodsTableTable, EvolutionMethodRow>(
                    table,
                  ),
                  $$EvolutionMethodsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({speciesId = false}) {
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
                    if (speciesId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.speciesId,
                        referencedTable: $$EvolutionMethodsTableTableReferences
                            ._speciesIdTable(db),
                        referencedColumn: $$EvolutionMethodsTableTableReferences
                            ._speciesIdTable(db)
                            .speciesId,
                      ) as T;
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

typedef $$EvolutionMethodsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EvolutionMethodsTableTable,
      EvolutionMethodRow,
      $$EvolutionMethodsTableTableFilterComposer,
      $$EvolutionMethodsTableTableOrderingComposer,
      $$EvolutionMethodsTableTableAnnotationComposer,
      $$EvolutionMethodsTableTableCreateCompanionBuilder,
      $$EvolutionMethodsTableTableUpdateCompanionBuilder,
      (EvolutionMethodRow, $$EvolutionMethodsTableTableReferences),
      EvolutionMethodRow,
      PrefetchHooks Function({bool speciesId})
    >;
typedef $$MovesTableTableCreateCompanionBuilder = MovesTableCompanion Function({
  Value<int> id,
  required String name,
  Value<String?> nameEs,
  Value<String?> nameEn,
  Value<int?> typeId,
  Value<int?> power,
  Value<int?> accuracy,
  Value<int?> pp,
  Value<String?> damageClass,
});
typedef $$MovesTableTableUpdateCompanionBuilder = MovesTableCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String?> nameEs,
  Value<String?> nameEn,
  Value<int?> typeId,
  Value<int?> power,
  Value<int?> accuracy,
  Value<int?> pp,
  Value<String?> damageClass,
});

final class $$MovesTableTableReferences
    extends BaseReferences<_$AppDatabase, $MovesTableTable, MoveRow> {
  $$MovesTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$PokemonMovesTableTable, List<PokemonMoveRow>>
  _pokemonMovesTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.pokemonMovesTable,
        aliasName: 'moves__id__pokemon_moves__move_id',
      );

  $$PokemonMovesTableTableProcessedTableManager get pokemonMovesTableRefs {
    final manager = $$PokemonMovesTableTableTableManager(
      $_db,
      $_db.pokemonMovesTable,
    ).filter((f) => f.moveId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _pokemonMovesTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$MovesTableTableFilterComposer
    extends Composer<_$AppDatabase, $MovesTableTable> {
  $$MovesTableTableFilterComposer({
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

  ColumnFilters<String> get nameEs => $composableBuilder(
    column: $table.nameEs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get typeId => $composableBuilder(
    column: $table.typeId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get power => $composableBuilder(
    column: $table.power,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get accuracy => $composableBuilder(
    column: $table.accuracy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pp => $composableBuilder(
    column: $table.pp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get damageClass => $composableBuilder(
    column: $table.damageClass,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> pokemonMovesTableRefs(
    Expression<bool> Function($$PokemonMovesTableTableFilterComposer f) f,
  ) {
    final $$PokemonMovesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pokemonMovesTable,
      getReferencedColumn: (t) => t.moveId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonMovesTableTableFilterComposer(
            $db: $db,
            $table: $db.pokemonMovesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MovesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $MovesTableTable> {
  $$MovesTableTableOrderingComposer({
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

  ColumnOrderings<String> get nameEs => $composableBuilder(
    column: $table.nameEs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get typeId => $composableBuilder(
    column: $table.typeId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get power => $composableBuilder(
    column: $table.power,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get accuracy => $composableBuilder(
    column: $table.accuracy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pp => $composableBuilder(
    column: $table.pp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get damageClass => $composableBuilder(
    column: $table.damageClass,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MovesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $MovesTableTable> {
  $$MovesTableTableAnnotationComposer({
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

  GeneratedColumn<String> get nameEs =>
      $composableBuilder(column: $table.nameEs, builder: (column) => column);

  GeneratedColumn<String> get nameEn =>
      $composableBuilder(column: $table.nameEn, builder: (column) => column);

  GeneratedColumn<int> get typeId =>
      $composableBuilder(column: $table.typeId, builder: (column) => column);

  GeneratedColumn<int> get power =>
      $composableBuilder(column: $table.power, builder: (column) => column);

  GeneratedColumn<int> get accuracy =>
      $composableBuilder(column: $table.accuracy, builder: (column) => column);

  GeneratedColumn<int> get pp =>
      $composableBuilder(column: $table.pp, builder: (column) => column);

  GeneratedColumn<String> get damageClass => $composableBuilder(
    column: $table.damageClass,
    builder: (column) => column,
  );

  Expression<T> pokemonMovesTableRefs<T extends Object>(
    Expression<T> Function($$PokemonMovesTableTableAnnotationComposer a) f,
  ) {
    final $$PokemonMovesTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.pokemonMovesTable,
          getReferencedColumn: (t) => t.moveId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PokemonMovesTableTableAnnotationComposer(
                $db: $db,
                $table: $db.pokemonMovesTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$MovesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MovesTableTable,
          MoveRow,
          $$MovesTableTableFilterComposer,
          $$MovesTableTableOrderingComposer,
          $$MovesTableTableAnnotationComposer,
          $$MovesTableTableCreateCompanionBuilder,
          $$MovesTableTableUpdateCompanionBuilder,
          (MoveRow, $$MovesTableTableReferences),
          MoveRow,
          PrefetchHooks Function({bool pokemonMovesTableRefs})
        > {
  $$MovesTableTableTableManager(_$AppDatabase db, $MovesTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MovesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MovesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MovesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> nameEs = const Value.absent(),
                Value<String?> nameEn = const Value.absent(),
                Value<int?> typeId = const Value.absent(),
                Value<int?> power = const Value.absent(),
                Value<int?> accuracy = const Value.absent(),
                Value<int?> pp = const Value.absent(),
                Value<String?> damageClass = const Value.absent(),
              }) => MovesTableCompanion(
                id: id,
                name: name,
                nameEs: nameEs,
                nameEn: nameEn,
                typeId: typeId,
                power: power,
                accuracy: accuracy,
                pp: pp,
                damageClass: damageClass,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> nameEs = const Value.absent(),
                Value<String?> nameEn = const Value.absent(),
                Value<int?> typeId = const Value.absent(),
                Value<int?> power = const Value.absent(),
                Value<int?> accuracy = const Value.absent(),
                Value<int?> pp = const Value.absent(),
                Value<String?> damageClass = const Value.absent(),
              }) => MovesTableCompanion.insert(
                id: id,
                name: name,
                nameEs: nameEs,
                nameEn: nameEn,
                typeId: typeId,
                power: power,
                accuracy: accuracy,
                pp: pp,
                damageClass: damageClass,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$MovesTableTable, MoveRow>(table),
                  $$MovesTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({pokemonMovesTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (pokemonMovesTableRefs) db.pokemonMovesTable,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (pokemonMovesTableRefs)
                    await $_getPrefetchedDataByColumns<
                      MoveRow,
                      $MovesTableTable,
                      PokemonMoveRow,
                      $PokemonMovesTableTable
                    >(
                      currentTable: table,
                      referencedTable: $$MovesTableTableReferences
                          ._pokemonMovesTableRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$MovesTableTableReferences(
                            db,
                            table,
                            p0,
                          ).pokemonMovesTableRefs,
                      currentColumn: 'id',
                      referencedColumn: 'move_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$MovesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MovesTableTable,
      MoveRow,
      $$MovesTableTableFilterComposer,
      $$MovesTableTableOrderingComposer,
      $$MovesTableTableAnnotationComposer,
      $$MovesTableTableCreateCompanionBuilder,
      $$MovesTableTableUpdateCompanionBuilder,
      (MoveRow, $$MovesTableTableReferences),
      MoveRow,
      PrefetchHooks Function({bool pokemonMovesTableRefs})
    >;
typedef $$PokemonMovesTableTableCreateCompanionBuilder =
    PokemonMovesTableCompanion Function({
      required int pokemonId,
      required int moveId,
      required String method,
      required int level,
      Value<int> rowid,
    });
typedef $$PokemonMovesTableTableUpdateCompanionBuilder =
    PokemonMovesTableCompanion Function({
      Value<int> pokemonId,
      Value<int> moveId,
      Value<String> method,
      Value<int> level,
      Value<int> rowid,
    });

final class $$PokemonMovesTableTableReferences
    extends
        BaseReferences<_$AppDatabase, $PokemonMovesTableTable, PokemonMoveRow> {
  $$PokemonMovesTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $PokemonTableTable _pokemonIdTable(_$AppDatabase db) =>
      db.pokemonTable.createAlias('pokemon_moves__pokemon_id__pokemon__id');

  $$PokemonTableTableProcessedTableManager get pokemonId {
    final $_column = $_itemColumn<int>('pokemon_id')!;

    final manager = $$PokemonTableTableTableManager(
      $_db,
      $_db.pokemonTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_pokemonIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $MovesTableTable _moveIdTable(_$AppDatabase db) =>
      db.movesTable.createAlias('pokemon_moves__move_id__moves__id');

  $$MovesTableTableProcessedTableManager get moveId {
    final $_column = $_itemColumn<int>('move_id')!;

    final manager = $$MovesTableTableTableManager(
      $_db,
      $_db.movesTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_moveIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PokemonMovesTableTableFilterComposer
    extends Composer<_$AppDatabase, $PokemonMovesTableTable> {
  $$PokemonMovesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get method => $composableBuilder(
    column: $table.method,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnFilters(column),
  );

  $$PokemonTableTableFilterComposer get pokemonId {
    final $$PokemonTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pokemonId,
      referencedTable: $db.pokemonTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonTableTableFilterComposer(
            $db: $db,
            $table: $db.pokemonTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MovesTableTableFilterComposer get moveId {
    final $$MovesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.moveId,
      referencedTable: $db.movesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MovesTableTableFilterComposer(
            $db: $db,
            $table: $db.movesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PokemonMovesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PokemonMovesTableTable> {
  $$PokemonMovesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get method => $composableBuilder(
    column: $table.method,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnOrderings(column),
  );

  $$PokemonTableTableOrderingComposer get pokemonId {
    final $$PokemonTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pokemonId,
      referencedTable: $db.pokemonTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonTableTableOrderingComposer(
            $db: $db,
            $table: $db.pokemonTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MovesTableTableOrderingComposer get moveId {
    final $$MovesTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.moveId,
      referencedTable: $db.movesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MovesTableTableOrderingComposer(
            $db: $db,
            $table: $db.movesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PokemonMovesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PokemonMovesTableTable> {
  $$PokemonMovesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get method =>
      $composableBuilder(column: $table.method, builder: (column) => column);

  GeneratedColumn<int> get level =>
      $composableBuilder(column: $table.level, builder: (column) => column);

  $$PokemonTableTableAnnotationComposer get pokemonId {
    final $$PokemonTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pokemonId,
      referencedTable: $db.pokemonTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonTableTableAnnotationComposer(
            $db: $db,
            $table: $db.pokemonTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MovesTableTableAnnotationComposer get moveId {
    final $$MovesTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.moveId,
      referencedTable: $db.movesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MovesTableTableAnnotationComposer(
            $db: $db,
            $table: $db.movesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PokemonMovesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PokemonMovesTableTable,
          PokemonMoveRow,
          $$PokemonMovesTableTableFilterComposer,
          $$PokemonMovesTableTableOrderingComposer,
          $$PokemonMovesTableTableAnnotationComposer,
          $$PokemonMovesTableTableCreateCompanionBuilder,
          $$PokemonMovesTableTableUpdateCompanionBuilder,
          (PokemonMoveRow, $$PokemonMovesTableTableReferences),
          PokemonMoveRow,
          PrefetchHooks Function({bool pokemonId, bool moveId})
        > {
  $$PokemonMovesTableTableTableManager(
    _$AppDatabase db,
    $PokemonMovesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PokemonMovesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PokemonMovesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PokemonMovesTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> pokemonId = const Value.absent(),
                Value<int> moveId = const Value.absent(),
                Value<String> method = const Value.absent(),
                Value<int> level = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PokemonMovesTableCompanion(
                pokemonId: pokemonId,
                moveId: moveId,
                method: method,
                level: level,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int pokemonId,
                required int moveId,
                required String method,
                required int level,
                Value<int> rowid = const Value.absent(),
              }) => PokemonMovesTableCompanion.insert(
                pokemonId: pokemonId,
                moveId: moveId,
                method: method,
                level: level,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PokemonMovesTableTable, PokemonMoveRow>(table),
                  $$PokemonMovesTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({pokemonId = false, moveId = false}) {
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
                    if (pokemonId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.pokemonId,
                        referencedTable: $$PokemonMovesTableTableReferences
                            ._pokemonIdTable(db),
                        referencedColumn: $$PokemonMovesTableTableReferences
                            ._pokemonIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (moveId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.moveId,
                        referencedTable: $$PokemonMovesTableTableReferences
                            ._moveIdTable(db),
                        referencedColumn: $$PokemonMovesTableTableReferences
                            ._moveIdTable(db)
                            .id,
                      ) as T;
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

typedef $$PokemonMovesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PokemonMovesTableTable,
      PokemonMoveRow,
      $$PokemonMovesTableTableFilterComposer,
      $$PokemonMovesTableTableOrderingComposer,
      $$PokemonMovesTableTableAnnotationComposer,
      $$PokemonMovesTableTableCreateCompanionBuilder,
      $$PokemonMovesTableTableUpdateCompanionBuilder,
      (PokemonMoveRow, $$PokemonMovesTableTableReferences),
      PokemonMoveRow,
      PrefetchHooks Function({bool pokemonId, bool moveId})
    >;
typedef $$TriviaResultsTableTableCreateCompanionBuilder =
    TriviaResultsTableCompanion Function({
      Value<int> id,
      required int score,
      required int correctAnswers,
      required int totalQuestions,
      Value<DateTime> playedAt,
    });
typedef $$TriviaResultsTableTableUpdateCompanionBuilder =
    TriviaResultsTableCompanion Function({
      Value<int> id,
      Value<int> score,
      Value<int> correctAnswers,
      Value<int> totalQuestions,
      Value<DateTime> playedAt,
    });

final class $$TriviaResultsTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $TriviaResultsTableTable,
          TriviaResultRow
        > {
  $$TriviaResultsTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$TriviaAnswersTableTable, List<TriviaAnswerRow>>
  _triviaAnswersTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.triviaAnswersTable,
        aliasName: 'trivia_results__id__trivia_answers__result_id',
      );

  $$TriviaAnswersTableTableProcessedTableManager get triviaAnswersTableRefs {
    final manager = $$TriviaAnswersTableTableTableManager(
      $_db,
      $_db.triviaAnswersTable,
    ).filter((f) => f.resultId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _triviaAnswersTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TriviaResultsTableTableFilterComposer
    extends Composer<_$AppDatabase, $TriviaResultsTableTable> {
  $$TriviaResultsTableTableFilterComposer({
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

  ColumnFilters<int> get score => $composableBuilder(
    column: $table.score,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get correctAnswers => $composableBuilder(
    column: $table.correctAnswers,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalQuestions => $composableBuilder(
    column: $table.totalQuestions,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get playedAt => $composableBuilder(
    column: $table.playedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> triviaAnswersTableRefs(
    Expression<bool> Function($$TriviaAnswersTableTableFilterComposer f) f,
  ) {
    final $$TriviaAnswersTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.triviaAnswersTable,
      getReferencedColumn: (t) => t.resultId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TriviaAnswersTableTableFilterComposer(
            $db: $db,
            $table: $db.triviaAnswersTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TriviaResultsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $TriviaResultsTableTable> {
  $$TriviaResultsTableTableOrderingComposer({
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

  ColumnOrderings<int> get score => $composableBuilder(
    column: $table.score,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get correctAnswers => $composableBuilder(
    column: $table.correctAnswers,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalQuestions => $composableBuilder(
    column: $table.totalQuestions,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get playedAt => $composableBuilder(
    column: $table.playedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TriviaResultsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $TriviaResultsTableTable> {
  $$TriviaResultsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get score =>
      $composableBuilder(column: $table.score, builder: (column) => column);

  GeneratedColumn<int> get correctAnswers => $composableBuilder(
    column: $table.correctAnswers,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalQuestions => $composableBuilder(
    column: $table.totalQuestions,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get playedAt =>
      $composableBuilder(column: $table.playedAt, builder: (column) => column);

  Expression<T> triviaAnswersTableRefs<T extends Object>(
    Expression<T> Function($$TriviaAnswersTableTableAnnotationComposer a) f,
  ) {
    final $$TriviaAnswersTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.triviaAnswersTable,
          getReferencedColumn: (t) => t.resultId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$TriviaAnswersTableTableAnnotationComposer(
                $db: $db,
                $table: $db.triviaAnswersTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$TriviaResultsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TriviaResultsTableTable,
          TriviaResultRow,
          $$TriviaResultsTableTableFilterComposer,
          $$TriviaResultsTableTableOrderingComposer,
          $$TriviaResultsTableTableAnnotationComposer,
          $$TriviaResultsTableTableCreateCompanionBuilder,
          $$TriviaResultsTableTableUpdateCompanionBuilder,
          (TriviaResultRow, $$TriviaResultsTableTableReferences),
          TriviaResultRow,
          PrefetchHooks Function({bool triviaAnswersTableRefs})
        > {
  $$TriviaResultsTableTableTableManager(
    _$AppDatabase db,
    $TriviaResultsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TriviaResultsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TriviaResultsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TriviaResultsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> score = const Value.absent(),
                Value<int> correctAnswers = const Value.absent(),
                Value<int> totalQuestions = const Value.absent(),
                Value<DateTime> playedAt = const Value.absent(),
              }) => TriviaResultsTableCompanion(
                id: id,
                score: score,
                correctAnswers: correctAnswers,
                totalQuestions: totalQuestions,
                playedAt: playedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int score,
                required int correctAnswers,
                required int totalQuestions,
                Value<DateTime> playedAt = const Value.absent(),
              }) => TriviaResultsTableCompanion.insert(
                id: id,
                score: score,
                correctAnswers: correctAnswers,
                totalQuestions: totalQuestions,
                playedAt: playedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TriviaResultsTableTable, TriviaResultRow>(table),
                  $$TriviaResultsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({triviaAnswersTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (triviaAnswersTableRefs) db.triviaAnswersTable,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (triviaAnswersTableRefs)
                    await $_getPrefetchedDataByColumns<
                      TriviaResultRow,
                      $TriviaResultsTableTable,
                      TriviaAnswerRow,
                      $TriviaAnswersTableTable
                    >(
                      currentTable: table,
                      referencedTable: $$TriviaResultsTableTableReferences
                          ._triviaAnswersTableRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$TriviaResultsTableTableReferences(
                            db,
                            table,
                            p0,
                          ).triviaAnswersTableRefs,
                      currentColumn: 'id',
                      referencedColumn: 'result_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$TriviaResultsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TriviaResultsTableTable,
      TriviaResultRow,
      $$TriviaResultsTableTableFilterComposer,
      $$TriviaResultsTableTableOrderingComposer,
      $$TriviaResultsTableTableAnnotationComposer,
      $$TriviaResultsTableTableCreateCompanionBuilder,
      $$TriviaResultsTableTableUpdateCompanionBuilder,
      (TriviaResultRow, $$TriviaResultsTableTableReferences),
      TriviaResultRow,
      PrefetchHooks Function({bool triviaAnswersTableRefs})
    >;
typedef $$TriviaAnswersTableTableCreateCompanionBuilder =
    TriviaAnswersTableCompanion Function({
      required int resultId,
      required int questionNumber,
      required int pokemonId,
      required bool correct,
      Value<int> rowid,
    });
typedef $$TriviaAnswersTableTableUpdateCompanionBuilder =
    TriviaAnswersTableCompanion Function({
      Value<int> resultId,
      Value<int> questionNumber,
      Value<int> pokemonId,
      Value<bool> correct,
      Value<int> rowid,
    });

final class $$TriviaAnswersTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $TriviaAnswersTableTable,
          TriviaAnswerRow
        > {
  $$TriviaAnswersTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $TriviaResultsTableTable _resultIdTable(_$AppDatabase db) => db
      .triviaResultsTable
      .createAlias('trivia_answers__result_id__trivia_results__id');

  $$TriviaResultsTableTableProcessedTableManager get resultId {
    final $_column = $_itemColumn<int>('result_id')!;

    final manager = $$TriviaResultsTableTableTableManager(
      $_db,
      $_db.triviaResultsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_resultIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TriviaAnswersTableTableFilterComposer
    extends Composer<_$AppDatabase, $TriviaAnswersTableTable> {
  $$TriviaAnswersTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get questionNumber => $composableBuilder(
    column: $table.questionNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pokemonId => $composableBuilder(
    column: $table.pokemonId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get correct => $composableBuilder(
    column: $table.correct,
    builder: (column) => ColumnFilters(column),
  );

  $$TriviaResultsTableTableFilterComposer get resultId {
    final $$TriviaResultsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.resultId,
      referencedTable: $db.triviaResultsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TriviaResultsTableTableFilterComposer(
            $db: $db,
            $table: $db.triviaResultsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TriviaAnswersTableTableOrderingComposer
    extends Composer<_$AppDatabase, $TriviaAnswersTableTable> {
  $$TriviaAnswersTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get questionNumber => $composableBuilder(
    column: $table.questionNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pokemonId => $composableBuilder(
    column: $table.pokemonId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get correct => $composableBuilder(
    column: $table.correct,
    builder: (column) => ColumnOrderings(column),
  );

  $$TriviaResultsTableTableOrderingComposer get resultId {
    final $$TriviaResultsTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.resultId,
      referencedTable: $db.triviaResultsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TriviaResultsTableTableOrderingComposer(
            $db: $db,
            $table: $db.triviaResultsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TriviaAnswersTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $TriviaAnswersTableTable> {
  $$TriviaAnswersTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get questionNumber => $composableBuilder(
    column: $table.questionNumber,
    builder: (column) => column,
  );

  GeneratedColumn<int> get pokemonId =>
      $composableBuilder(column: $table.pokemonId, builder: (column) => column);

  GeneratedColumn<bool> get correct =>
      $composableBuilder(column: $table.correct, builder: (column) => column);

  $$TriviaResultsTableTableAnnotationComposer get resultId {
    final $$TriviaResultsTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.resultId,
          referencedTable: $db.triviaResultsTable,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$TriviaResultsTableTableAnnotationComposer(
                $db: $db,
                $table: $db.triviaResultsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$TriviaAnswersTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TriviaAnswersTableTable,
          TriviaAnswerRow,
          $$TriviaAnswersTableTableFilterComposer,
          $$TriviaAnswersTableTableOrderingComposer,
          $$TriviaAnswersTableTableAnnotationComposer,
          $$TriviaAnswersTableTableCreateCompanionBuilder,
          $$TriviaAnswersTableTableUpdateCompanionBuilder,
          (TriviaAnswerRow, $$TriviaAnswersTableTableReferences),
          TriviaAnswerRow,
          PrefetchHooks Function({bool resultId})
        > {
  $$TriviaAnswersTableTableTableManager(
    _$AppDatabase db,
    $TriviaAnswersTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TriviaAnswersTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TriviaAnswersTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TriviaAnswersTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> resultId = const Value.absent(),
                Value<int> questionNumber = const Value.absent(),
                Value<int> pokemonId = const Value.absent(),
                Value<bool> correct = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TriviaAnswersTableCompanion(
                resultId: resultId,
                questionNumber: questionNumber,
                pokemonId: pokemonId,
                correct: correct,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int resultId,
                required int questionNumber,
                required int pokemonId,
                required bool correct,
                Value<int> rowid = const Value.absent(),
              }) => TriviaAnswersTableCompanion.insert(
                resultId: resultId,
                questionNumber: questionNumber,
                pokemonId: pokemonId,
                correct: correct,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TriviaAnswersTableTable, TriviaAnswerRow>(table),
                  $$TriviaAnswersTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({resultId = false}) {
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
                    if (resultId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.resultId,
                        referencedTable: $$TriviaAnswersTableTableReferences
                            ._resultIdTable(db),
                        referencedColumn: $$TriviaAnswersTableTableReferences
                            ._resultIdTable(db)
                            .id,
                      ) as T;
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

typedef $$TriviaAnswersTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TriviaAnswersTableTable,
      TriviaAnswerRow,
      $$TriviaAnswersTableTableFilterComposer,
      $$TriviaAnswersTableTableOrderingComposer,
      $$TriviaAnswersTableTableAnnotationComposer,
      $$TriviaAnswersTableTableCreateCompanionBuilder,
      $$TriviaAnswersTableTableUpdateCompanionBuilder,
      (TriviaAnswerRow, $$TriviaAnswersTableTableReferences),
      TriviaAnswerRow,
      PrefetchHooks Function({bool resultId})
    >;
typedef $$AchievementsTableTableCreateCompanionBuilder =
    AchievementsTableCompanion Function({
      required String id,
      Value<DateTime> unlockedAt,
      Value<int> rowid,
    });
typedef $$AchievementsTableTableUpdateCompanionBuilder =
    AchievementsTableCompanion Function({
      Value<String> id,
      Value<DateTime> unlockedAt,
      Value<int> rowid,
    });

class $$AchievementsTableTableFilterComposer
    extends Composer<_$AppDatabase, $AchievementsTableTable> {
  $$AchievementsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get unlockedAt => $composableBuilder(
    column: $table.unlockedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AchievementsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $AchievementsTableTable> {
  $$AchievementsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get unlockedAt => $composableBuilder(
    column: $table.unlockedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AchievementsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $AchievementsTableTable> {
  $$AchievementsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get unlockedAt => $composableBuilder(
    column: $table.unlockedAt,
    builder: (column) => column,
  );
}

class $$AchievementsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AchievementsTableTable,
          AchievementRow,
          $$AchievementsTableTableFilterComposer,
          $$AchievementsTableTableOrderingComposer,
          $$AchievementsTableTableAnnotationComposer,
          $$AchievementsTableTableCreateCompanionBuilder,
          $$AchievementsTableTableUpdateCompanionBuilder,
          (
            AchievementRow,
            BaseReferences<
              _$AppDatabase,
              $AchievementsTableTable,
              AchievementRow
            >,
          ),
          AchievementRow,
          PrefetchHooks Function()
        > {
  $$AchievementsTableTableTableManager(
    _$AppDatabase db,
    $AchievementsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AchievementsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AchievementsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AchievementsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> unlockedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AchievementsTableCompanion(
                id: id,
                unlockedAt: unlockedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<DateTime> unlockedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AchievementsTableCompanion.insert(
                id: id,
                unlockedAt: unlockedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AchievementsTableTable, AchievementRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $AchievementsTableTable,
                    AchievementRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AchievementsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AchievementsTableTable,
      AchievementRow,
      $$AchievementsTableTableFilterComposer,
      $$AchievementsTableTableOrderingComposer,
      $$AchievementsTableTableAnnotationComposer,
      $$AchievementsTableTableCreateCompanionBuilder,
      $$AchievementsTableTableUpdateCompanionBuilder,
      (
        AchievementRow,
        BaseReferences<_$AppDatabase, $AchievementsTableTable, AchievementRow>,
      ),
      AchievementRow,
      PrefetchHooks Function()
    >;
typedef $$PreferencesTableTableCreateCompanionBuilder =
    PreferencesTableCompanion Function({
      required String key,
      required String value,
      Value<int> rowid,
    });
typedef $$PreferencesTableTableUpdateCompanionBuilder =
    PreferencesTableCompanion Function({
      Value<String> key,
      Value<String> value,
      Value<int> rowid,
    });

class $$PreferencesTableTableFilterComposer
    extends Composer<_$AppDatabase, $PreferencesTableTable> {
  $$PreferencesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PreferencesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PreferencesTableTable> {
  $$PreferencesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PreferencesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PreferencesTableTable> {
  $$PreferencesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);
}

class $$PreferencesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PreferencesTableTable,
          PreferenceRow,
          $$PreferencesTableTableFilterComposer,
          $$PreferencesTableTableOrderingComposer,
          $$PreferencesTableTableAnnotationComposer,
          $$PreferencesTableTableCreateCompanionBuilder,
          $$PreferencesTableTableUpdateCompanionBuilder,
          (
            PreferenceRow,
            BaseReferences<
              _$AppDatabase,
              $PreferencesTableTable,
              PreferenceRow
            >,
          ),
          PreferenceRow,
          PrefetchHooks Function()
        > {
  $$PreferencesTableTableTableManager(
    _$AppDatabase db,
    $PreferencesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PreferencesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PreferencesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PreferencesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> key = const Value.absent(),
            Value<String> value = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) => PreferencesTableCompanion(key: key, value: value, rowid: rowid),
          createCompanionCallback:
              ({
                required String key,
                required String value,
                Value<int> rowid = const Value.absent(),
              }) => PreferencesTableCompanion.insert(
                key: key,
                value: value,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PreferencesTableTable, PreferenceRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $PreferencesTableTable,
                    PreferenceRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PreferencesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PreferencesTableTable,
      PreferenceRow,
      $$PreferencesTableTableFilterComposer,
      $$PreferencesTableTableOrderingComposer,
      $$PreferencesTableTableAnnotationComposer,
      $$PreferencesTableTableCreateCompanionBuilder,
      $$PreferencesTableTableUpdateCompanionBuilder,
      (
        PreferenceRow,
        BaseReferences<_$AppDatabase, $PreferencesTableTable, PreferenceRow>,
      ),
      PreferenceRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$SyncMetadataTableTableTableManager get syncMetadataTable =>
      $$SyncMetadataTableTableTableManager(_db, _db.syncMetadataTable);
  $$FavoritesTableTableTableManager get favoritesTable =>
      $$FavoritesTableTableTableManager(_db, _db.favoritesTable);
  $$PokemonTableTableTableManager get pokemonTable =>
      $$PokemonTableTableTableManager(_db, _db.pokemonTable);
  $$TypesTableTableTableManager get typesTable =>
      $$TypesTableTableTableManager(_db, _db.typesTable);
  $$PokemonTypesTableTableTableManager get pokemonTypesTable =>
      $$PokemonTypesTableTableTableManager(_db, _db.pokemonTypesTable);
  $$TypeEfficaciesTableTableTableManager get typeEfficaciesTable =>
      $$TypeEfficaciesTableTableTableManager(_db, _db.typeEfficaciesTable);
  $$StatsTableTableTableManager get statsTable =>
      $$StatsTableTableTableManager(_db, _db.statsTable);
  $$PokemonStatsTableTableTableManager get pokemonStatsTable =>
      $$PokemonStatsTableTableTableManager(_db, _db.pokemonStatsTable);
  $$EggGroupsTableTableTableManager get eggGroupsTable =>
      $$EggGroupsTableTableTableManager(_db, _db.eggGroupsTable);
  $$PokemonEggGroupsTableTableTableManager get pokemonEggGroupsTable =>
      $$PokemonEggGroupsTableTableTableManager(_db, _db.pokemonEggGroupsTable);
  $$AbilitiesTableTableTableManager get abilitiesTable =>
      $$AbilitiesTableTableTableManager(_db, _db.abilitiesTable);
  $$PokemonAbilitiesTableTableTableManager get pokemonAbilitiesTable =>
      $$PokemonAbilitiesTableTableTableManager(_db, _db.pokemonAbilitiesTable);
  $$EvolutionSpeciesTableTableTableManager get evolutionSpeciesTable =>
      $$EvolutionSpeciesTableTableTableManager(_db, _db.evolutionSpeciesTable);
  $$EvolutionMethodsTableTableTableManager get evolutionMethodsTable =>
      $$EvolutionMethodsTableTableTableManager(_db, _db.evolutionMethodsTable);
  $$MovesTableTableTableManager get movesTable =>
      $$MovesTableTableTableManager(_db, _db.movesTable);
  $$PokemonMovesTableTableTableManager get pokemonMovesTable =>
      $$PokemonMovesTableTableTableManager(_db, _db.pokemonMovesTable);
  $$TriviaResultsTableTableTableManager get triviaResultsTable =>
      $$TriviaResultsTableTableTableManager(_db, _db.triviaResultsTable);
  $$TriviaAnswersTableTableTableManager get triviaAnswersTable =>
      $$TriviaAnswersTableTableTableManager(_db, _db.triviaAnswersTable);
  $$AchievementsTableTableTableManager get achievementsTable =>
      $$AchievementsTableTableTableManager(_db, _db.achievementsTable);
  $$PreferencesTableTableTableManager get preferencesTable =>
      $$PreferencesTableTableTableManager(_db, _db.preferencesTable);
}
