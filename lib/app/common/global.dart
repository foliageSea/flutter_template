import 'package:core/core.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_template/app/controllers/controllers.dart';
import 'package:flutter_template/db/db.dart';
import 'package:get/get.dart';

class Global {
  static const String appName = "flutter_template";
  static String appVersion = "1.0.0";
  static late AppDatabase db;

  Global._();

  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    AppLogger().init();
    AppLogger().info('应用初始化开始');
    await Storage().init();
    Request().init();
    await initDatabase();

    await NotificationsUtil.getInstance().init();
    await PackageInfoUtil().init();
    await DeviceInfoUtil.getInstance().init();
    appVersion = PackageInfoUtil().getVersion();
    registerServices();
    AppLogger().info('应用初始化完成');
  }

  static void registerServices() {
    Get.put(UserController());
  }

  static Future initDatabase() async {
    db = AppDatabase();
    var directory = await AppDatabase.getDatabaseDirectory();
    AppLogger().info('数据库目录: $directory');
  }
}
