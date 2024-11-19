import 'package:flutter/material.dart';
import 'package:flutter_template/logs/log_interface.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'custom_talker_observer.dart';

class LogIml implements LogInterface {
  late Talker _talker;

  get talker => _talker;

  LogIml() {
    var observer = CustomTalkerObserver();
    _talker = Talker(observer: observer);
  }

  void toTalkerScreen(BuildContext context) {
    showCupertinoModalBottomSheet(
      context: context,
      builder: (context) => TalkerScreen(
        talker: _talker,
        appBarTitle: '日志',
        // appBarLeading: Container(),
      ),
    );
  }

  @override
  void log(message) {
    _talker.log(message);
  }

  @override
  void critical(msg, [Object? exception, StackTrace? stackTrace]) {
    _talker.critical(msg, exception, stackTrace);
  }

  @override
  void debug(msg, [Object? exception, StackTrace? stackTrace]) {
    _talker.debug(msg, exception, stackTrace);
  }

  @override
  void error(msg, [Object? exception, StackTrace? stackTrace]) {
    _talker.error(msg, exception, stackTrace);
  }

  @override
  void handle(Object exception, [StackTrace? stackTrace, msg]) {
    _talker.handle(exception, stackTrace, msg);
  }

  @override
  void info(msg, [Object? exception, StackTrace? stackTrace]) {
    _talker.info(msg, exception, stackTrace);
  }

  @override
  void verbose(msg, [Object? exception, StackTrace? stackTrace]) {
    _talker.verbose(msg, exception, stackTrace);
  }

  @override
  void warning(msg, [Object? exception, StackTrace? stackTrace]) {
    _talker.warning(msg, exception, stackTrace);
  }
}
