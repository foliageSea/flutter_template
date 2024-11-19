import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_template/db/entity/log_entity.dart';
import 'package:flutter_template/utils/app_directory.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';

class DbService extends GetxService {
  late final Isar isar;

  static DbService get to => Get.find();

  /// 初始化数据库Schema
  static var schemas = [
    LogEntitySchema,
  ];

  Future<DbService> init() async {
    try {
      final path = AppDirectory.getDirectory;

      var directory = Directory(path);

      if (!directory.existsSync()) {
        await directory.create(recursive: true);
      }

      isar = await Isar.open(
        schemas,
        directory: path,
        name: 'db',
      );
    } catch (e, st) {
      debugPrintStack(label: e.toString(), stackTrace: st);
    }

    return this;
  }
}
