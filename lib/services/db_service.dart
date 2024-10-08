import 'dart:io';

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

      var directory = Directory(path);

      if (!directory.existsSync()) {
        await directory.create(recursive: true);
      }

      database = await Isar.open(
        [UserSchema],
        directory: path,
        name: 'db',
      );

      talker.info('数据库初始化成功');
    } catch (e) {
      talker.handle(e, null, '数据库初始化失败');
    }

    return this;
  }
}
