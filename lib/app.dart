import 'package:flutter/material.dart';
import 'package:flutter_template/global.dart';
import 'package:flutter_template/routes/routes.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: Global.appName,
      routerConfig: router,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      builder: (context, child) {
        return EagerInitialization(
          child: child ?? Container(),
        );
      },
    );
  }
}
