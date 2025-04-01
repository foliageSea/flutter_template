import 'package:flutter/widgets.dart';
import 'package:flutter_template/pages/about/about_page.dart';
import 'package:flutter_template/pages/home/home_page.dart';
import 'package:flutter_template/pages/root/root_page.dart';
import 'package:go_router/go_router.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: '/',
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => RootPage(
        shellContext: _shellNavigatorKey.currentContext,
        child: child,
      ),
      routes: [
        GoRoute(path: '/', builder: (context, state) => const HomePage()),
        GoRoute(path: '/about', builder: (context, state) => const AboutPage()),
      ],
    )
  ],
);
