import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class PreferencesStorage extends GetxService {
  static GetStorage getPrefBox() => GetStorage('PreferencesStorage');

  // Init
  Future<PreferencesStorage> init() async {
    await GetStorage.init('PreferencesStorage');
    return this;
  }

  final version = '1.0.0'.val('version', getBox: getPrefBox);
}
