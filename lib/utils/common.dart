import 'package:flutter_template/events/events.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// 全局统一的 showToast
void showToast(String msg) {
  eventBus.fire(ToastEvent(msg));
}

/// 获取软件版本号
Future<String> getSoftwareVersion() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  return packageInfo.version;
}

void showSnackBar(String msg, {String? detail}) {
  eventBus.fire(SnackBarEvent(msg, detail: detail));
}
