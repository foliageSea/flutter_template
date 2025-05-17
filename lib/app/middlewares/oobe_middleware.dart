import 'package:flutter/material.dart';
import 'package:flutter_template/app/routes/app_pages.dart';
import 'package:flutter_template/core/mixins/app_log_mixin.dart';
import 'package:flutter_template/core/storage/storage.dart';
import 'package:flutter_template/core/storage/storage_keys.dart';
import 'package:get/get.dart';

class OobeMiddleware extends GetMiddleware with AppLogMixin {
  StorageAble? storage;

  OobeMiddleware({this.storage});

  @override
  RouteSettings? redirect(String? route) {
    return handleOobe(route);
  }

  RouteSettings? handleOobe(String? route) {
    if (storage == null) {
      return null;
    }
    var url = storage!.get(StorageKeys.url);
    if (url != null && url.isNotEmpty) {
      return null;
    }
    warning('OobeMiddleware: 跳转到Oobe页面');
    return const RouteSettings(name: AppRoutes.oobe);
  }
}
