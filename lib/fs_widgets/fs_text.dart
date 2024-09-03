import 'package:flutter/material.dart';
import 'package:flutter_template/themes.dart';

class FsText extends StatefulWidget {
  final String? data;
  final TextStyle? style;
  final int? maxLines;

  const FsText(
    this.data, {
    super.key,
    this.style,
    this.maxLines,
  });

  @override
  State<FsText> createState() => _FsTextState();
}

class _FsTextState extends State<FsText> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.data ?? '-',
      style: widget.style?.copyWith(
        color: ThemeColor(context).textColor,
      ),
      maxLines: widget.maxLines ?? 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
