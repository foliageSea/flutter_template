import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:flutter_template/global.dart';
import 'package:flutter_template/pages/about/about_page.dart';
import 'package:flutter_template/pages/home/home_page.dart';
import 'package:flutter_template/pages/login/login_page.dart';
import 'package:flutter_template/pages/root/root_page.dart';
import 'package:go_router/go_router.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: Routes.home,
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => RootPage(
        shellContext: _shellNavigatorKey.currentContext,
        child: child,
      ),
      routes: generateRoutes(),
    )
  ],
  redirect: redirect,
);

/// 生成路由
List<RouteBase> generateRoutes() {
  return [
    GoRoute(
      path: Routes.home,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const HomePage(),
        transitionDuration: transitionDuration, // 动画时长
        transitionsBuilder: transitionsBuilder,
      ),
    ),
    GoRoute(
      path: Routes.login,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const LoginPage(),
        transitionDuration: transitionDuration,
        transitionsBuilder: transitionsBuilder,
      ),
    ),
    GoRoute(
      path: Routes.about,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const AboutPage(),
        transitionDuration: transitionDuration,
        transitionsBuilder: transitionsBuilder,
      ),
    ),
  ];
}

/// 动画时长
Duration transitionDuration = const Duration(milliseconds: 300);

/// 过渡动画
Widget transitionsBuilder(context, animation, secondaryAnimation, child) {
  return Stack(
    children: [
      FadeTransition(
        opacity: Tween<double>(begin: 1.0, end: 0.5).animate(CurvedAnimation(
          parent: secondaryAnimation,
          curve: Curves.easeOut,
        )),
      ),
      SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1.0, 0.0),
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutQuart,
        )),
        child: FadeTransition(
          opacity: animation,
          child: child,
        ),
      ),
    ],
  );
}

/// 路由拦截
FutureOr<String?> redirect(context, state) async {
  String? fullPath = state.fullPath;
  if (whiteList.contains(fullPath)) {
    return null;
  }

  if ((await Global.getToken()) == null) {
    return Routes.login;
  }

  return null;
}

/// 白名单
final List<String> whiteList = [Routes.login];

/// 路由
class Routes {
  Routes._();
  static String get home => '/home';
  static String get login => '/login';
  static String get about => '/about';
}
