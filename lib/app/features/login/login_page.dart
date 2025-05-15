import 'package:flutter/material.dart';
import 'package:flutter_template/app/layouts/base_layout.dart';
import 'package:flutter_template/core/logger/logger.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      title: 'Login',
      child: Center(
        child: FilledButton(
            onPressed: () {
              try {
                throw Exception('测试异常');
              } catch (e, st) {
                AppLogger().handle(e, st);
              }
            },
            child: const Text('测试')),
      ),
    );
  }
}
