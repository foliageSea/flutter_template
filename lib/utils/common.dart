import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// 全局统一的 showToast
Future<void> showToast(String msg) {
  return SmartDialog.showToast(msg);
}

/// 获取软件版本号
Future<String> getSoftwareVersion() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  return packageInfo.version;
}

