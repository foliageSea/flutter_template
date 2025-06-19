import 'package:core/core.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeController extends GetxService with AppLogMixin {
  Rx<String> flexScheme = ''.obs;
  Rx<String> themeMode = ''.obs;

  Map<String, FlexScheme> flexSchemeMap = {
    '绿色M3': FlexScheme.greenM3,
    '深蓝石': FlexScheme.bigStone,
    '蓝色M3': FlexScheme.blueM3,
    '青色M3': FlexScheme.cyanM3,
    '水鸭M3': FlexScheme.tealM3,
  };

  Map<String, ThemeMode> themeModeMap = {
    '系统': ThemeMode.system,
    '深色': ThemeMode.dark,
    '浅色': ThemeMode.light,
  };

  ThemeData getThemeData() {
    return FlexThemeData.light(scheme: flexSchemeMap[flexScheme.value])
        .copyWith(
      textTheme: GoogleFonts.notoSansScTextTheme(),
    );
  }

  ThemeData getDarkThemeData() {
    return FlexThemeData.dark(scheme: flexSchemeMap[flexScheme.value]).copyWith(
      textTheme: GoogleFonts.notoSansScTextTheme(),
    );
  }

  ThemeMode getThemeMode() {
    final key = themeModeMap.keys.firstWhere(
      (key) => key == themeMode.value,
      orElse: () => themeModeMap.keys.first.toString(),
    );
    return themeModeMap[key]!;
  }

  Future changeTheme(FlexScheme scheme) async {
    final key = flexSchemeMap.keys.firstWhere(
      (key) => flexSchemeMap[key] == scheme,
      orElse: () => flexScheme.value,
    );
    flexScheme.value = key;
    await Storage().set(StorageKeys.flexScheme, key);
    Get.changeTheme(getThemeData());
  }

  Future changeThemeMode(ThemeMode mode) async {
    final key = themeModeMap.keys.firstWhere(
      (key) => themeModeMap[key] == mode,
      orElse: () => themeMode.value,
    );
    themeMode.value = key;
    await Storage().set(StorageKeys.themeMode, key);
    Get.changeThemeMode(mode);
  }

  void init() {
    flexScheme.value = Storage()
        .get(StorageKeys.flexScheme)
        .parseString(defaultValue: flexSchemeMap.keys.first.toString());
    themeMode.value = Storage()
        .get(StorageKeys.themeMode)
        .parseString(defaultValue: themeModeMap.keys.first.toString());
    log('加载主题: ${flexScheme.value}, 模式 ${themeMode.value}');
  }
}
