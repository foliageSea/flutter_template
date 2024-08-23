import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_template/constants/common.dart';
import 'package:flutter_template/events/events.dart';
import 'package:flutter_template/global.dart';
import 'package:flutter_template/langs/translation_service.dart';
import 'package:flutter_template/routes/app_pages.dart';
import 'package:flutter_template/storages/preferences_storage.dart';
import 'package:flutter_template/themes/color_schemes.dart';
import 'package:get/get.dart';

import 'fs_widgets/fs_widgets.dart';

void main() {
  Global.initApp().then(
    (value) => runApp(
      Phoenix(
        child: const MainApp(),
      ),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final splashScreenStatus = false.obs;
  late FsSplashScreenController splashScreenController;
  final themeMode = Get.find<PreferencesStorage>().themeMode.val.obs;

  void setSplashScreenStatus(bool status) {
    splashScreenStatus.value = status;
    splashScreenStatus.refresh();
  }

  @override
  void initState() {
    super.initState();
    splashScreenController = FsSplashScreenController();
    Global.initService(
      setSplashScreenStatus,
      splashScreenController,
      rec: true,
    );

    eventBus.on<ShowToastEvent>().listen((event) {
      SmartDialog.showToast(event.msg);
    });
  }

  Widget _renderSplashScreen(Widget child) {
    return Obx(
      () => FsSplashScreen(
        controller: splashScreenController,
        loading: splashScreenStatus.value,
        child: child,
      ),
    );
  }

  Widget _builder(BuildContext context, Widget? child) {
    // 渲染结构: ScreenUtilInit->GetMaterialApp->MediaQuery->FlutterSmartDialog->_renderLoading
    final c = FlutterSmartDialog.init(
      builder: (context, child) {
        return _renderSplashScreen(child!);
      },
    )(context, child);

    return MediaQuery(
      /// 设置文字大小不随系统设置改变
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: c,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1080, 1920),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => GetMaterialApp(
        title: 'Flutter Template',
        themeMode: themeModeMap[themeMode.value]!,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorSchemes.lightColorScheme,
          fontFamily: "Microsoft YaHei",
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorSchemes.darkColorScheme,
          fontFamily: "Microsoft YaHei",
        ),
        // theme: FlexThemeData.light(scheme: FlexScheme.blueM3),
        // darkTheme: FlexThemeData.dark(scheme: FlexScheme.blueM3),
        // Use dark or light theme based on system setting.
        initialRoute: AppPages.install,
        getPages: AppPages.routes,
        navigatorObservers: [FlutterSmartDialog.observer],
        builder: _builder,
        translations: TranslationService(),
        locale: TranslationService.locale,
        fallbackLocale: TranslationService.fallbackLocale,
        localizationsDelegates: TranslationService.localizationsDelegates,
        supportedLocales: TranslationService.supportedLocales,
      ),
    );
  }
}
