import 'package:core/core.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_template/app/controllers/controllers.dart';
import 'package:flutter_template/app/locales/locales.dart';
import 'package:flutter_template/db/database.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

class Global {
  static const String appName = "flutter_template";
  static String appVersion = "1.0.0";
  static final GetIt getIt = GetIt.instance;

  Global._();

  static void info(dynamic msg, [Object? exception, StackTrace? stackTrace]) {
    AppLogger().info(msg, exception, stackTrace);
  }

  static List<CommonInitialize> getInitializes() {
    return [
      Storage(),
      Request(),
      PackageInfoUtil(),
      Locales(),
    ];
  }

  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();

    List<CommonInitialize> initializes = getInitializes();

    info('应用开始初始化');
    for (var initialize in initializes) {
      await initialize.init();
      info(initialize.getOutput());
    }
    initAppVersion();
    await initDatabase();
    registerServices();

    info('应用初始化完成');
  }

  static void registerServices() {
    var themeController = Get.put(ThemeController());
    themeController.init();
    Get.put(UserController());
  }

  static Future initDatabase() async {
    getIt.registerSingleton(AppDatabase());
    await getIt<AppDatabase>().init(getIt);
  }

  static initAppVersion() {
    appVersion = PackageInfoUtil().getVersion();
  }
}
