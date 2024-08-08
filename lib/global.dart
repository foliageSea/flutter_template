import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_template/constants/common.dart';
import 'package:flutter_template/logs/log.dart';
import 'package:flutter_template/services/device_info_service.dart';
import 'package:flutter_template/utils/common.dart';
import 'package:flutter_template/widgets/splash_screen.dart';
import 'package:get/get.dart';

import 'storages/preferences_storage.dart';

typedef ChangeStatusCallBack = void Function(bool status);

class Global {
  Global._();

  /// 应用初始化
  static Future initApp() async {
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

    talker.info('应用初始化完成');
  }

  /// 服务初始化
  static Future initService(
      [ChangeStatusCallBack? cb, SplashScreenController? controller]) async {
    cb?.call(true);
    try {
      // TODO 首次联网检测 递归调用
      controller?.setText('检测网络');
      await Future.delayed(const Duration(seconds: 2));
      controller?.setText('检测版本');
      await Future.delayed(const Duration(seconds: 2));
      controller?.setText('加载配置');
      await Future.delayed(const Duration(seconds: 2));
    } catch (e) {
    } finally {
      cb?.call(false);
      talker.info('服务初始化完成');
    }
  }
}
