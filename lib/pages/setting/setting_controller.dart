import 'package:flutter/material.dart';
import 'package:flutter_template/constants/common.dart';
import 'package:flutter_template/storages/preferences_storage.dart';
import 'package:get/get.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

class SettingController extends GetxController {
  final version = Get.find<PreferencesStorage>().version.val.obs;

  final theme = <String>[].obs;
  final themeMode = Get.find<PreferencesStorage>().themeMode.val.obs;
  final langs = <String>[].obs;

  final language = Get.find<PreferencesStorage>().language.val.obs;

  Future changeTheme(BuildContext context) async {
    final data =
        theme.map<String>((e) => themeModeTextMap[e] as String).toList();
    final initialIndexes = theme.indexOf(themeMode.value);

    TDPicker.showMultiPicker(
      context,
      initialIndexes: [initialIndexes],
      onConfirm: (List<dynamic> selected) {
        if (selected.isEmpty) {
          return;
        }
        var item = theme[selected.first];
        themeMode.value = item;
        themeMode.refresh();
        Get.find<PreferencesStorage>().themeMode.val = item;
        Navigator.of(context).pop();
      },
      data: [data],
    );
  }

  Future changeLanguage(BuildContext context) async {
    final data = langs.map<String>((e) => languageMap[e] as String).toList();
    final initialIndexes = theme.indexOf(language.value);

    TDPicker.showMultiPicker(
      context,
      initialIndexes: [initialIndexes],
      onConfirm: (List<dynamic> selected) {
        if (selected.isEmpty) {
          return;
        }
        var item = langs[selected.first];
        language.value = item;
        language.refresh();
        Get.find<PreferencesStorage>().language.val = item;
        Navigator.of(context).pop();

        Get.updateLocale(Locale(Get.find<PreferencesStorage>().language.val));
      },
      data: [data],
    );
  }

  @override
  void onInit() {
    super.onInit();
    theme.value = [];
    themeModeTextMap.forEach((k, v) => theme.add(k));

    langs.value = [];
    languageMap.forEach((k, v) => langs.add(k));
  }
}
