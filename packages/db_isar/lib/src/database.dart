import 'dart:io';

import 'package:core/core.dart';
import 'package:isar/isar.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'database_config.dart';

class AppDatabase with AppLogMixin {
  static AppDatabase? _appDatabase;

  AppDatabase._();

  factory AppDatabase() {
    _appDatabase ??= AppDatabase._();
    return _appDatabase!;
  }

  late Isar db;

  Future init({String? appName}) async {
    var path = await getPath(appName: appName);

    db = await Isar.open(
      DatabaseConfig.schemas,
      directory: path,
    );
    log('Isar数据库路径: $path');
  }

  Future<String> getPath({String? appName}) async {
    final dir = await getApplicationDocumentsDirectory();
    late String path;
    if (appName != null) {
      path = join(dir.path, appName);
      if (!await Directory(path).exists()) {
        await Directory(path).create(recursive: true);
      }
    } else {
      path = dir.path;
    }
    return path;
  }
}
