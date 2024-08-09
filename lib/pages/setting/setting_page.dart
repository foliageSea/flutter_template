import 'package:flutter/material.dart';
import 'package:flutter_template/constants/common.dart';
import 'package:flutter_template/logs/log.dart';
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
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => TalkerScreen(talker: talker),
              ));
            },
            icon: const Icon(Icons.bug_report),
          )
        ],
      ),
      body: ListView(
        children: [
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     const FaIcon(
          //       FontAwesomeIcons.steam,
          //       size: 60,
          //     )
          //   ],
          // ),
          Obx(
            () => TDCellGroup(
              theme: TDCellGroupTheme.cardTheme,
              cells: [
                TDCell(
                  title: '版本号',
                  description: controller.version.value,
                ),
                TDCell(
                  arrow: true,
                  title: '主题',
                  description: themeModeTextMap[controller.themeMode.value],
                  onClick: (cell) {
                    controller.changeTheme(context, cell);
                  },
                ),
              ],
            ),
          ),
          const CustomVideoPlayer(
            videoUrl:
                'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
          )
        ],
      ),
    );
  }
}
