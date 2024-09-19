import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_template/constants/common.dart';
import 'package:flutter_template/global.dart';
import 'package:flutter_template/langs/translation_service.dart';
import 'package:flutter_template/routes/app_pages.dart';
import 'package:flutter_template/storages/preferences_storage.dart';
import 'package:get/get.dart';

import 'themes.dart';

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
  final themeMode = Get.find<PreferencesStorage>().themeMode.val.obs;

  @override
  void initState() {
    super.initState();
    Global.initService().then((_) {});
  }

  Widget _renderSplashScreen(Widget child) {
    return child;
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
      ),
    );
  }
}
