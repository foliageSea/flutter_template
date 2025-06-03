// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db.dart';

// ignore_for_file: type=lint
class $ServerEntityTable extends ServerEntity
    with TableInfo<$ServerEntityTable, ServerEntityData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ServerEntityTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _urlMeta = const VerificationMeta('url');
  @override
  late final GeneratedColumn<String> url = GeneratedColumn<String>(
      'url', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<int> type = GeneratedColumn<int>(
      'type', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _usernameMeta =
      const VerificationMeta('username');
  @override
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
      'username', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _passwordMeta =
      const VerificationMeta('password');
  @override
  late final GeneratedColumn<String> password = GeneratedColumn<String>(
      'password', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, url, type, username, password];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'server';
  @override
  VerificationContext validateIntegrity(Insertable<ServerEntityData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('url')) {
      context.handle(
          _urlMeta, url.isAcceptableOrUnknown(data['url']!, _urlMeta));
    } else if (isInserting) {
      context.missing(_urlMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('username')) {
      context.handle(_usernameMeta,
          username.isAcceptableOrUnknown(data['username']!, _usernameMeta));
    } else if (isInserting) {
      context.missing(_usernameMeta);
    }
    if (data.containsKey('password')) {
      context.handle(_passwordMeta,
          password.isAcceptableOrUnknown(data['password']!, _passwordMeta));
    } else if (isInserting) {
      context.missing(_passwordMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ServerEntityData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ServerEntityData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      url: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}url'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}type'])!,
      username: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}username'])!,
      password: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}password'])!,
    );
  }

  @override
  $ServerEntityTable createAlias(String alias) {
    return $ServerEntityTable(attachedDatabase, alias);
  }
}

class ServerEntityData extends DataClass
    implements Insertable<ServerEntityData> {
  final int id;
  final String url;
  final int type;
  final String username;
  final String password;
  const ServerEntityData(
      {required this.id,
      required this.url,
      required this.type,
      required this.username,
      required this.password});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['url'] = Variable<String>(url);
    map['type'] = Variable<int>(type);
    map['username'] = Variable<String>(username);
    map['password'] = Variable<String>(password);
    return map;
  }

  ServerEntityCompanion toCompanion(bool nullToAbsent) {
    return ServerEntityCompanion(
      id: Value(id),
      url: Value(url),
      type: Value(type),
      username: Value(username),
      password: Value(password),
    );
  }

  factory ServerEntityData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ServerEntityData(
      id: serializer.fromJson<int>(json['id']),
      url: serializer.fromJson<String>(json['url']),
      type: serializer.fromJson<int>(json['type']),
      username: serializer.fromJson<String>(json['username']),
      password: serializer.fromJson<String>(json['password']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'url': serializer.toJson<String>(url),
      'type': serializer.toJson<int>(type),
      'username': serializer.toJson<String>(username),
      'password': serializer.toJson<String>(password),
    };
  }

  ServerEntityData copyWith(
          {int? id,
          String? url,
          int? type,
          String? username,
          String? password}) =>
      ServerEntityData(
        id: id ?? this.id,
        url: url ?? this.url,
        type: type ?? this.type,
        username: username ?? this.username,
        password: password ?? this.password,
      );
  ServerEntityData copyWithCompanion(ServerEntityCompanion data) {
    return ServerEntityData(
      id: data.id.present ? data.id.value : this.id,
      url: data.url.present ? data.url.value : this.url,
      type: data.type.present ? data.type.value : this.type,
      username: data.username.present ? data.username.value : this.username,
      password: data.password.present ? data.password.value : this.password,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ServerEntityData(')
          ..write('id: $id, ')
          ..write('url: $url, ')
          ..write('type: $type, ')
          ..write('username: $username, ')
          ..write('password: $password')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, url, type, username, password);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ServerEntityData &&
          other.id == this.id &&
          other.url == this.url &&
          other.type == this.type &&
          other.username == this.username &&
          other.password == this.password);
}

