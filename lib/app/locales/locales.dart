import 'dart:convert';
import 'dart:ui';

import 'package:core/core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

class Locales extends Translations with AppLogMixin {
  static Locales? _locales;

  Locales._();

  factory Locales() {
    _locales ??= Locales._();
    return _locales!;
  }

  /// 语言包路径
  final String assetsPath = 'assets/locales';

  /// 语言包代理
  final localizationsDelegates = [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];

  @override
  Map<String, Map<String, String>> get keys => toKeys();

  final Map<SupportedLocales, Map<String, String>> locales = {};

  Map<String, Map<String, String>> toKeys() {
    return locales.map((key, value) => MapEntry(key.locale, value));
  }

  Future loadLocale() async {
    for (var locale in SupportedLocales.values) {
      try {
        // var path = join(assetsPath, locale.fileName);
        var path = '$assetsPath/${locale.fileName}';
        final String jsonString = await rootBundle.loadString(path);
        final Map<String, dynamic> jsonMap = json.decode(jsonString);
        locales[locale] = jsonMap.cast<String, String>();
        log('加载语言包成功: ${locale.fileName}');
      } catch (e) {
        warning('加载语言包失败: ${locale.fileName} $e');
      }
    }
    var locale = Storage()
        .get(StorageKeys.locale)
        .parseString(defaultValue: SupportedLocales.zh.locale);
    await updateLocaleByLocale(locale);
    log('加载语言成功');
  }

  List<Locale> getSupportedLocales() {
    return SupportedLocales.values.map((e) => e.localeObj).toList();
  }

  Future updateLocale(SupportedLocales locale) async {
    final key = SupportedLocales.values.firstWhere(
      (element) => element.locale == locale.locale,
      orElse: () => SupportedLocales.zh,
    );

    await Get.updateLocale(
      key.localeObj,
    );
    await Storage().set(StorageKeys.locale, key.locale);
    log('切换语言包: ${key.locale}');
  }

  Future updateLocaleByLocale(String locale) async {
    final key = SupportedLocales.values.firstWhere(
      (element) => element.locale == locale,
      orElse: () => SupportedLocales.zh,
    );
    await Get.updateLocale(
      key.localeObj,
    );
    await Storage().set(StorageKeys.locale, key.locale);
    log('切换语言包: ${key.locale}');
  }

  SupportedLocales getCurrentLocale() {
    final locale = Get.locale;
    return SupportedLocales.values.firstWhere(
      (element) => element.localeObj == locale,
      orElse: () => SupportedLocales.zh,
    );
  }
}

enum SupportedLocales {
  zh('zh_CN', 'zh_CN.json', Locale('zh', 'CN')),
  en('en_US', 'en_US.json', Locale('en', 'US'));

  final String locale;
  final String fileName;
  final Locale localeObj;
  const SupportedLocales(this.locale, this.fileName, this.localeObj);
}
