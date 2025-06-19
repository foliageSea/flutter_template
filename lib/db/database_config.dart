import 'package:flutter/foundation.dart';
import 'package:realm/realm.dart';
import 'models/server_model.dart';

class DatabaseConfig {
  static const schemaVersion = 3;

  static List<SchemaObject> schemaObjects = [
    ServerModel.schema,
  ];

  static Configuration get config => Configuration.local(
        schemaObjects,
        schemaVersion: schemaVersion,
        migrationCallback: _migrate,
        shouldDeleteIfMigrationNeeded: kReleaseMode ? false : true,
      );

  static void _migrate(Migration migration, int oldSchemaVersion) {
    // 迁移逻辑
  }

  static Configuration getConfigWithPath(String path) {
    return Configuration.local(
      schemaObjects,
      schemaVersion: schemaVersion,
      migrationCallback: _migrate,
      shouldDeleteIfMigrationNeeded: kReleaseMode ? false : true,
      path: path,
    );
  }
}
