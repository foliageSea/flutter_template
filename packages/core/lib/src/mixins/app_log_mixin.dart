import 'package:core/core.dart';

mixin AppLogMixin {
  void log(dynamic message) => AppLogger().log(message);
  void info(dynamic message) => AppLogger().info(message);
  void warning(dynamic message) => AppLogger().warning(message);
  void handle(Object exception, [StackTrace? stackTrace, dynamic msg]) =>
      AppLogger().handle(exception, stackTrace, msg);
  void error(
    dynamic msg, [
    Object? exception,
    StackTrace? stackTrace,
  ]) =>
      AppLogger().error(msg, exception, stackTrace);
}
