import 'package:flutter/material.dart';
import 'package:flutter_template/constants/common.dart';
import 'package:flutter_template/logs/log.dart';
import 'package:flutter_template/pages/examples/device_info_example/device_info_example_page.dart';
import 'package:flutter_template/pages/examples/media_swiper_example/media_swiper_example_page.dart';
import 'package:flutter_template/pages/examples/video_player_example/video_player_example_page.dart';
import 'package:flutter_template/pages/setting/setting_controller.dart';
import 'package:flutter_template/widgets/custom_app_bar.dart';
import 'package:get/get.dart';
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

  Widget _build() {
    return ListView(
      children: [
        ListTile(
          title: const Text('版本号'),
          subtitle: Text(controller.version.value),
        ),
        ListTile(
          title: const Text('主题模式'),
          subtitle: Text(themeModeTextMap[controller.themeMode.value]!),
          onTap: () {
            controller.changeTheme(context);
          },
        ),
        ListTile(
          title: const Text('视频播放'),
          onTap: () {
            Get.to(const VideoPlayerExamplePage());
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
            Get.to(const DeviceInfoExamplePage());
          },
        ),
        ListTile(
          title: const Text('媒体轮播'),
          onTap: () {
            Get.to(const MediaSwiperExamplePage());
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: Text('设置'),
        actions: [],
      ),
      body: Obx(
        () => _build(),
      ),
    );
  }
}
