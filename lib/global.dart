import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_template/constants/common.dart';
import 'package:flutter_template/helpers/android_helper.dart';
import 'package:flutter_template/logs/log.dart';
import 'package:flutter_template/services/db_service.dart';
import 'package:flutter_template/services/device_info_service.dart';
import 'package:flutter_template/services/dio_service.dart';
import 'package:flutter_template/storages/user_storage.dart';
import 'package:flutter_template/utils/app_directory.dart';
import 'package:flutter_template/fs_widgets/fs_splash_screen.dart';
import 'package:flutter_template/utils/utils.dart';
import 'package:get/get.dart';
import 'package:fvp/fvp.dart' as fvp;
// import 'dart:math' as math;

import 'storages/preferences_storage.dart';

typedef ChangeStatusCallBack = void Function(bool status);

class Global {
  Global._();

  /// 应用初始化
  static Future initApp() async {
    WidgetsFlutterBinding.ensureInitialized();

    AppDirectory.ensureInitialized();

    /// init service
    await Get.putAsync(() => PreferencesStorage().init());
    await Get.putAsync(() => UserStorage().init());
    await Get.putAsync(() => DeviceInfoService().init());
    await Get.putAsync(() => DbService().init());
    await Get.putAsync(() => DioService().init());
    // await Get.putAsync(() => TtsService().init());

    /// init fvp
    fvp.registerWith();

    /// Theme
    Get.changeThemeMode(
        themeModeMap[Get.find<PreferencesStorage>().themeMode.val]!);

    if (GetPlatform.isAndroid) {
      AndroidHelper.initStatusBar();
    }

    talker.info('应用初始化完成');
  }

  /// 服务初始化
  static Future initService(
    ChangeStatusCallBack? cb,
    FsSplashScreenController? controller, {
    bool? rec,
  }) async {
    talker.info('服务初始化开始');
    cb?.call(true);
    try {
      /// TODO 首次联网检测 递归调用
      controller?.setText('加载中'.tr);

      /// 软件版本
      final version = await getSoftwareVersion();
      Get.find<PreferencesStorage>().version.val = version;
      talker.info('软件版本: $version');

      /// language
      final lan = Get.find<PreferencesStorage>().language.val;
      talker.info('语言: $lan');
      Future.delayed(const Duration(seconds: 1), () {
        Get.updateLocale(Locale(lan));
      });

      // TODO 测试异常情况
      // if (math.Random().nextInt(2) == 1) {
      //   throw Exception('test error');
      // }
      await Future.delayed(const Duration(seconds: 1));
      cb?.call(false);
      talker.info('服务初始化完成');
    } catch (e) {
      talker.error('服务初始化出错', e);
      if (rec == true) {
        controller?.setText('出错了, 5秒后重试'.tr);
        Future.delayed(const Duration(seconds: 5), () async {
          await initService(cb, controller, rec: true);
        });
        return;
      }
    } finally {
      if (rec == null || rec == false) {
        cb?.call(false);
        talker.info('服务初始化完成');
      }
    }
  }

  /// 重启应用
  static void restartApp(BuildContext context) {
    Phoenix.rebirth(context);
  }

  /// 退出应用
  static void exitApp() {
    AndroidHelper.exitApp();
  }
}
