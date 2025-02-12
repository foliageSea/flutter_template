import 'package:flutter/material.dart';
import 'package:flutter_template/global.dart';
import 'package:flutter_template/routes/app_pages.dart';
import 'package:forui/forui.dart';
import 'package:get/get.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: Global.appName,
      getPages: AppPages.routes,
    );
  }
}
