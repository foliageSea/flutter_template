import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

class Themes {
  // Light
  static final light = FlexThemeData.light(scheme: FlexScheme.mandyRed);

  // Dark
  static final dark = FlexThemeData.dark(scheme: FlexScheme.mandyRed);
}

class ThemeColor {
  BuildContext context;

  ThemeColor(this.context);

  Color get primaryColor => Theme.of(context).colorScheme.primary;

  Color get secondaryColor => Theme.of(context).colorScheme.secondary;

  Color get textColor => Theme.of(context).colorScheme.scrim;
}
