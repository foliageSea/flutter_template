import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Themes {
  // Light
  static final light = FlexThemeData.light(
    scheme: FlexScheme.flutterDash,
    primary: const Color(0xFF7778dc),
    secondary: const Color(0xFF81aad3),
    fontFamily: "Microsoft YaHei",
    useMaterial3: true,
  ).copyWith(
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    splashFactory: NoSplash.splashFactory,
  );

  // Dark
  static final dark = FlexThemeData.dark(
    scheme: FlexScheme.flutterDash,
    primary: const Color(0xFF7778dc),
    secondary: const Color(0xFF81aad3),
    fontFamily: "Microsoft YaHei",
    useMaterial3: true,
  ).copyWith(
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    splashFactory: NoSplash.splashFactory,
    cupertinoOverrideTheme: const CupertinoThemeData(
      textTheme: CupertinoTextThemeData(),
    ),
  );
}

class ThemeColor {
  BuildContext context;

  ThemeColor(this.context);

  Color get primaryColor => Theme.of(context).colorScheme.primary;

  Color get secondaryColor => Theme.of(context).colorScheme.secondary;

  Color get textColor => Theme.of(context).colorScheme.scrim;
}
