import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_template/db/entity/server_entity.dart';
import 'package:realm/realm.dart';

/// 文档地址
/// https://www.mongodb.com/zh-cn/docs/atlas/device-sdks/sdk/flutter/
class AppDatabase with AppLogMixin {
  static AppDatabase? _appDatabase;

  AppDatabase._();

  factory AppDatabase() {
    _appDatabase ??= AppDatabase._();
    return _appDatabase!;
  }

  late Realm _db;

  Realm get db => _db;

  static int schemaVersion = 1;

  final List<SchemaObject> schemaObjects = [
    ServerEntity.schema,
  ];

  Future init() async {
    try {
      var shouldDeleteIfMigrationNeeded = kReleaseMode ? false : true;
      var config = Configuration.local(
        schemaObjects,
        schemaVersion: schemaVersion,
        migrationCallback: migrationCallback,
        shouldDeleteIfMigrationNeeded: shouldDeleteIfMigrationNeeded,
      );
      _db = Realm(config);
      var path = _db.config.path;
      log('数据库初始化完成 path: $path');
    } on RealmException catch (e, st) {
      handle(e, st);
      rethrow;
    }
  }

  void migrationCallback(Migration migration, int oldSchemaVersion) {}
}
