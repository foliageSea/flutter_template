import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/app/layouts/base_layout.dart';
import 'package:flutter_template/app/locales/locales.dart';
import 'package:get/get.dart';

class OobePage extends StatefulWidget {
  const OobePage({super.key});

  @override
  State<OobePage> createState() => _OobePageState();
}

class _OobePageState extends State<OobePage> with AppLogMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      title: 'Oobe',
      child: Column(
        children: [
          Text('你好'.tr),
          FilledButton(
            onPressed: () {
              Locales().updateLocale(SupportedLocales.zh);
            },
            child: const Text('测试'),
          )
        ],
      ),
    );
  }
}
