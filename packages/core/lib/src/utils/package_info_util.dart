import 'package:core/core.dart';
import 'package:package_info_plus/package_info_plus.dart';

abstract class PackageInfoUtilAble {
  Future<void> init();

  String getAppName();
  String getPackageName();
  String getVersion();
  int getVersionCode();
}

class PackageInfoUtil with AppLogMixin implements PackageInfoUtilAble {
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
    var version = getVersion();
    log('应用版本: $version');
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
}
