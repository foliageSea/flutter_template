import 'package:flutter_template/pages/home/home_page.dart';
import 'package:flutter_template/pages/root/root_page.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  static const initialRoute = '/';

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
        ),
      ],
    )
  ];
}
