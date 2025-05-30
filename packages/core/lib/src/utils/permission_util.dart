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

  final List<Permission> permissions = [
    /// 忽略电池优化权限
    /// <uses-permission android:name="android.permission.REQUEST_IGNORE_BATTERY_OPTIMIZATIONS" />
    Permission.ignoreBatteryOptimizations,

    /// 通知权限
    /// <uses-permission android:name="android.permission.ACCESS_NOTIFICATION_POLICY"/>
    Permission.notification,

    /// 安装应用权限
    /// <uses-permission android:name="android.permission.REQUEST_INSTALL_PACKAGES" />
    Permission.requestInstallPackages,
  ];

  @override
  Future requestPermissions() async {
    for (var permission in permissions) {
      final status = await permission.status;
      if (status.isDenied) {
        await permission.request();
      }
    }
  }
}
