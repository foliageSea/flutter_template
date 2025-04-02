import 'package:flutter/widgets.dart';
import 'package:flutter_template/platform/platform_interface.dart';
import 'package:flutter_template/utils/local_storage.dart';

class Global {
  Global._();

  static const appName = 'flutter_template';

  static Future initApp() async {
    WidgetsFlutterBinding.ensureInitialized();

    await LocalStorage().init();

    await PlatformInterface.getInstance().initApp();
  }

  static Future<String?> getToken() async {
    return LocalStorage().getString(StorageKey.token);
  }

  static Future setToken(String value) async {
    return LocalStorage().setString(StorageKey.token, value);
  }

  static Future removeToken() async {
    return LocalStorage().remove(StorageKey.token);
  }
}
