import 'package:flutter/material.dart';

class CustomListView extends ListView {
  final Widget emptyWidget = const Center(child: Text('暂无数据'));
  final int itemCount;

  CustomListView({
    super.key,
    required this.itemCount,
    required IndexedWidgetBuilder super.itemBuilder,
    super.controller,
    super.shrinkWrap,
    super.padding,
    super.physics,
  }) : super.builder(
          itemCount: itemCount,
        );

  @override
  Widget build(BuildContext context) {
    if (itemCount == 0) {
      return emptyWidget;
    } else {
      return super.build(context);
    }
  }
}
