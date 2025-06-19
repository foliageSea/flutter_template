import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

abstract class PermissionUtil {
  Future requestPermissions();

  static PermissionUtil getInstance() {
    if (Platform.isAndroid) {
      return PermissionUtilAndroid();
    }
    return PermissionUtilOther();
  }
}

class PermissionUtilAndroid implements PermissionUtil {
  static PermissionUtilAndroid? _permissionUtil;

  PermissionUtilAndroid._();

  factory PermissionUtilAndroid() {
    _permissionUtil ??= PermissionUtilAndroid._();
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

class PermissionUtilOther implements PermissionUtil {
  @override
  Future requestPermissions() async {}
}
