import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_template/constants/common.dart';
import 'package:flutter_template/langs/translation_service.dart';
import 'package:flutter_template/routes/app_pages.dart';
import 'package:flutter_template/storages/preferences_storage.dart';
import 'package:get/get.dart';

import 'global.dart';
import 'themes.dart';
import 'widgets/splash_screen.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final themeMode = Get.find<PreferencesStorage>().themeMode.val.obs;
  final SplashScreenController _screenController = SplashScreenController();

  @override
  void initState() {
    super.initState();
    Global.initService(_screenController).then((_) {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildScreenUtilInit(
      app: _buildApp(),
    );
  }

  Widget _buildScreenUtilInit({required Widget app}) {
    return ScreenUtilInit(
      designSize: const Size(1080, 1920),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => app,
    );
  }

  Widget _buildApp() {
    return GetMaterialApp(
      title: Global.appName,
      themeMode: themeModeMap[themeMode.value]!,
      theme: Themes.light,
      darkTheme: Themes.dark,
      initialRoute: AppPages.install,
      getPages: AppPages.routes,
      navigatorObservers: [FlutterSmartDialog.observer],
      builder: _builder,
      debugShowCheckedModeBanner: false,
      translations: TranslationService(),
      locale: TranslationService.locale,
      fallbackLocale: TranslationService.fallbackLocale,
      localizationsDelegates: TranslationService.localizationsDelegates,
      supportedLocales: TranslationService.supportedLocales,
    );
  }

  Widget _builder(BuildContext context, Widget? child) {
    // 渲染结构: ScreenUtilInit->GetMaterialApp->MediaQuery->FlutterSmartDialog
    final c = FlutterSmartDialog.init(
      builder: (context, child) {
        return child!;
      },
    )(context, child);

    return MediaQuery(
      /// 设置文字大小不随系统设置改变
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: SplashScreen(controller: _screenController, child: c),
    );
  }
}
