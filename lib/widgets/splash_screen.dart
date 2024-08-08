import 'package:flutter/material.dart';

class SplashScreenController extends ChangeNotifier {
  String? text;

  void setText(String t) {
    text = t;
    notifyListeners();
  }
}

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
  String text = '加载中';

  @override
  void initState() {
    super.initState();

    if (widget.controller != null) {
      widget.controller!.addListener(() {
        text = widget.controller!.text!;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _buildLoadingPage(Widget child) {
    return widget.loading
        ? Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // CupertinoActivityIndicator(),
                  const CircularProgressIndicator(),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(text),
                ],
              ),
            ),
          )
        : child;
  }

  @override
  Widget build(BuildContext context) {
    return _buildLoadingPage(widget.child);
  }
}
