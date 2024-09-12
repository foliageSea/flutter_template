import 'package:flutter_template/logs/log.dart';
import 'package:flutter_template/models/user.dart';
import 'package:fs_widgets/utils/app_directory.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';

class DbService extends GetxService {
  late final Isar database;

  Future<DbService> init() async {
    try {
      final path = AppDirectory.getDirectory;

      database = await Isar.open(
        [UserSchema],
        directory: path,
      );

      talker.info('数据库初始化成功');
    } catch (e) {
      talker.handle(e, null, '数据库初始化失败');
    }

    return this;
  }
}
