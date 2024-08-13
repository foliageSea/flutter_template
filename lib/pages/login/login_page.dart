import 'package:flutter/material.dart';
import 'package:flutter_template/pages/login/loging_controller.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late LogingController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(LogingController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('登录'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: _buildForm(),
      ),
    );
  }

  Widget _buildForm() {
    final loginForm = controller.loginForm;

    return Column(
      children: [
        TextField(
          controller: loginForm.accountController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: '请输入用户名',
            labelText: '用户名',
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        TextField(
          controller: loginForm.passwordController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: '请输入密码',
            labelText: '密码',
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: () async {
              await controller.handleLogin();
            },
            child: const Text('登录'),
          ),
        )
      ],
    );
  }
}