import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/fs_widgets/fs_message_panel.dart';
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

  FsMessagePanelController panelController = FsMessagePanelController();

  @override
  void initState() {
    controller = Get.put(HomeController());
    super.initState();
  }

  String? checkVal(String? value) {
    if (value == null || value.isEmpty) {
      return '不能为空';
    } else {
      return null;
    }
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
                //   title: '登录',
                //   textFields: [
                //     DialogTextField(
                //       hintText: '请输入QQ号',
                //       validator: checkVal,
                //       keyboardType: TextInputType.number,
                //     ),
                //     // const DialogTextField(hintText: '请输入密码'),
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
            ),
            FilledButton(
                onPressed: () {
                  panelController.addMessage(FsMessagePanelPassItem(
                      '测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试',
                      '测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试'));
                  panelController.addMessage(FsMessagePanelFailItem(
                      '测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试',
                      '测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试'));
                },
                child: const Text('add')),
            Flexible(
              child: FsMessagePanel(
                controller: panelController,
              ),
            )
          ],
        ),
      ),
    );
  }
}
