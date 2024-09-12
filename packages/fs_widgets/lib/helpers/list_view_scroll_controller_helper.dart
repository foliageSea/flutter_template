import 'package:flutter/material.dart';

/// ListView滚动到指定项的辅助类
class ListViewScrollControllerHelper {
  ScrollController scrollController;
  double selectedItemHeight;
  double selectedItemInterval;
  int itemCount;

  /// 构造函数
  ///
  /// [scrollController] ListView的滚动控制器
  /// [selectedItemHeight] 选中项的高度
  /// [selectedItemInterval] 选中项与相邻项之间的间隔
  /// [itemCount] 列表项的总数
  ListViewScrollControllerHelper({
    required this.scrollController,
    required this.selectedItemHeight,
    required this.selectedItemInterval,
    required this.itemCount,
  });

  /// 滚动到指定项
  void scrollToSelectedItem(int index) {
    if (index < 0 || index >= itemCount) return;

    if (scrollController.hasClients) {
      final maxScrollExtent = scrollController.position.maxScrollExtent;
      final itemHeight =
          selectedItemHeight + selectedItemInterval * 2; // 每个项的高度，根据您的布局调整
      final targetOffset = index * itemHeight;

      // 获取当前滚动位置
      final currentOffset = scrollController.offset;

      // 获取视图的高度
      final viewportHeight = scrollController.position.viewportDimension;

      // 计算目标项的下边缘偏移量
      final targetBottomEdge = targetOffset + itemHeight;

      // 如果目标项完全在当前视图范围内，则无需滚动
      if (targetOffset >= currentOffset &&
          targetBottomEdge <= currentOffset + viewportHeight) {
        return;
      }

      double scrollToOffset;

      // 如果目标项在当前视图的上方，则将其滚动到可视区域的顶部
      if (targetOffset < currentOffset) {
        scrollToOffset = targetOffset;
      }
      // 如果目标项在当前视图的下方，则将其滚动到可视区域的底部
      else if (targetBottomEdge > currentOffset + viewportHeight) {
        scrollToOffset = targetBottomEdge - viewportHeight;
      }
      // 否则，目标项已经在视图范围内，不需要滚动
      else {
        return;
      }

      // 确保目标偏移量不超出可滚动区域的范围
      final clampedOffset = scrollToOffset.clamp(0.0, maxScrollExtent);

      scrollController.animateTo(
        clampedOffset,
        duration: const Duration(milliseconds: 800), // 滚动动画的持续时间
        curve: Curves.easeInOut, // 滚动动画的曲线
      );
    }
  }

  /// 滚动到指定项的顶部
  void scrollToSelectedItemTop(int index) {
    if (!(index <= itemCount - 1)) return;

    if (scrollController.hasClients) {
      final maxScrollExtent = scrollController.position.maxScrollExtent;
      // print(maxScrollExtent);
      final itemHeight =
          selectedItemHeight + selectedItemInterval * 2; // 每个项的高度，根据您的布局调整
      final targetOffset = index * itemHeight;
      // 确保目标偏移量不超出可滚动区域的范围
      final clampedOffset = targetOffset.clamp(0.0, maxScrollExtent);
      scrollController.animateTo(
        clampedOffset,
        duration: const Duration(milliseconds: 800), // 滚动动画的持续时间
        curve: Curves.easeInOut, // 滚动动画的曲线
      );
    }
  }
}
