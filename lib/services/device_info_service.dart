import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_template/logs/log.dart';
import 'package:get/get.dart';

class DeviceInfoService extends GetxService {
  // androidInfo
  late AndroidDeviceInfo _androidInfo;
  AndroidDeviceInfo get androidInfo => _androidInfo;

  Future<DeviceInfoService> init() async {
    try {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      if (GetPlatform.isAndroid) _androidInfo = await deviceInfo.androidInfo;
    } catch (e) {
      talker.handle(e, null, '设备信息初始化失败');
    }
    return this;
  }
}
