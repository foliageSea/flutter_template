import 'package:flutter/material.dart';
import 'package:flutter_template/core/logger/logger.dart';
import 'package:flutter_template/core/request/request.dart';
import 'package:flutter_template/core/storage/storage.dart';
import 'package:flutter_template/core/storage/storage_keys.dart';

class Global {
  static String appName = "Flutter Template";
  static String appVersion = "1.0.0";

  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    AppLogger().init();
    AppLogger().info('应用初始化开始');
    await Storage().init();
    Request().init();
    loadBaseUrl();
    AppLogger().info('应用初始化完成');
  }

  static void loadBaseUrl() {
    var baseUrl = Storage().get(StorageKeys.url) ?? '';
    if (baseUrl.isEmpty) {
      AppLogger().warning('baseUrl 为空');
      return;
    }
    Request().setBaseUrl(baseUrl);
    AppLogger().log('baseUrl: $baseUrl');
  }
}