class ServerEntityCompanion extends UpdateCompanion<ServerEntityData> {
  final Value<int> id;
  final Value<String> url;
  final Value<int> type;
  final Value<String> username;
  final Value<String> password;
  const ServerEntityCompanion({
    this.id = const Value.absent(),
    this.url = const Value.absent(),
    this.type = const Value.absent(),
    this.username = const Value.absent(),
    this.password = const Value.absent(),
  });
  ServerEntityCompanion.insert({
    this.id = const Value.absent(),
    required String url,
    required int type,
    required String username,
    required String password,
  })  : url = Value(url),
        type = Value(type),
        username = Value(username),
        password = Value(password);
  static Insertable<ServerEntityData> custom({
    Expression<int>? id,
    Expression<String>? url,
    Expression<int>? type,
    Expression<String>? username,
    Expression<String>? password,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (url != null) 'url': url,
      if (type != null) 'type': type,
      if (username != null) 'username': username,
      if (password != null) 'password': password,
    });
  }

  ServerEntityCompanion copyWith(
      {Value<int>? id,
      Value<String>? url,
      Value<int>? type,
      Value<String>? username,
      Value<String>? password}) {
    return ServerEntityCompanion(
      id: id ?? this.id,
      url: url ?? this.url,
      type: type ?? this.type,
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    if (type.present) {
      map['type'] = Variable<int>(type.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (password.present) {
      map['password'] = Variable<String>(password.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ServerEntityCompanion(')
          ..write('id: $id, ')
          ..write('url: $url, ')
          ..write('type: $type, ')
          ..write('username: $username, ')
          ..write('password: $password')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ServerEntityTable serverEntity = $ServerEntityTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [serverEntity];
}

typedef $$ServerEntityTableCreateCompanionBuilder = ServerEntityCompanion
    Function({
  Value<int> id,
  required String url,
  required int type,
  required String username,
  required String password,
});
typedef $$ServerEntityTableUpdateCompanionBuilder = ServerEntityCompanion
    Function({
  Value<int> id,
  Value<String> url,
  Value<int> type,
  Value<String> username,
  Value<String> password,
});

class $$ServerEntityTableFilterComposer
    extends Composer<_$AppDatabase, $ServerEntityTable> {
  $$ServerEntityTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get url => $composableBuilder(
      column: $table.url, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get username => $composableBuilder(
      column: $table.username, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get password => $composableBuilder(
      column: $table.password, builder: (column) => ColumnFilters(column));
}

class $$ServerEntityTableOrderingComposer
    extends Composer<_$AppDatabase, $ServerEntityTable> {
  $$ServerEntityTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get url => $composableBuilder(
      column: $table.url, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get username => $composableBuilder(
      column: $table.username, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get password => $composableBuilder(
      column: $table.password, builder: (column) => ColumnOrderings(column));
}

class $$ServerEntityTableAnnotationComposer
    extends Composer<_$AppDatabase, $ServerEntityTable> {
  $$ServerEntityTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get url =>
      $composableBuilder(column: $table.url, builder: (column) => column);

  GeneratedColumn<int> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get username =>
      $composableBuilder(column: $table.username, builder: (column) => column);

  GeneratedColumn<String> get password =>
      $composableBuilder(column: $table.password, builder: (column) => column);
}

class $$ServerEntityTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ServerEntityTable,
    ServerEntityData,
    $$ServerEntityTableFilterComposer,
    $$ServerEntityTableOrderingComposer,
    $$ServerEntityTableAnnotationComposer,
    $$ServerEntityTableCreateCompanionBuilder,
    $$ServerEntityTableUpdateCompanionBuilder,
    (
      ServerEntityData,
      BaseReferences<_$AppDatabase, $ServerEntityTable, ServerEntityData>
    ),
    ServerEntityData,
    PrefetchHooks Function()> {
  $$ServerEntityTableTableManager(_$AppDatabase db, $ServerEntityTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ServerEntityTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ServerEntityTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ServerEntityTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> url = const Value.absent(),
            Value<int> type = const Value.absent(),
            Value<String> username = const Value.absent(),
            Value<String> password = const Value.absent(),
          }) =>
              ServerEntityCompanion(
            id: id,
            url: url,
            type: type,
            username: username,
            password: password,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String url,
            required int type,
            required String username,
            required String password,
          }) =>
              ServerEntityCompanion.insert(
            id: id,
            url: url,
            type: type,
            username: username,
            password: password,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ServerEntityTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ServerEntityTable,
    ServerEntityData,
    $$ServerEntityTableFilterComposer,
    $$ServerEntityTableOrderingComposer,
    $$ServerEntityTableAnnotationComposer,
    $$ServerEntityTableCreateCompanionBuilder,
    $$ServerEntityTableUpdateCompanionBuilder,
    (
      ServerEntityData,
      BaseReferences<_$AppDatabase, $ServerEntityTable, ServerEntityData>
    ),
    ServerEntityData,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ServerEntityTableTableManager get serverEntity =>
      $$ServerEntityTableTableManager(_db, _db.serverEntity);
}
