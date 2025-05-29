import 'package:core/core.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_template/app/controllers/controllers.dart';
import 'package:get/get.dart';

class Global {
  static const String appName = "flutter_template";
  static String appVersion = "1.0.0";

  Global._();

  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    AppLogger().init();
    AppLogger().info('应用初始化开始');
    await Storage().init();
    Request().init();

    await NotificationsUtil().init();
    await PackageInfoUtil().init();
    await DeviceInfoUtil().init();
    appVersion = PackageInfoUtil().getVersion();
    registerServices();
    AppLogger().info('应用初始化完成');
  }

  static void registerServices() {
    Get.put(UserController());
  }
}
