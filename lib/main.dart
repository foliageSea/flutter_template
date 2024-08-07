import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_template/global.dart';
import 'package:flutter_template/routes/app_pages.dart';
import 'package:flutter_template/utils/util.dart';
import 'package:flutter_template/widgets/loading_render.dart';
import 'package:get/get.dart';

void main() {
  Global.init().then((value) => runApp(const MainApp()));
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final loading = false.obs;

  Future init() async {
    loading.value = true;
    loading.refresh();

    try {
      await Future.delayed(const Duration(seconds: 2));
    } catch (e) {
    } finally {
      loading.value = false;
      loading.refresh();
    }
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  Widget _renderLoading(Widget child) {
    return Obx(
      () => LoadingRender(
        loading: loading.value,
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Template',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      initialRoute: AppPages.install,
      getPages: AppPages.routes,
      navigatorObservers: [FlutterSmartDialog.observer],
      builder: FlutterSmartDialog.init(
        builder: (context, widget) {
          return _renderLoading(widget!);
        },
      ),
    );
  }
}
