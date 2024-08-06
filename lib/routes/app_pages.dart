import 'package:flutter_template/pages/home/home_page.dart';
import 'package:flutter_template/pages/setting/setting_page.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  static const install = Routes.setting;

  static final routes = [
    GetPage(
      name: Routes.home,
      page: () => const HomePage(),
    ),
    GetPage(
      name: Routes.setting,
      page: () => const SettingPage(),
    ),
  ];
}
