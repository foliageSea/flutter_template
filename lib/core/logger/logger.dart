import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'dart:developer' as d;

import 'custom_logger_formatter.dart';

abstract class AppLoggable {
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

class AppLogger implements AppLoggable {
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
      formatter: const CustomLoggerFormatter(),
      output: (String message) => d.log(message, name: 'AppLogger'),
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

extension AppLoggerExtension on AppLogger {
  Future<dynamic> toTalkerScreen(BuildContext context) {
    return Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => TalkerScreen(
        talker: talker,
        isLogsExpanded: false,
      ),
    ));
  }

  Interceptor getDioInterceptor() {
    return TalkerDioLogger(
      settings: const TalkerDioLoggerSettings(
        printRequestHeaders: true,
        printResponseHeaders: true,
        printResponseMessage: true,
      ),
    );
  }
}
