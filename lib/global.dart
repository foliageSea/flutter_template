import 'package:flutter/widgets.dart';
import 'package:window_manager/window_manager.dart';

class Global {
  Global._();

  static const appName = 'flutter_template';

  static Future initApp() async {
    WidgetsFlutterBinding.ensureInitialized();

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
