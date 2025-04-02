import 'package:flutter/widgets.dart';
import 'package:flutter_template/platform/platform_interface.dart';

class Global {
  Global._();

  static const appName = 'flutter_template';

  static Future initApp() async {
    WidgetsFlutterBinding.ensureInitialized();

    await PlatformInterface.getInstance().initApp();
  }
}
