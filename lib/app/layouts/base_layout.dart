import 'package:flutter/material.dart';
import 'package:flutter_template/core/logger/logger.dart';

class BaseLayout extends StatelessWidget {
  final Widget child;
  final String? title;
  final List<Widget>? actions;
  final bool showBackButton;

  const BaseLayout({
    super.key,
    required this.child,
    this.title,
    this.actions,
    this.showBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _buildTitle(context),
        actions: actions,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: child,
        ),
      ),
    );
  }

  Widget? _buildTitle(BuildContext context) {
    onLongPress() {
      AppLogger().toTalkerScreen(context);
    }

    var text = GestureDetector(
      onLongPress: onLongPress,
      child: Text(title!),
    );
    return title != null ? text : null;
  }
}
