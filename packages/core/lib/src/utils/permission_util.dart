import 'package:permission_handler/permission_handler.dart';

abstract class PermissionUtilAble {
  Future requestPermissions();
}

class PermissionUtil implements PermissionUtilAble {
  static PermissionUtil? _permissionUtil;

  PermissionUtil._();

  factory PermissionUtil() {
    _permissionUtil ??= PermissionUtil._();
    return _permissionUtil!;
  }

  @override
  Future requestPermissions() async {
    /// 忽略电池优化权限
    /// <uses-permission android:name="android.permission.REQUEST_IGNORE_BATTERY_OPTIMIZATIONS" />
    var status = await Permission.ignoreBatteryOptimizations.status;
    if (status.isDenied) {
      await Permission.ignoreBatteryOptimizations.request();
    }

    /// 通知权限
    /// <uses-permission android:name="android.permission.ACCESS_NOTIFICATION_POLICY"/>
    status = await Permission.notification.status;
    if (status.isDenied) {
      await Permission.notification.request();
    }

    /// 安装应用权限
    /// <uses-permission android:name="android.permission.REQUEST_INSTALL_PACKAGES" />
    status = await Permission.requestInstallPackages.status;
    if (status.isDenied) {
      await Permission.requestInstallPackages.request();
    }
  }
}
