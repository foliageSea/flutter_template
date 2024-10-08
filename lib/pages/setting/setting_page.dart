import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/constants/common.dart';
import 'package:flutter_template/global.dart';
import 'package:flutter_template/logs/log.dart';
import 'package:flutter_template/pages/setting/setting_controller.dart';
import 'package:flutter_template/storages/user_storage.dart';
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
        // TODO 存在主题模式切换后字体颜色冲突的问题
        // ListTile(
        //   title: const Text('主题模式'),
        //   subtitle: Text(themeModeTextMap[controller.themeMode.value]!),
        //   onTap: () {
        //     controller.changeTheme(context);
        //   },
        // ),
        ListTile(
          title: const Text('语言'),
          subtitle: Text(languageMap[controller.language.value]!),
          onTap: () {
            controller.changeLanguage(context);
          },
        ),
        ListTile(
          title: const Text('日志'),
          onTap: () {
            toTalkerScreen(context);
          },
        ),
        ListTile(
          title: const Text('重启应用'),
          onTap: () {
            showOkCancelAlertDialog(
                    context: context, title: '询问', message: '是否重启应用')
                .then((result) {
              if (result == OkCancelResult.ok) {
                Global.restartApp(context);
              }
            });
          },
        ),
        ListTile(
          title: const Text('查看'),
          onTap: () {
            Get.find<UserStorage>().preview(context);
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
      body: Obx(
        () => _build(),
      ),
    );
  }
}
