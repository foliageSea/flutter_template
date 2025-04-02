import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_template/global.dart';
import 'package:flutter_template/router/get_router.dart';
import 'package:get/get.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    AccentColor color = Colors.red;

    return GetMaterialApp(
      title: Global.appName,
      debugShowCheckedModeBanner: false,
      getPages: AppPages.routes,
      builder: (context, child) {
        return FluentApp(
          themeMode: ThemeMode.dark,
          color: color,
          darkTheme: FluentThemeData(
            brightness: Brightness.dark,
            accentColor: color,
            visualDensity: VisualDensity.standard,
            focusTheme: FocusThemeData(
              glowFactor: is10footScreen(context) ? 2.0 : 0.0,
            ),
          ),
          theme: FluentThemeData(
            accentColor: color,
            visualDensity: VisualDensity.standard,
            focusTheme: FocusThemeData(
              glowFactor: is10footScreen(context) ? 2.0 : 0.0,
            ),
          ),
          debugShowCheckedModeBanner: false,
          builder: (context, c) => NavigationPaneTheme(
            data: const NavigationPaneThemeData(),
            child: child!,
          ),
        );
      },
    );
  }
}
