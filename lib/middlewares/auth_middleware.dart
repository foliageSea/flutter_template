import 'package:flutter/material.dart';
import 'package:flutter_template/routes/app_pages.dart';
import 'package:flutter_template/storages/user_storage.dart';
import 'package:get/get.dart';

class EnsureAuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (Get.find<UserStorage>().isLogin) {
      return null;
    }

    return const RouteSettings(name: Routes.login);
  }
}

class EnsureAutoAuthedMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (!Get.find<UserStorage>().isLogin) {
      return null;
    }

    return const RouteSettings(name: Routes.home);
  }
}
