import 'package:isar/isar.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'log_entity.g.dart';

@collection
class LogEntity {
  Id id = Isar.autoIncrement;
  String? logLevel;
  String? title;
  String? message;
  String? textMessage;
  DateTime? update;
  String? displayException;
  String? displayError;

  LogEntity() {
    update = DateTime.now();
  }

  void setLogLevel(LogLevel? level) {
    logLevel = logLevelMap[level];
  }
}

Map<LogLevel, String> logLevelMap = {
  LogLevel.error: 'error',
  LogLevel.critical: 'critical',
  LogLevel.info: 'info',
  LogLevel.debug: 'debug',
  LogLevel.verbose: 'verbose',
  LogLevel.warning: 'warning',
};
