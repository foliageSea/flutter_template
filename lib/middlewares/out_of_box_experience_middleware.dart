import 'package:flutter/material.dart';
import 'package:flutter_template/routes/app_pages.dart';
import 'package:flutter_template/storages/preferences_storage.dart';
import 'package:get/get.dart';

class OutOfBoxExperienceMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (!Get.find<PreferencesStorage>().enterOutOfBoxExperiencePage()) {
      return null;
    }
    return const RouteSettings(name: Routes.outOfBoxExperience);
  }
}
