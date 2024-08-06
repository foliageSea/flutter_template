import 'package:flutter_template/storages/preferences_storage.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final version = Get.find<PreferencesStorage>().version.val.obs;

  void handleChange() {
    var value = '1.0.4';
    version.value = value;
    version.refresh();
    Get.find<PreferencesStorage>().version.val = value;
  }
}
