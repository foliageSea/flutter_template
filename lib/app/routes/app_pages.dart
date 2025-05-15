import 'package:flutter_template/app/middlewares/auth_middleware.dart';
import 'package:flutter_template/app/middlewares/oobe_middleware.dart';
import 'package:flutter_template/app/features/home/home_page.dart';
import 'package:flutter_template/app/features/login/login_page.dart';
import 'package:flutter_template/app/features/oobe/oobe_page.dart';
import 'package:flutter_template/core/storage/storage.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  static const initial = AppRoutes.home;

  static final _routes = [
    GetPage(
      name: AppRoutes.home,
      page: () => const HomePage(),
    ),
    GetPage(
      name: AppRoutes.oobe,
      page: () => const OobePage(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginPage(),
    ),
  ];

  static List<String> whiteList = [
    AppRoutes.oobe,
    AppRoutes.login,
  ];

  static List<GetPage<dynamic>> getRoutes() {
    var storage = Storage();

    final middlewares = [
      OobeMiddleware(storage: storage),
      AuthMiddleware(storage: storage),
    ];

    List<GetPage<dynamic>> result = [];
    for (var r in _routes) {
      if (!whiteList.contains(r.name)) {
        final route = GetPage(
          name: r.name,
          page: r.page,
          middlewares: middlewares,
        );
        result.add(route);
      } else {
        result.add(r);
      }
    }
    return result;
  }
}
