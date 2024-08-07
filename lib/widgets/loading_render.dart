import 'package:flutter/material.dart';

class LoadingRender extends StatefulWidget {
  final bool loading;
  final Widget child;

  const LoadingRender({
    super.key,
    required this.loading,
    required this.child,
  });

  @override
  State<LoadingRender> createState() => _LoadingRenderState();
}

class _LoadingRenderState extends State<LoadingRender> {
  Widget renderLoading(Widget child) {
    return widget.loading
        ? const Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // CupertinoActivityIndicator(),
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 8,
                  ),
                  Text('初始化'),
                ],
              ),
            ),
          )
        : child;
  }

  @override
  Widget build(BuildContext context) {
    return renderLoading(widget.child);
  }
}
