import 'package:package_info_plus/package_info_plus.dart';

/// 获取软件版本号
Future<String> getSoftwareVersion() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  return packageInfo.version;
}
