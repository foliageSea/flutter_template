import 'package:flutter/material.dart';

class FsSplashScreenController extends ChangeNotifier {
  String? text;

  void setText(String t) {
    text = t;
    notifyListeners();
  }
}

///
/// SplashScreen 加载屏
///
class FsSplashScreen extends StatefulWidget {
  final FsSplashScreenController? controller;
  final bool loading;
  final Widget child;

  const FsSplashScreen({
    super.key,
    this.controller,
    required this.loading,
    required this.child,
  });

  @override
  State<FsSplashScreen> createState() => _FsSplashScreenState();
}

class _FsSplashScreenState extends State<FsSplashScreen> {
  String text = '加载中';

  void _handleControllerListener() {
    text = widget.controller!.text!;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    widget.controller?.addListener(_handleControllerListener);
  }

  @override
  void dispose() {
    super.dispose();
    widget.controller?.removeListener(_handleControllerListener);
  }

  Widget _buildSplashScreen(Widget child) {
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
    return _buildSplashScreen(widget.child);
  }
}
