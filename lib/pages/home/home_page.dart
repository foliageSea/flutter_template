import 'package:flutter/material.dart';
import 'package:flutter_template/logs/log.dart';
import 'package:flutter_template/pages/home/home_controller.dart';
import 'package:flutter_template/routes/app_pages.dart';
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
      appBar: AppBar(
        title: const Text('首页'),
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed(Routes.setting);
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            const Text('首页...'),
            FilledButton(
                onPressed: () {
                  try {
                    throw Exception('测试');
                  } catch (e, st) {
                    LOGGER.handle(e, st);
                  }
                },
                child: const Text('测试'))
          ],
        ),
      ),
    );
  }
}
