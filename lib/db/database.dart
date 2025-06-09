import 'package:core/core.dart';
import 'package:realm/realm.dart';

import 'database_config.dart';

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

  Future init() async {
    try {
      _db = Realm(DatabaseConfig.config);

      log('数据库初始化完成: ${getPath()}');
    } on RealmException catch (e, st) {
      handle(e, st);
      rethrow;
    }
  }

  String getPath() {
    return _db.config.path;
  }
}
