import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:toastification/toastification.dart';

/// 获取软件版本号
Future<String> getSoftwareVersion() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  return packageInfo.version;
}

// SmartDialog文档: https://xdd666t.github.io/flutter_use/web/index.html#/smartDialog
Future<void> showToast(String msg) {
  return SmartDialog.showToast(msg);
}

void showErrorToast(String? desc) {
  try {
    toastification.show(
      context: Get.context!,
      type: ToastificationType.error,
      style: ToastificationStyle.flat,
      title: const Text('内部错误'),
      description: Text(handleException(desc)),
      alignment: Alignment.topRight,
      autoCloseDuration: const Duration(seconds: 3),
    );
  } catch (_) {}
}

String handleException(String? exception) {
  if (exception == null) {
    return '';
  }

  return exception.split('Source stack:').first.replaceAll('\n', '');
}
