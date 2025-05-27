import 'package:core/core.dart';
import 'package:flutter/widgets.dart';

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

    NotificationsUtil().init();
    await PackageInfoUtil().init();
    await DeviceInfoUtil().init();
    appVersion = PackageInfoUtil().getVersion();

    AppLogger().info('应用初始化完成');
  }
}
