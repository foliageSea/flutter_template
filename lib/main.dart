import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_template/global.dart';

import 'app.dart';

void main() {
  Global.initApp().then(
    (_) => runApp(
      Phoenix(child: const MainApp()),
    ),
  );
}
