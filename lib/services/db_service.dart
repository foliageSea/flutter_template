import 'package:flutter_template/logs/log.dart';
import 'package:flutter_template/models/user.dart';
import 'package:flutter_template/utils/app_directory.dart';
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

      talker.info('数据库初始化成功 路径: $path');
    } catch (e) {}

    return this;
  }
}
