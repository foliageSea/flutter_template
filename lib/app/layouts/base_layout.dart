import 'package:flutter/material.dart';

class BaseLayout extends StatefulWidget {
  final Widget child;
  final String? title;
  final List<Widget>? actions;

  const BaseLayout({
    super.key,
    required this.child,
    this.title,
    this.actions,
  });

  @override
  State<BaseLayout> createState() => _BaseLayoutState();
}

class _BaseLayoutState extends State<BaseLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.title}'),
      ),
      body: widget.child,
    );
  }
}
