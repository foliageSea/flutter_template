import 'package:flutter/material.dart';

class FsKeyValueText extends StatefulWidget {
  final String keyText;
  final String? valueText;

  const FsKeyValueText(this.keyText, this.valueText, {super.key});

  @override
  State<FsKeyValueText> createState() => _FsKeyValueTextState();
}

class _FsKeyValueTextState extends State<FsKeyValueText> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('${widget.keyText}' ': '),
        Text(widget.valueText ?? '-'),
      ],
    );
  }
}
