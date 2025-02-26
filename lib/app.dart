import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/global.dart';
import 'package:flutter_template/routes/routes.dart';
import 'package:flutter_template/states/theme.dart';

class MainApp extends ConsumerStatefulWidget {
  const MainApp({super.key});

  @override
  ConsumerState createState() => _MainAppState();
}

class _MainAppState extends ConsumerState<MainApp> {
  @override
  Widget build(BuildContext context) {
    var themeMode = ref.watch(themeProvider);
    return MaterialApp.router(
      title: Global.appName,
      routerConfig: router,
      themeMode: themeMode,
      theme: Themes.light,
      darkTheme: Themes.dark,
      builder: (BuildContext context, Widget? child) {
        return EagerInitialization(
          child: child ?? Container(),
        );
      },
    );
  }
}

class Themes {
  // Light
  static final light = FlexThemeData.light(scheme: FlexScheme.aquaBlue);

  // Dark
  static final dark = FlexThemeData.dark(scheme: FlexScheme.aquaBlue);
}
