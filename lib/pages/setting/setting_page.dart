import 'dart:io';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/constants/common.dart';
import 'package:flutter_template/global.dart';
import 'package:flutter_template/logs/log.dart';
import 'package:flutter_template/pages/examples/device_info_example/device_info_example_page.dart';
import 'package:flutter_template/pages/examples/home_example/home_example_page.dart';
import 'package:flutter_template/pages/examples/media_swiper_example/media_swiper_example_page.dart';
import 'package:flutter_template/pages/examples/video_player_example/video_player_example_page.dart';
import 'package:flutter_template/pages/setting/setting_controller.dart';
import 'package:flutter_template/fs_widgets/fs_app_bar.dart';
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
          title: const Text('设备信息'),
          onTap: () {
            if (!Platform.isAndroid) {
              return;
            }

            Get.to(const DeviceInfoExamplePage());
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
          title: const Text('示例'),
          onTap: () {
            Get.to(() => const HomeExamplePage());
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const FsAppBar(
        title: '设置',
        actions: [],
      ),
      body: Obx(
        () => _build(),
      ),
    );
  }
}
