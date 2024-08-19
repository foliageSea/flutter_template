import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'en_us.dart';
import 'zh_cn.dart';

class TranslationService extends Translations {
  // static Locale? get locale => Get.deviceLocale;
  static Locale? get locale => const Locale('zh', 'CN');
  static const fallbackLocale = Locale('zh', 'CN');

  @override
  Map<String, Map<String, String>> get keys => {
        'zh_CN': zhCN,
        'en_US': enUS,
      };
}
