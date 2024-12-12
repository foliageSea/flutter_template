import 'package:flutter_template/db/entity/log_entity.dart';
import 'package:flutter_template/services/db_service.dart';
import 'package:isar/isar.dart';

import 'dao_interface.dart';

class LogDao extends DaoInterface {
  static LogDao? _instance;

  LogDao._internal();

  factory LogDao() {
    _instance ??= LogDao._internal();
    return _instance!;
  }

  Future<int> add(LogEntity log) async {
    return db.writeTxn<int>(() {
      return db.logEntitys.put(log);
    });
  }

  static Future watch() async {
    var db = DbService.to.isar;
    var stream = db.logEntitys.watchLazy();
    stream.listen((_) async {
      try {
        _clearOldLogs(db, maxRecord: 100);
      } catch (_) {}
    });
  }

  static Future<void> _clearOldLogs(Isar db, {required int maxRecord}) async {
    await db.writeTxn(() async {
      var logs = await db.logEntitys.where().sortByUpdate().findAll();

      if (logs.length <= maxRecord) {
        return;
      }

      var oldestLogs = await db.logEntitys
          .where()
          .sortByUpdate()
          .limit((maxRecord / 2).ceil())
          .findAll();

      await db.logEntitys.deleteAll(oldestLogs.map((e) => e.id).toList());
    });
  }
}
