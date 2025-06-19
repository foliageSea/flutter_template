import 'dart:async';

import 'package:core/src/logger/formatters/custom_logger_formatter.dart';
import 'package:core/src/utils/common_util.dart';
import 'package:flutter/foundation.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'dart:developer' as d;

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

  late CustomObserver _customObserver;

  void _init() {
    var talkerLogger = TalkerLogger(
      output: (String message) {
        // ignore: avoid_print
        kReleaseMode ? print(message) : d.log(message, name: 'AppLogger');
      },
      formatter: const CustomLoggerFormatter(),
    );

    _customObserver = CustomObserver();
    _talker = Talker(
      logger: talkerLogger,
      settings: TalkerSettings(
        timeFormat: TimeFormat.yearMonthDayAndTime,
      ),
      observer: _customObserver,
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

  Stream<TalkerException> get exceptionStream =>
      _customObserver.onExceptionStream;
  Stream<TalkerData> get logStream => _customObserver.onLogStream;
}

class CustomObserver implements TalkerObserver {
  final _exceptionController = StreamController<TalkerException>.broadcast();
  final _logController = StreamController<TalkerData>.broadcast();

  Stream<TalkerException> get onExceptionStream => _exceptionController.stream;
  Stream<TalkerData> get onLogStream => _logController.stream;

  @override
  void onError(TalkerError err) {
    // TODO: implement onError
  }

  @override
  void onException(TalkerException err) {
    _exceptionController.add(err);
  }

  @override
  void onLog(TalkerData log) {
    _logController.add(log);
  }
}
