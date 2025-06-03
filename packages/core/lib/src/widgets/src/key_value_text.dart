import 'package:flutter/material.dart';

class KeyValueText extends StatefulWidget {
  final String keyText;
  final String? valueText;
  final TextStyle? valueTextStyle;

  const KeyValueText(
    this.keyText,
    this.valueText, {
    super.key,
    this.valueTextStyle,
  });

  @override
  State<KeyValueText> createState() => _KeyValueTextState();
}

class _KeyValueTextState extends State<KeyValueText> {
  @override
  Widget build(BuildContext context) {
    const keyTextStyle = TextStyle(fontWeight: FontWeight.bold);

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '${widget.keyText}' ': ',
          style: keyTextStyle,
        ),
        Flexible(
          child: Text(
            widget.valueText ?? '-',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: widget.valueTextStyle,
          ),
        ),
      ],
    );
  }
}
