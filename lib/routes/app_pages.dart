import 'package:flutter_template/middlewares/auth_middleware.dart';
import 'package:flutter_template/pages/examples/video_player_example/video_player_example_page.dart';
import 'package:flutter_template/pages/home/home_page.dart';
import 'package:flutter_template/pages/login/login_page.dart';
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
          // middlewares: [
          //   EnsureAuthMiddleware(),
          // ],
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
          middlewares: [
            EnsureAutoAuthedMiddleware(),
          ],
        ),
      ],
    )
  ];
}
