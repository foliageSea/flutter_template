import 'package:core/core.dart';
import 'package:flutter_template/db/services/server_service.dart';
import 'package:get_it/get_it.dart';
import 'package:realm/realm.dart';

import '../app/common/global.dart';
import 'database_config.dart';

/// 文档地址
/// https://www.mongodb.com/zh-cn/docs/atlas/device-sdks/sdk/flutter/
class AppDatabase with AppLogMixin {
  late Realm _db;

  Realm get db => _db;

  late GetIt getIt;

  Future init(GetIt getIt) async {
    this.getIt = getIt;
    try {
      _db = Realm(DatabaseConfig.config);
      log('数据库初始化完成: ${getPath()}');
      register();
    } on RealmException catch (e, st) {
      handle(e, st);
      rethrow;
    }
  }

  String getPath() {
    return _db.config.path;
  }

  void register() {
    getIt.registerSingleton<ServerService>(ServerServiceImpl());
  }
}

mixin AppDatabaseMixin {
  Realm db = Global.getIt<AppDatabase>().db;
}
