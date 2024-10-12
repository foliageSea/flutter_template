import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/global.dart';
import 'package:flutter_template/logs/log.dart';
import 'package:flutter_template/pages/setting/setting_controller.dart';
import 'package:flutter_template/storages/preferences_storage.dart';
import 'package:get/get.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  late SettingController controller;

  @override
  void initState() {
    controller = Get.put(SettingController());
    super.initState();
  }

  Widget _build() {
    return ListView(
      children: [
        ListTile(
          title: const Text('版本号'),
          subtitle: Text(controller.version.value),
        ),
        ListTile(
          title: const Text('日志'),
          onTap: () {
            toTalkerScreen(context);
          },
        ),
        ListTile(
          title: const Text('重置应用'),
          onTap: () {
            showOkCancelAlertDialog(
                    context: context, title: '询问', message: '是否重置应用')
                .then((result) {
              if (result == OkCancelResult.ok) {
                Get.find<PreferencesStorage>().clearPrefBox();
                Global.restartApp(context);
              }
            });
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('设置'),
      ),
      body: _build(),
    );
  }
}
