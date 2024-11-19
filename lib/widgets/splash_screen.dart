import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreenController {
  ValueNotifier<String> message = ValueNotifier("加载中...");
  ValueNotifier<bool> loading = ValueNotifier(true);

  void start() {
    loading.value = true;
  }

  void finish() {
    loading.value = false;
  }

  void setMessage(String message) {
    this.message.value = message;
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

    return ValueListenableBuilder(
      valueListenable: loading,
      builder: (BuildContext context, value, _) {
        return value ? _buildIndicator() : child;
      },
    );
  }

  Widget _buildIndicator() {
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
            _buildMessage(message)
          ],
        ),
      ),
    );
  }

  Widget _buildMessage(ValueNotifier<String> message) {
    return ValueListenableBuilder(
      valueListenable: message,
      builder: (BuildContext context, String value, _) {
        return Text(value);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildSplashScreen(widget.child);
  }
}
