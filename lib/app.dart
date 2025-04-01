import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_template/global.dart';
import 'package:flutter_template/router/routesr.dart';
import 'package:get/get.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: Global.appName,
      debugShowCheckedModeBanner: false,
      home: FluentApp.router(
        debugShowCheckedModeBanner: false,
        builder: (context, c) => NavigationPaneTheme(
          data: const NavigationPaneThemeData(),
          child: c!,
        ),
        routerConfig: router,
      ),
    );
  }
}
