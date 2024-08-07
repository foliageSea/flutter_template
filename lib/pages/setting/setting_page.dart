import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_template/logs/log.dart';
import 'package:flutter_template/pages/setting/setting_controller.dart';
import 'package:get/get.dart';
import 'package:stack_trace/stack_trace.dart';
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
              // SmartDialog.showToast('test toast')
              try {
                SmartDialog.showLoading();
                await Future.delayed(const Duration(seconds: 2));
                throw Exception('test error');
              } catch (e, st) {
                talker.handle(e, st, '测试');
              } finally {
                SmartDialog.dismiss();
              }
            },
          ),
        ],
      ),
    );
  }
}
