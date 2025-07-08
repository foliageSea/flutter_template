import 'package:core/core.dart';
import 'package:get/get.dart';
import '../features/features.dart';
import '../middlewares/middlewares.dart';
part 'app_routes.dart';

class AppPages {
  static const initial = AppRoutes.oobe;

  static Transition transition = Transition.cupertino;

  static final _routes = [
    GetPage(name: AppRoutes.home, page: () => const HomePage()),
    GetPage(name: AppRoutes.oobe, page: () => const OobePage()),
    GetPage(name: AppRoutes.login, page: () => const LoginPage()),
  ];

  static List<String> whiteList = [AppRoutes.oobe, AppRoutes.login];

  static final List<GetPage<dynamic>> _routesCache = [];

  static List<GetPage<dynamic>> getRoutes() {
    if (_routesCache.isNotEmpty) {
      return _routesCache;
    }

    var storage = Storage();

    final List<GetMiddleware> middlewares = [
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
          transition: transition,
        );
        result.add(route);
      } else {
        final route = GetPage(
          name: r.name,
          page: r.page,
          transition: transition,
        );
        result.add(route);
      }
    }
    _routesCache.add(
      GetPage(
        name: "/",
        page: () => const RootPage(),
        transition: transition,
        participatesInRootNavigator: true,
        preventDuplicates: true,
        children: result,
      ),
    );

    return _routesCache;
  }
}
