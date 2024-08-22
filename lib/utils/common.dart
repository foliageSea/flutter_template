import 'package:flutter/material.dart';
import 'package:flutter_template/events/events.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// 全局统一的 showToast
void showToast(String msg) {
  eventBus.fire(ShowToastEvent(msg));
}

/// 获取软件版本号
Future<String> getSoftwareVersion() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  return packageInfo.version;
}

void showSnackBar(String msg, {String? detail}) {
  final context = Get.context!;

  SnackBarAction? action;

  if (detail != null) {
    final dialog = AlertDialog(
      title: const Text('详情'),
      content: Text(detail),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('关闭'),
        )
      ],
    );

    action = SnackBarAction(
      label: '详情',
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return dialog;
          },
        );
      },
    );
  }

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(msg),
      duration: const Duration(seconds: 1),
      action: action,
    ),
  );
}
