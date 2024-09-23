import 'package:flutter_template/storages/storage_mixin.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class PreferencesStorage extends GetxService with StorageMixin {
  static const container = 'PreferencesStorage';

  static GetStorage getPrefBox() => GetStorage(container);

  // Init
  Future<PreferencesStorage> init() async {
    await GetStorage.init(container);
    return this;
  }

  final version = '1.0.0'.val('version', getBox: getPrefBox);
  final themeMode = 'system'.val('themeMode', getBox: getPrefBox);
  final language = 'zh_CN'.val('language', getBox: getPrefBox);

  @override
  void clearPrefBox() {
    final prefBox = getPrefBox();
    prefBox.remove('version');
    prefBox.remove('themeMode');
    prefBox.remove('language');
  }

  @override
  String toString() {
    return 'version: ${version.val}\nthemeMode: ${themeMode.val}\nlanguage: ${language.val}';
  }
}
