import 'package:flutter_template/middlewares/out_of_box_experience_middleware.dart';
import 'package:flutter_template/pages/home/home_page.dart';
import 'package:flutter_template/pages/login/login_page.dart';
import 'package:flutter_template/pages/out_of_box_experience/out_of_box_experience_page.dart';
import 'package:flutter_template/pages/root/root_page.dart';
import 'package:flutter_template/pages/setting/setting_page.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  static const install = Routes.home;

  static final routes = [
    GetPage(
      name: '/',
      page: () => const RootPage(),
      // 参与根导航
      participatesInRootNavigator: true,
      // 防止重复
      preventDuplicates: true,
      children: [
        GetPage(
          name: Routes.home,
          page: () => const HomePage(),
          transition: Transition.cupertino,
          middlewares: [
            OutOfBoxExperienceMiddleware(),
          ],
        ),
        GetPage(
          name: Routes.setting,
          page: () => const SettingPage(),
          transition: Transition.cupertino,
        ),
        GetPage(
          name: Routes.login,
          page: () => const LoginPage(),
          transition: Transition.cupertino,
        ),
        GetPage(
          name: Routes.outOfBoxExperience,
          page: () => const OutOfBoxExperiencePage(),
          transition: Transition.cupertino,
        ),
      ],
    )
  ];
}
