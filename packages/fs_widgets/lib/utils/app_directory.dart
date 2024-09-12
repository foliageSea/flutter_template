import 'dart:io';

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

  static String get getDirectory => _appDocDir.path;

  static String get getCacheDirectory => _cacheDir.path;
}
