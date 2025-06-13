import 'dart:io';

import 'package:core/core.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:snowflake_dart/snowflake_dart.dart';

abstract class DeviceInfoUtil extends CommonInitialize {
  String getSystemVersion();
  Future<int> getDeviceId(StorageAble storage);

  static DeviceInfoUtil getInstance() {
    if (Platform.isAndroid) {
      return DeviceInfoUtilAndroid();
    }
    return DeviceInfoUtilOthers();
  }
}

class DeviceInfoUtilAndroid with AppLogMixin implements DeviceInfoUtil {
  static DeviceInfoUtilAndroid? _deviceInfoUtilAndroid;

  DeviceInfoUtilAndroid._();

  factory DeviceInfoUtilAndroid() {
    _deviceInfoUtilAndroid ??= DeviceInfoUtilAndroid._();
    return _deviceInfoUtilAndroid!;
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

  @override
  String getOutput() {
    return '【DeviceInfoUtilAndroid】初始化完成';
  }
}

class DeviceInfoUtilOthers implements DeviceInfoUtil {
  static DeviceInfoUtilOthers? _deviceInfoUtilOthers;
  DeviceInfoUtilOthers._();
  factory DeviceInfoUtilOthers() {
    _deviceInfoUtilOthers ??= DeviceInfoUtilOthers._();
    return _deviceInfoUtilOthers!;
  }

  @override
  Future<int> getDeviceId(StorageAble storage) async {
    return 0;
  }

  @override
  String getSystemVersion() {
    return '';
  }

  @override
  Future init() async {}

  @override
  String getOutput() {
    return '【DeviceInfoUtilOthers】初始化完成';
  }
}
