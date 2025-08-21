import 'package:flutter/material.dart';

class CustomText extends Text {
  final String? text;
  const CustomText(this.text, {super.key}) : super(text ?? "-");
}
