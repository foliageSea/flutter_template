import 'dart:async';

import 'package:core/src/logger/formatters/custom_logger_formatter.dart';
import 'package:core/src/utils/common_util.dart';
import 'package:flutter/foundation.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'dart:developer' as d;

typedef LogData = TalkerData;
typedef LogError = TalkerError;
typedef LogException = TalkerException;

abstract class Logger {
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

  void error(
    dynamic msg, [
    Object? exception,
    StackTrace? stackTrace,
  ]);
}

class AppLogger implements Logger {
  static AppLogger? _logger;

  AppLogger._() {
    _init();
  }

  factory AppLogger() {
    _logger ??= AppLogger._();
    return _logger!;
  }

  late Talker _talker;

  Talker get talker => _talker;

  late _AppLoggerObserver _observer;

  void _init() {
    var talkerLogger = TalkerLogger(
      output: (String message) {
        // ignore: avoid_print
        kReleaseMode ? print(message) : d.log(message, name: 'AppLogger');
      },
      formatter: const CustomLoggerFormatter(),
    );

    _observer = _AppLoggerObserver();
    _talker = Talker(
      logger: talkerLogger,
      settings: TalkerSettings(
        timeFormat: TimeFormat.yearMonthDayAndTime,
      ),
      observer: _observer,
    );
  }

  @override
  void handle(Object exception, [StackTrace? stackTrace, msg]) {
    msg = msg ?? exception.toString();
    stackTrace = handleStackTrace(stackTrace);
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

  @override
  void warning(msg, [Object? exception, StackTrace? stackTrace]) {
    _talker.warning(msg, exception, stackTrace);
  }

  @override
  void error(msg, [Object? exception, StackTrace? stackTrace]) {
    _talker.error(msg, exception, stackTrace);
  }

  Stream<LoggerObserverData> get stream => _observer.controller.stream;
}

class _AppLoggerObserver implements TalkerObserver {
  final _controller = StreamController<LoggerObserverData>.broadcast();

  StreamController<LoggerObserverData> get controller => _controller;

  void _add(LoggerObserverDataType type, dynamic data) {
    _controller.add(LoggerObserverData(type, data));
  }

  @override
  void onError(LogError err) {
    _add(LoggerObserverDataType.error, err);
  }

  @override
  void onException(LogException err) {
    _add(LoggerObserverDataType.exception, err);
  }

  @override
  void onLog(LogData log) {
    _add(LoggerObserverDataType.log, log);
  }
}

class LoggerObserverData {
  late LoggerObserverDataType type;
  dynamic data;

  LoggerObserverData(this.type, this.data);
}

enum LoggerObserverDataType {
  error,
  exception,
  log,
}
