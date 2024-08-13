import 'package:flutter/material.dart';
import 'package:flutter_template/routes/app_pages.dart';
import 'package:flutter_template/storages/user_storage.dart';
import 'package:flutter_template/utils/utils.dart';
import 'package:get/get.dart';

class EnsureAuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (Get.find<UserStorage>().isLogin) {
      return null;
    }

    showToast('登录失效，请重新登录');

    return const RouteSettings(name: Routes.login);
  }
}
