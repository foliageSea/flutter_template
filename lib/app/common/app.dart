import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/app/controllers/src/theme_controller.dart';
import 'package:flutter_template/app/locales/locales.dart';
import 'package:get/get.dart';

import '../routes/app_pages.dart';
import 'global.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> with AppLogMixin {
  @override
  void initState() {
    super.initState();

    PermissionUtil().requestPermissions().catchError((e, st) {
      handle(e, st);
    });
  }

  @override
  Widget build(BuildContext context) {
    var themeController = Get.find<ThemeController>();
    var locales = Locales();
    return GetMaterialApp(
      title: '${Global.appName} ${Global.appVersion}',
      initialRoute: AppPages.initial,
      getPages: AppPages.getRoutes(),
      debugShowCheckedModeBanner: false,
      themeMode: themeController.getThemeMode(),
      theme: themeController.getThemeData(),
      darkTheme: themeController.getDarkThemeData(),
      translations: locales,
      supportedLocales: locales.getSupportedLocales(),
      localizationsDelegates: locales.localizationsDelegates,
      builder: AppMessage().init(),
    );
  }
}
