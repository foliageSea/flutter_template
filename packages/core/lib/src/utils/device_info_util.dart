import 'package:core/core.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:snowflake_dart/snowflake_dart.dart';

abstract class DeviceInfoUtilAble {
  Future init();
  String getSystemVersion();
  Future<int> getDeviceId(StorageAble storage);
}

class DeviceInfoUtil with AppLogMixin implements DeviceInfoUtilAble {
  static DeviceInfoUtil? _deviceInfoUtil;

  DeviceInfoUtil._();

  factory DeviceInfoUtil() {
    _deviceInfoUtil ??= DeviceInfoUtil._();
    return _deviceInfoUtil!;
  }

  late DeviceInfoPlugin deviceInfo;
  late AndroidDeviceInfo androidInfo;

  @override
  Future init() async {
    deviceInfo = DeviceInfoPlugin();
    androidInfo = await deviceInfo.androidInfo;
    var systemVersion = getSystemVersion();
    log('系统版本: $systemVersion');
  }

  @override
  String getSystemVersion() {
    var release = androidInfo.version.release;
    return 'Android $release';
  }

  @override
  Future<int> getDeviceId(StorageAble storage) async {
    var cache = storage.get(StorageKeys.deviceId) ?? "";
    var deviceId = int.tryParse(cache);
    if (deviceId != null) {
      return deviceId;
    }
    var node = Snowflake(nodeId: 0);
    var id = node.generate(time: DateTime.now());
    await storage.set(StorageKeys.deviceId, id.toString());
    return id;
  }
}
