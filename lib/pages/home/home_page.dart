import 'package:flutter/material.dart';
import 'package:flutter_template/fs_widgets/fs_widgets.dart';
import 'package:flutter_template/pages/home/home_controller.dart';
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
    return const Scaffold(
      appBar: FsAppBar(
        title: '首页',
      ),
      body: Center(
        child: Text('首页'),
      ),
    );
  }
}
