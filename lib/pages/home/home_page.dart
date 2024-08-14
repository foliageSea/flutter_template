import 'package:flutter/material.dart';
import 'package:flutter_template/pages/home/home_controller.dart';
import 'package:flutter_template/widgets/custom_app_bar.dart';
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
      appBar: const CustomAppBar(
        title: Text('首页'),
      ),
      body: Center(
        child: Column(
          children: [
            Obx(() => Text(controller.version.value)),
          ],
        ),
      ),
    );
  }
}
