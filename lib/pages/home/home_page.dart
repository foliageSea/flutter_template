import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/fs_widgets/fs_widgets.dart';
import 'package:flutter_template/global.dart';
import 'package:flutter_template/pages/home/home_controller.dart';
import 'package:flutter_template/routes/app_pages.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeController controller;

  @override
  void initState() {
    controller = Get.put(HomeController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FsAppBar(
        title: Text('测试'.tr),
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed(Routes.setting);
            },
            icon: const Icon(Icons.settings),
          )
        ],
      ),
      body: Center(
        child: Column(
          children: [
            FilledButton.icon(
              onPressed: () async {
                // final res = await showTextInputDialog(
                //   context: context,
                //   title: '请输入QQ号',
                //   textFields: [
                //     const DialogTextField(hintText: '请输入QQ号'),
                //   ],
                //   cancelLabel: '取消',
                //   okLabel: '确认',
                // );

                // final res = await showOkCancelAlertDialog(
                //   context: context,
                //   title: '询问',
                //   message: '是否继续?',
                //   okLabel: '确认',
                //   cancelLabel: '取消',
                // );

                // print(res);
              },
              icon: const FaIcon(
                FontAwesomeIcons.qq,
                size: 14,
              ),
              label: const Text('QQ'),
            ),
            FilledButton.icon(
              onPressed: () {
                Global.restartApp(context);
              },
              icon: const Icon(Icons.restart_alt_rounded),
              label: const Text('重启应用'),
            )
          ],
        ),
      ),
    );
  }
}
