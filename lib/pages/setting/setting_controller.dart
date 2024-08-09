import 'package:flutter/material.dart';
import 'package:flutter_template/constants/common.dart';
import 'package:flutter_template/storages/preferences_storage.dart';
import 'package:get/get.dart';

class SettingController extends GetxController {
  final version = Get.find<PreferencesStorage>().version.val.obs;

  final theme = <String>[].obs;

  Future changeTheme() async {
    // final value = await showModalActionSheet(
    //   context: Get.overlayContext!,
    //   actions: [
    //     SheetAction(label: '跟随系统', key: 'system'),
    //     SheetAction(label: '明亮', key: 'light'),
    //     SheetAction(label: '深邃', key: 'dark'),
    //   ],
    //   cancelLabel: '取消',
    // );
  }

  @override
  void onInit() {
    super.onInit();
    theme.value = [];
    themeModeTextMap.forEach((k, v) => theme.add(v));
  }
}
