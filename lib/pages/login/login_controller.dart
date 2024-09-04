import 'package:flutter/material.dart';
import 'package:flutter_template/helpers/submit_helper.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  late LoginForm loginForm;

  Future handleLogin() async {
    await SubmitHelper.submit(() async {
      await Future.delayed(const Duration(seconds: 1));

      print(loginForm.formData);

      loginForm.resetFormData();

      // Get.offAllNamed(Routes.home);
    });
  }

  @override
  void onInit() {
    super.onInit();

    loginForm = LoginForm();
  }

  @override
  void onClose() {
    super.onClose();

    loginForm.dispose();
  }
}

class LoginForm {
  late TextEditingController accountController;
  late TextEditingController passwordController;

  LoginForm() {
    accountController = TextEditingController();
    passwordController = TextEditingController();
  }

  Map<String, String> get formData {
    return {
      'account': accountController.text,
      'password': passwordController.text,
    };
  }

  resetFormData() {
    accountController.clear();
    passwordController.clear();
  }

  void dispose() {
    accountController.dispose();
    passwordController.dispose();
  }
}
