import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_template/pages/home/home_page.dart';
import 'package:flutter_template/routes/app_routes.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: AppRoutes.home,
  routes: [
    GoRoute(
      path: AppRoutes.home,
      builder: (context, state) => const HomePage(),
      redirect: redirectHandler,
    ),
  ],
);

FutureOr<String?> redirectHandler(BuildContext context, GoRouterState state) {
  return null;
}
