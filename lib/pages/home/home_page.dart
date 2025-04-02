import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_template/global.dart';
import 'package:flutter_template/pages/home/home_controller.dart';
import 'package:flutter_template/router/router.dart';
import 'package:flutter_template/utils/utils.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(HomeController());
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(
      header: PageHeader(
        title: const Text('首页'),
        commandBar: Button(
            child: const Text('退出登录'),
            onPressed: () async {
              var result = await showConfirmDialog(
                  context: context, title: '询问', content: '是否退出登录?');

              if (result != true) {
                return;
              }

              if (context.mounted) {
                Global.removeToken();
                context.go(Routes.login);
              }
            }),
      ),
      children: [],
    );
  }
}
