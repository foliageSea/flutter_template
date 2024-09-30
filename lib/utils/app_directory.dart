import 'dart:io';

import 'package:flutter_template/global.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class AppDirectory {
  static late final Directory _appDocDir;
  static late final Directory _cacheDir;

  AppDirectory._();

  static ensureInitialized() async {
    try {
      _appDocDir = await getApplicationDocumentsDirectory();
      _cacheDir = await getTemporaryDirectory();
    } catch (_) {}
  }

  static String get getDirectory => join(_appDocDir.path, Global.appName);

  static String get getCacheDirectory => _cacheDir.path;
}
