import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_template/constants/common.dart';
import 'package:flutter_template/logs/log.dart';
import 'package:flutter_template/services/device_info_service.dart';
import 'package:get/get.dart';

import 'storages/preferences_storage.dart';

class Global {
  Global._();

  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();

    /// init service
    await Get.putAsync(() => PreferencesStorage().init());
    await Get.putAsync(() => DeviceInfoService().init());

    // Theme
    Get.changeThemeMode(
        themeModeMap[Get.find<PreferencesStorage>().themeMode.val]!);

    if (GetPlatform.isAndroid) {
      SystemUiOverlayStyle systemUiOverlayStyle =
          const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }

    talker.info('初始化完成');
  }
}
