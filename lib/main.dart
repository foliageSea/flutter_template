import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_template/app/controllers/controllers.dart';

import 'package:get/get.dart';
import 'app/common/global.dart';
import 'app/routes/app_pages.dart';

void main() async {
  try {
    await Global.init();
    runApp(const MainApp());
  } catch (e, st) {
    runApp(
      ErrorApp(
        error: e,
        stackTrace: st,
      ),
    );
  }
}

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

    return GetMaterialApp(
      title: '${Global.appName} ${Global.appVersion}',
      initialRoute: AppPages.initial,
      getPages: AppPages.getRoutes(),
      debugShowCheckedModeBanner: false,
      themeMode: themeController.getThemeMode(),
      theme: themeController.getThemeData(),
      darkTheme: themeController.getDarkThemeData(),
      supportedLocales: const [
        Locale('zh', 'CN'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      builder: AppMessage().init(),
    );
  }
}
