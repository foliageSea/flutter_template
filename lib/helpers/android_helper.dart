import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AndroidHelper {
  AndroidHelper._();

  // 沉浸式StatusBar
  static void initStatusBar() {
    SystemUiOverlayStyle systemUiOverlayStyle =
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }

  // 沉浸式NavigationBar,StatusBar(全面屏适配, 不支持虚拟NavigationBar)
  static void initNavigationBar() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
      statusBarColor: Colors.transparent,
    ));
  }
}
