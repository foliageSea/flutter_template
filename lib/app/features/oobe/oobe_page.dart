import 'package:flutter/material.dart';
import 'package:flutter_template/app/layouts/base_layout.dart';
import 'package:flutter_template/core/logger/logger.dart';

class OobePage extends StatefulWidget {
  const OobePage({super.key});

  @override
  State<OobePage> createState() => _OobePageState();
}

class _OobePageState extends State<OobePage> {
  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      title: 'Oobe',
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
