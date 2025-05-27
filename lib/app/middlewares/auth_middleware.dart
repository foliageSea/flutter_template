import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/app/routes/app_pages.dart';
import 'package:get/get.dart';

class AuthMiddleware extends GetMiddleware with AppLogMixin {
  StorageAble? storage;

  AuthMiddleware({this.storage});

  @override
  RouteSettings? redirect(String? route) {
    return handleLogout(route);
  }

  RouteSettings? handleLogout(String? route) {
    if (storage == null) {
      return null;
    }
    var token = storage!.get(StorageKeys.token);
    if (token != null && token.isNotEmpty) {
      return null;
    }
    warning('AuthMiddleware: 跳转到登录页面');
    return const RouteSettings(name: AppRoutes.login);
  }
}
