import 'package:flutter_template/core/logger/logger.dart';

mixin AppLogMixin {
  void Function(dynamic message) log = AppLogger().log;
  void Function(dynamic message) info = AppLogger().info;
  void Function(dynamic message) warning = AppLogger().warning;
}
