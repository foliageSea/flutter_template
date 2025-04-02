import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_template/global.dart';
import 'package:flutter_template/router/router.dart';
import 'package:get/get.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    AccentColor color = Colors.red;

    return GetMaterialApp(
      title: Global.appName,
      debugShowCheckedModeBanner: false,
      home: FluentApp.router(
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
        // routerConfig: router,
        routeInformationParser: router.routeInformationParser,
        routerDelegate: router.routerDelegate,
        routeInformationProvider: router.routeInformationProvider,
        debugShowCheckedModeBanner: false,
        builder: (context, c) => NavigationPaneTheme(
          data: const NavigationPaneThemeData(),
          child: c!,
        ),
      ),
    );
  }
}
