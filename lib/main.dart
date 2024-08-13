import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_template/events/events.dart';
import 'package:flutter_template/global.dart';
import 'package:flutter_template/routes/app_pages.dart';
import 'package:flutter_template/utils/utils.dart';
import 'package:flutter_template/widgets/widgets.dart';
import 'package:get/get.dart';

void main() {
  Global.initApp().then((value) => runApp(const MainApp()));
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final splashScreenStatus = false.obs;
  final splashScreenController = SplashScreenController();

  void setSplashScreenStatus(bool status) {
    splashScreenStatus.value = status;
    splashScreenStatus.refresh();
  }

  @override
  void initState() {
    super.initState();
    Global.initService(setSplashScreenStatus, splashScreenController);

    eventBus.on<LogoutEvent>().listen((event) {
      showToast(event.msg);
      // TODO 跳转到登录页
    });
  }

  Widget _renderSplashScreen(Widget child) {
    return Obx(
      () => SplashScreen(
        controller: splashScreenController,
        loading: splashScreenStatus.value,
        child: child,
      ),
    );
  }

  Widget _builder(BuildContext context, Widget? child) {
    // 渲染结构: ScreenUtilInit->GetMaterialApp->MediaQuery->FlutterSmartDialog->_renderLoading
    final c = FlutterSmartDialog.init(
      builder: (context, child) {
        return _renderSplashScreen(child!);
      },
    )(context, child);

    return MediaQuery(
      /// 设置文字大小不随系统设置改变
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: c,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1080, 1920),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => GetMaterialApp(
        title: 'Flutter Template',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        initialRoute: AppPages.install,
        getPages: AppPages.routes,
        navigatorObservers: [FlutterSmartDialog.observer],
        builder: _builder,
      ),
    );
  }
}
