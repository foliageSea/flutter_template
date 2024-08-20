import 'package:flutter/material.dart';

class FsText extends StatefulWidget {
  final String? data;

  const FsText(this.data, {super.key});

  @override
  State<FsText> createState() => _FsTextState();
}

class _FsTextState extends State<FsText> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.data ?? '-');
  }
}
