import 'package:flutter/material.dart';
import 'dart:math' as math;

class FsRotatable extends StatefulWidget {
  const FsRotatable({
    super.key,
    required this.builder,
  });

  final Widget Function(BuildContext context, double width, double height)
      builder;

  @override
  State<FsRotatable> createState() => _FsRotatableState();
}

class _FsRotatableState extends State<FsRotatable> {
  double _angle = 0.0;

  void _rotate() {
    setState(() {
      _angle += math.pi / 2;
      if (_angle >= 2 * math.pi) {
        _angle = 0.0;
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  bool landscape(double turns) {
    if (turns == 0.25 || turns == 0.75) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // 根据约束动态设置宽度和高度
        var width = constraints.maxWidth;
        var height = constraints.maxHeight;
        final turns = _angle / (2 * math.pi);
        var w = landscape(turns) ? height : width;
        var h = landscape(turns) ? width : height;
        print('$w $h');
        return GestureDetector(
          onTap: _rotate,
          child: AnimatedRotation(
            alignment: Alignment.center,
            duration: const Duration(milliseconds: 500),
            turns: turns,
            child: widget.builder(context, w, h),
          ),
        );
      },
    );
  }
}
