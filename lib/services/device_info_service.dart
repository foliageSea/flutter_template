import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';

class DeviceInfoService extends GetxService {
  // androidInfo
  late AndroidDeviceInfo _androidInfo;
  AndroidDeviceInfo get androidInfo => _androidInfo;

  Future<DeviceInfoService> init() async {
    try {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      if (GetPlatform.isAndroid) _androidInfo = await deviceInfo.androidInfo;
    } catch (e) {}
    return this;
  }
}
