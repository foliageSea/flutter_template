import 'package:core/src/logger/formatters/custom_logger_formatter.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'dart:developer' as d;

abstract class AppLoggAble {
  void init();

  void log(dynamic message);

  void info(
    dynamic msg, [
    Object? exception,
    StackTrace? stackTrace,
  ]);

  void handle(
    Object exception, [
    StackTrace? stackTrace,
    dynamic msg,
  ]);

  void warning(
    dynamic msg, [
    Object? exception,
    StackTrace? stackTrace,
  ]);
}

class AppLogger implements AppLoggAble {
  static AppLogger? _logger;

  AppLogger._();

  factory AppLogger() {
    _logger ??= AppLogger._();
    return _logger!;
  }

  late Talker _talker;

  Talker get talker => _talker;

  @override
  void init() {
    var talkerLogger = TalkerLogger(
      output: (String message) => d.log(message, name: 'AppLogger'),
      formatter: const CustomLoggerFormatter(),
    );

    _talker = Talker(
      logger: talkerLogger,
      settings: TalkerSettings(
        timeFormat: TimeFormat.yearMonthDayAndTime,
      ),
    );
  }

  @override
  void handle(Object exception, [StackTrace? stackTrace, msg]) {
    msg = msg ?? exception.toString();
    stackTrace = _handleStackTrace(stackTrace);
    _talker.handle(exception, stackTrace, msg);
  }

  @override
  void log(message) {
    _talker.log(message);
  }

  @override
  void info(msg, [Object? exception, StackTrace? stackTrace]) {
    _talker.info(msg, exception, stackTrace);
  }

  // 处理堆栈跟踪
  StackTrace? _handleStackTrace(StackTrace? stackTrace) {
    if (stackTrace != null) {
      final stackLines = stackTrace.toString().split('\n');
      if (stackLines.length > 8) {
        stackTrace = StackTrace.fromString(
            '${stackLines.take(8).join('\n')}\n... (${stackLines.length - 8} more)');
      }
    }
    return stackTrace;
  }

  @override
  void warning(msg, [Object? exception, StackTrace? stackTrace]) {
    _talker.warning(msg, exception, stackTrace);
  }
}
