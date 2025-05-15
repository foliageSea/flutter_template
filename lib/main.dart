import 'package:flutter/material.dart';
import 'package:flutter_template/app/routes/app_pages.dart';
import 'package:flutter_template/app/widgets/error_app.dart';
import 'package:get/get.dart';

import 'app/common/global.dart';

void main() async {
  try {
    await Global.init();
    runApp(const MainApp());
  } catch (e) {
    runApp(ErrorApp(error: e));
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: '${Global.appName} ${Global.appVersion}',
      initialRoute: AppPages.initial,
      getPages: AppPages.getRoutes(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
