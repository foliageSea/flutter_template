import 'package:flutter/material.dart';
import 'package:flutter_template/constants/common.dart';
import 'package:flutter_template/storages/preferences_storage.dart';
import 'package:get/get.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

class SettingController extends GetxController {
  final version = Get.find<PreferencesStorage>().version.val.obs;

  final theme = <String>[].obs;
  final themeMode = Get.find<PreferencesStorage>().themeMode.val.obs;

  Future changeTheme(BuildContext context, TDCell cell) async {
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
        // TODO 刷新主题 没有生效!!
        Get.changeThemeMode(themeModeMap[item]!);
        Navigator.of(context).pop();
      },
      data: [data],
    );
  }

  @override
  void onInit() {
    super.onInit();
    theme.value = [];
    themeModeTextMap.forEach((k, v) => theme.add(k));
  }
}
