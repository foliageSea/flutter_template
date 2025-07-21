import 'package:core/core.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_template/app/controllers/controllers.dart';
import 'package:flutter_template/app/locales/locales.dart';
import 'package:flutter_template/db/database.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'global.config.dart';

// 文档: https://pub.dev/packages/injectable
@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
)
Future configureDependencies() async {
  Global.getIt.init();
  await Global.getIt<AppDatabase>().init();
}

class Global {
  static const String appName = "flutter_template";
  static String appVersion = "1.0.0";
  static final GetIt getIt = GetIt.instance;
  static final AppLogger logger = AppLogger();

  Global._();

  static List<CommonInitialize Function()> getInitializes() {
    return [
      () => Storage(),
      () => Request(),
      () => PackageInfoUtil(),
      () => Locales(),
    ];
  }

  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();

    FlutterError.onError = (details) {
      FlutterError.presentError(details);
      var e = details.exception;
      var st = details.stack;
      AppLogger().handle(e, st);
    };

    logger.info('应用开始初始化');
    await initCommon();
    initAppVersion();
    registerServices();
    await configureDependencies();
    logger.info('应用初始化完成');
  }

  static Future initCommon() async {
    List<CommonInitialize Function()> initializes = getInitializes();
    for (var initialize in initializes) {
      var instance = initialize();
      await instance.init();
      logger.info(instance.getOutput());
    }
  }

  static void registerServices() {
    var themeController = Get.put(ThemeController());
    themeController.init();
  }

  static initAppVersion() {
    appVersion = PackageInfoUtil().getVersion();
  }
}
