import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

import 'platform_interface.dart';

class WindowsPlatform implements PlatformInterface {
  @override
  Future initApp() async {
    await WindowManager.instance.ensureInitialized();
    windowManager.waitUntilReadyToShow().then((_) async {
      await windowManager.setTitleBarStyle(
        TitleBarStyle.hidden,
        windowButtonVisibility: false,
      );
      await windowManager.setMinimumSize(const Size(500, 600));
      await windowManager.setAlignment(Alignment.center);
      await windowManager.show();
      await windowManager.setSkipTaskbar(false);
    });
  }
}
