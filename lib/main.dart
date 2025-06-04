import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'app/common/app.dart';
import 'app/common/global.dart';

void main() async {
  try {
    await Global.init();
    runApp(const MainApp());
  } catch (e, st) {
    runApp(
      ErrorApp(
        error: e,
        stackTrace: st,
      ),
    );
  }
}
