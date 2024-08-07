import 'package:flutter/material.dart';
import 'package:flutter_template/helpers/submit_helper.dart';
import 'package:flutter_template/logs/log.dart';
import 'package:flutter_template/pages/setting/setting_controller.dart';
import 'package:get/get.dart';
import 'package:talker_flutter/talker_flutter.dart';

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
          ListTile(
            title: const Text('版本号'),
            subtitle: Text(controller.version.value),
            onTap: () async {
              await SubmitHelper.submit(() async {
                await Future.delayed(const Duration(seconds: 2));
              });
            },
          ),
        ],
      ),
    );
  }
}
