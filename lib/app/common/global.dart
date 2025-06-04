import 'package:core/core.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_template/app/controllers/controllers.dart';
import 'package:flutter_template/db/database.dart';
import 'package:get/get.dart';

class Global {
  static const String appName = "flutter_template";
  static String appVersion = "1.0.0";

  Global._();

  static void info(dynamic msg, [Object? exception, StackTrace? stackTrace]) {
    AppLogger().info(msg, exception, stackTrace);
  }

  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    AppLogger().init();
    info('应用初始化开始');
    await Storage().init();
    Request().init();
    await initDatabase();

    await NotificationsUtil.getInstance().init();
    await PackageInfoUtil().init();
    initAppVersion();
    await DeviceInfoUtil.getInstance().init();
    registerServices();
    info('应用初始化完成');
  }

  static void registerServices() {
    var themeController = Get.put(ThemeController());
    themeController.initTheme();
    Get.put(UserController());
  }

  static Future initDatabase() async {
    await AppDatabase().init();
  }

  static initAppVersion() {
    appVersion = PackageInfoUtil().getVersion();
  }
}
