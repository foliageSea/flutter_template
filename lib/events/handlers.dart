import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_template/events/events.dart';
import 'package:get/get.dart';

void toastEventHandler(ToastEvent event) {
  SmartDialog.showToast(event.msg);
}

void snackBarEventHandler(SnackBarEvent event) {
  final msg = event.msg;
  final detail = event.detail;
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
