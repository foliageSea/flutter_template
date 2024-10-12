import 'package:flutter/material.dart';
import 'package:flutter_template/routes/app_pages.dart';
import 'package:flutter_template/storages/preferences_storage.dart';
import 'package:flutter_template/utils/common.dart';
import 'package:get/get.dart';

import 'out_of_box_experience_controller.dart';

class OutOfBoxExperiencePage extends StatefulWidget {
  const OutOfBoxExperiencePage({super.key});

  @override
  State<OutOfBoxExperiencePage> createState() => _OutOfBoxExperiencePageState();
}

class _OutOfBoxExperiencePageState extends State<OutOfBoxExperiencePage> {
  late OutOfBoxExperienceController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(OutOfBoxExperienceController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('欢迎使用'),
      ),
      body: Column(
        children: [
          Flexible(
            child: ListView(
              children: [
                ListTile(
                  title: const Text('服务器地址'),
                  subtitle: Text(controller.targetServer.value),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () async {
                    await controller.handleTargetServer(context);
                  },
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(8.0),
            width: double.infinity,
            child: FilledButton(
              onPressed: () {
                if (!Get.find<PreferencesStorage>()
                    .enterOutOfBoxExperiencePage()) {
                  Get.offAllNamed(Routes.home);
                  return;
                }
                showToast('请先完成设置');
              },
              child: const Text('开始使用'),
            ),
          )
        ],
      ),
    );
  }
}
