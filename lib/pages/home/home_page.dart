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

  FsMessagePanelController panelController = FsMessagePanelController();

  @override
  void initState() {
    controller = Get.put(HomeController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FsAppBar(
        title: Text('首页'.tr),
      ),
      body: const Center(
        child: Text('首页'),
      ),
    );
  }
}
