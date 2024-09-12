import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ScreenOrientationHelper {
  ScreenOrientationHelper._();

  /// 获取屏幕方向
  static Orientation getScreenOrientation(BuildContext context) {
    return MediaQuery.of(context).orientation;
  }

  /// 强制横屏
  static void focusLandscape() {
    if (!Platform.isAndroid) return;

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  /// 强制竖屏
  static void focusPortrait() {
    if (!Platform.isAndroid) return;

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  /// 自动旋转
  static void autoRotate() {
    if (!Platform.isAndroid) return;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
}
