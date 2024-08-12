import 'package:flutter/material.dart';
import 'package:flutter_template/constants/common.dart';
import 'package:flutter_template/logs/log.dart';
import 'package:flutter_template/pages/examples/device_info_example/device_info_example_page.dart';
import 'package:flutter_template/pages/examples/video_player_example/video_player_example_page.dart';
import 'package:flutter_template/pages/setting/setting_controller.dart';
import 'package:flutter_template/widgets/custom_video_player.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('设置'),
        actions: [],
      ),
      body: Obx(
        () => TDCellGroup(
          scrollable: true,
          theme: TDCellGroupTheme.cardTheme,
          cells: [
            TDCell(
              title: '版本号',
              description: controller.version.value,
            ),
            // TDCell(
            //   arrow: true,
            //   title: '主题',
            //   description: themeModeTextMap[controller.themeMode.value],
            //   onClick: (cell) {
            //     controller.changeTheme(context, cell);
            //   },
            // ),
            TDCell(
              arrow: true,
              title: '视频播放',
              onClick: (cell) {
                Get.to(const VideoPlayerExamplePage());
              },
            ),
            // const TDCell(
            //   arrow: true,
            //   title: '数据库',
            // ),
            // const TDCell(
            //   arrow: true,
            //   title: '数据持久化',
            // ),
            // const TDCell(
            //   arrow: true,
            //   title: '重启应用',
            // ),
            TDCell(
              arrow: true,
              title: '日志',
              onClick: (cell) {
                toTalkerScreen(context);
              },
            ),
            // const TDCell(
            //   arrow: true,
            //   title: '主题配色',
            // ),
            TDCell(
              arrow: true,
              title: '设备信息',
              onClick: (cell) {
                Get.to(const DeviceInfoExamplePage());
              },
            ),
          ],
        ),
      ),
    );
  }
}
