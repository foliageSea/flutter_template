import 'dart:io';

import 'android_platform.dart';
import 'windows_platform.dart';

abstract class PlatformInterface {
  Future<dynamic> initApp();

  static PlatformInterface getInstance() {
    if (Platform.isWindows) {
      return WindowsPlatform();
    }
    return AndroidPlatform();
  }
}
