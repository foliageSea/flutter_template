import 'package:core/core.dart';
import 'package:package_info_plus/package_info_plus.dart';

abstract class PackageInfoUtilAble extends CommonInitialize {
  String getAppName();
  String getPackageName();
  String getVersion();
  int getVersionCode();
}

class PackageInfoUtil implements PackageInfoUtilAble {
  static PackageInfoUtil? _packageInfoUtil;

  PackageInfoUtil._();

  factory PackageInfoUtil() {
    _packageInfoUtil ??= PackageInfoUtil._();
    return _packageInfoUtil!;
  }

  late PackageInfo packageInfo;

  @override
  Future<void> init() async {
    packageInfo = await PackageInfo.fromPlatform();
  }

  @override
  String getAppName() {
    return packageInfo.appName;
  }

  @override
  String getPackageName() {
    return packageInfo.packageName;
  }

  @override
  String getVersion() {
    return packageInfo.version;
  }

  @override
  int getVersionCode() {
    return int.tryParse(packageInfo.version.replaceAll('.', '')) ?? 100;
  }

  @override
  String getOutput() {
    return 'PackageInfoUtil 初始化完成';
  }
}
