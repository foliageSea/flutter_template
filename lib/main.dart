import 'package:flutter/material.dart';
import 'package:flutter_template/app.dart';
import 'package:flutter_template/global.dart';
import 'package:flutter_template/widgets/error_app.dart';

void main() {
  Global.initApp().then(
    (_) {
      runApp(const MainApp());
    },
    onError: (error) {
      runApp(ErrorApp(error: error));
    },
  );
}
