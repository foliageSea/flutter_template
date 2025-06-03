import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.decoration,
    this.color,
  });

  final Widget child;
  final double? width;
  final double? height;
  final Decoration? decoration;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    var boxDecoration = BoxDecoration(
      color: color ?? Theme.of(context).primaryColor.withOpacity(0.2),
      borderRadius: const BorderRadius.all(
        Radius.circular(10),
      ),
    );

    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(8),
      decoration: decoration ?? boxDecoration,
      child: child,
    );
  }
}
