import 'package:core/core.dart';

mixin AppLogMixin {
  void Function(dynamic message) log = AppLogger().log;
  void Function(dynamic message) info = AppLogger().info;
  void Function(dynamic message) warning = AppLogger().warning;
  void Function(Object exception, [StackTrace? stackTrace, dynamic msg])
      handle = AppLogger().handle;
}
