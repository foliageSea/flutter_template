import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreenController {
  RxString message = "加载中...".obs;
  RxBool loading = true.obs;

  void updateMessage(String msg) {
    message.value = msg;
    message.refresh();
  }

  void setLoading(bool val) {
    loading.value = val;
    loading.refresh();
  }
}

///
/// SplashScreen 加载屏
///
class SplashScreen extends StatefulWidget {
  final SplashScreenController controller;

  final Widget child;

  const SplashScreen({
    super.key,
    required this.controller,
    required this.child,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _buildSplashScreen(Widget child) {
    var loading = widget.controller.loading;

    return Obx(() => loading.value ? _buildIndicator() : child);
  }

  Scaffold _buildIndicator() {
    var message = widget.controller.message;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icon/icon.png',
              width: 100,
              height: 100,
            ),
            const SizedBox(
              height: 16,
            ),
            const CupertinoActivityIndicator(),
            // const CircularProgressIndicator(),
            const SizedBox(
              height: 8,
            ),
            Obx(() => Text(message.value))
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildSplashScreen(widget.child);
  }
}
