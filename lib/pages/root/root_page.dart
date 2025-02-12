import 'package:flutter/material.dart';
import 'package:flutter_template/global.dart';
import 'package:flutter_template/routes/app_pages.dart';
import 'package:forui/forui.dart';
import 'package:get/get.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  @override
  Widget build(BuildContext context) {
    var getRouterOutlet = GetRouterOutlet(
      initialRoute: Routes.home,
      anchorRoute: AppPages.initialRoute,
    );

    return Scaffold(
      body: FScaffold(
        header: FHeader(
          title: const Text(Global.appName),
          actions: [
            FHeaderAction(
              icon: FAssets.icons.bird(),
              onPress: () {},
            ),
          ],
        ),
        content: getRouterOutlet,
      ),
    );
  }
}
