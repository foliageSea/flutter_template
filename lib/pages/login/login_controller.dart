import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_template/helpers/submit_helper.dart';
import 'package:flutter_template/routes/app_pages.dart';
import 'package:flutter_template/storages/user_storage.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormBuilderState>();

  Future login() async {
    await SubmitHelper.submit(() async {
      if (formKey.currentState?.validate() != true) {
        return;
      }
      debugPrint(formKey.currentState?.instantValue.toString());
      Get.find<UserStorage>().token.val = 'token';
      Get.find<UserStorage>().refreshToken.val = 'refreshToken';
      Get.offAllNamed(Routes.home);
    });
  }
}
