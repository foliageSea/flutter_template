import 'package:core/core.dart';
import 'package:realm/realm.dart';

import '../app/common/global.dart';
import 'database_config.dart';
import 'services/impl/server_service_impl.dart';
import 'services/server_service.dart';

/// 文档地址
/// https://www.mongodb.com/zh-cn/docs/atlas/device-sdks/sdk/flutter/
class AppDatabase with AppLogMixin {
  late Realm _db;

  Realm get db => _db;

  Future init() async {
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
    Global.getIt.registerSingleton<ServerService>(ServerServiceImpl());
  }
}

mixin AppDatabaseMixin {
  Realm db = Global.getIt<AppDatabase>().db;
}
