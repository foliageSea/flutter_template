import 'package:core/core.dart';
import 'package:flutter/material.dart';
import '../common/global.dart';

class BaseLayout extends StatefulWidget {
  final Widget child;
  final String? title;
  final List<Widget>? actions;
  final bool showBackButton;
  final bool useSingleChildScrollView;

  const BaseLayout({
    super.key,
    required this.child,
    this.title,
    this.actions,
    this.showBackButton = true,
    this.useSingleChildScrollView = true,
  });

  @override
  State<BaseLayout> createState() => _BaseLayoutState();
}

class _BaseLayoutState extends State<BaseLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              title: _buildTitle(context),
              actions: widget.actions,
            ),
            body: SafeArea(
              child: _buildUseSingleChildScrollView(),
            ),
          ),
          _buildTag(context)
        ],
      ),
    );
  }

  Widget _buildTag(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var tagWidth = 60.0;
    var left = (screenWidth / 2) - (tagWidth / 2);
    var primaryColor = Theme.of(context).primaryColor;

    return Positioned(
      top: 2,
      left: left,
      child: Row(
        children: [
          Container(
            width: tagWidth,
            height: 20,
            decoration: BoxDecoration(
              color: primaryColor,
              border: Border.all(width: 1, color: primaryColor),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Center(
              child: Text(
                Global.appVersion,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ].insertSizedBoxBetween(width: 4),
      ),
    );
  }

  Widget _buildUseSingleChildScrollView() {
    if (!widget.useSingleChildScrollView) {
      return widget.child;
    }
    return SingleChildScrollView(child: widget.child);
  }

  Widget? _buildTitle(BuildContext context) {
    onTap() {
      AppLogger().toTalkerScreen(context);
    }

    var text = GestureDetector(
      onTap: onTap,
      child: Text(widget.title!),
    );
    return widget.title != null ? text : null;
  }

  // Widget _buildConnectStatus(RxBool isConnect) {
  //   return Obx(
  //     () => Container(
  //       width: 5,
  //       height: 5,
  //       decoration: BoxDecoration(
  //         color: isConnect.value ? Colors.green : Colors.red,
  //         shape: BoxShape.circle,
  //       ),
  //     ),
  //   );
  // }
}
