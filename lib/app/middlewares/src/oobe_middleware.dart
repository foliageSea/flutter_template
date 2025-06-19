import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/app/routes/app_pages.dart';
import 'package:get/get.dart';

class OobeMiddleware extends GetMiddleware with AppLogMixin {
  StorageAble? storage;

  OobeMiddleware({this.storage});

  @override
  RouteSettings? redirect(String? route) {
    return handleOobe(route);
  }

  static List<StorageKeys> requiredList = [StorageKeys.url];

  RouteSettings? handleOobe(String? route) {
    if (storage == null) {
      return null;
    }

    var result = requiredList.every((element) {
      var value = storage!.get(element);
      if (value != null && value.isNotEmpty) {
        return true;
      }
      return false;
    });
    if (result) {
      return null;
    }

    warning('OobeMiddleware: 跳转到Oobe页面');
    return const RouteSettings(name: AppRoutes.oobe);
  }
}
