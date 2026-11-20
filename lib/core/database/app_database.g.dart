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
  late final $StatsTableTable statsTable = $StatsTableTable(this);
  late final $PokemonStatsTableTable pokemonStatsTable =
      $PokemonStatsTableTable(this);
  late final $EggGroupsTableTable eggGroupsTable = $EggGroupsTableTable(this);
  late final $PokemonEggGroupsTableTable pokemonEggGroupsTable =
      $PokemonEggGroupsTableTable(this);
  late final $AbilitiesTableTable abilitiesTable = $AbilitiesTableTable(this);
  late final $PokemonAbilitiesTableTable pokemonAbilitiesTable =
      $PokemonAbilitiesTableTable(this);
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
    statsTable,
    pokemonStatsTable,
    eggGroupsTable,
    pokemonEggGroupsTable,
    abilitiesTable,
    pokemonAbilitiesTable,
    pokemonNameIdx,
    pokemonDexNumberIdx,
    pokemonGenIdx,
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
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (pokemonTypesTableRefs) db.pokemonTypesTable,
                    if (pokemonStatsTableRefs) db.pokemonStatsTable,
                    if (pokemonEggGroupsTableRefs) db.pokemonEggGroupsTable,
                    if (pokemonAbilitiesTableRefs) db.pokemonAbilitiesTable,
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
          PrefetchHooks Function({bool pokemonTypesTableRefs})
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
          prefetchHooksCallback: ({pokemonTypesTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (pokemonTypesTableRefs) db.pokemonTypesTable,
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
      PrefetchHooks Function({bool pokemonTypesTableRefs})
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
}
