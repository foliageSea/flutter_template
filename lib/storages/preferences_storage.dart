import 'package:flutter_template/storages/storage_mixin.dart';
import 'package:flutter_template/utils/app_directory.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class PreferencesStorage extends GetxService with StorageMixin {
  static const container = 'PreferencesStorage';

  static GetStorage getPrefBox() =>
      GetStorage(container, AppDirectory.getDirectory);

  // Init
  Future<PreferencesStorage> init() async {
    return this;
  }

  final version = '1.0.0'.val('version', getBox: getPrefBox);
  final themeMode = 'system'.val('themeMode', getBox: getPrefBox);
  final language = 'zh_CN'.val('language', getBox: getPrefBox);
  final targetServer = ''.val('targetServer', getBox: getPrefBox);

  @override
  void clearPrefBox() {
    final prefBox = getPrefBox();
    prefBox.remove('targetServer');
  }

  bool enterOutOfBoxExperiencePage() {
    return targetServer.val.isEmpty;
  }
}
