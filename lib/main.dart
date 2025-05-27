import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:get/get.dart';
import 'app/common/global.dart';
import 'app/common/theme.dart';
import 'app/routes/app_pages.dart';
import 'app/widgets/error_app.dart';

void main() async {
  try {
    await Global.init();
    runApp(const MainApp());
  } catch (e) {
    runApp(ErrorApp(error: e));
  }
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: '${Global.appName} ${Global.appVersion}',
      initialRoute: AppPages.initial,
      getPages: AppPages.getRoutes(),
      debugShowCheckedModeBanner: false,
      theme: AppTheme.getThemeData(),
      supportedLocales: const [
        Locale('zh', 'CN'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
