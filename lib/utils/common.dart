import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/events/events.dart';
import 'package:get/get.dart';
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
      duration: const Duration(seconds: 2),
      action: action,
    ),
  );
}

void showErrorNotification(String msg, {String? detail}) {
  eventBus.fire(ErrorNotificationEvent(msg, detail));
}

void errorNotificationEventHandler(ErrorNotificationEvent event) {
  final msg = event.msg;
  final detail = event.detail;

  final context = Get.context!;

  AlertDialog? dialog;

  if (detail != null) {
    dialog = AlertDialog(
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
  }

  ElegantNotification.error(
    width: 360,
    // stackedOptions: StackedOptions(
    //   key: 'topRight',
    //   type: StackedType.below,
    //   itemOffset: const Offset(0, 5),
    // ),
    position: Alignment.topRight,
    animation: AnimationType.fromRight,
    title: const Text('服务器内部错误'),
    description: Text(msg),
    onDismiss: () {},
    onNotificationPressed: () {
      if (dialog == null) {
        return;
      }
      showDialog(
        context: context,
        builder: (context) {
          return dialog!;
        },
      );
    },
  ).show(context);
}
