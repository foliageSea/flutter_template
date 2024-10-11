import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreenController {
  ValueNotifier<String> text = ValueNotifier<String>('加载中');

  void setText(String t) {
    text.value = t;
  }
}

///
/// SplashScreen 加载屏
///
class SplashScreen extends StatefulWidget {
  final SplashScreenController? controller;
  final bool loading;
  final Widget child;

  const SplashScreen({
    super.key,
    this.controller,
    required this.loading,
    required this.child,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late SplashScreenController controller;

  @override
  void initState() {
    super.initState();
    controller = widget.controller ?? SplashScreenController();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _buildSplashScreen(Widget child) {
    return widget.loading ? _buildIndicator() : child;
  }

  Scaffold _buildIndicator() {
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
            ValueListenableBuilder(
              valueListenable: controller.text,
              builder: (BuildContext context, String value, Widget? child) {
                return Text(controller.text.value);
              },
            )
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
