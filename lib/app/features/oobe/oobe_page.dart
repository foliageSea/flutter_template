import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/app/common/global.dart';
import 'package:flutter_template/app/layouts/base_layout.dart';
import 'package:flutter_template/app/locales/locales.dart';
import 'package:flutter_template/db/database.dart';
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
          Text('%s秒'.trArgs(['5'])),
          FilledButton(
            onPressed: () {
              Locales().updateLocale(SupportedLocales.zh);
            },
            child: const Text('中文'),
          ),
          FilledButton(
            onPressed: () {
              Locales().updateLocale(SupportedLocales.en);
            },
            child: const Text('英文'),
          ),
        ].insertSizedBoxBetween(height: 8),
      ),
    );
  }
}
