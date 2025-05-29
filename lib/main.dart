import 'package:core/core.dart';
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
