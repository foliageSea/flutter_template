import 'package:flutter/material.dart';
import 'package:flutter_template/db/dao/log_dao.dart';
import 'package:flutter_template/db/entity/log_entity.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:talker_flutter/talker_flutter.dart';

class CustomTalkerObserver extends TalkerObserver {
  CustomTalkerObserver();

  @override
  void onError(TalkerError err) {
    /// Send data to your error tracking system like Sentry or backend
    super.onError(err);
    _addRecord(err);
  }

  @override
  void onException(TalkerException err) {
    /// Send Exception to your error tracking system like Sentry or backend
    super.onException(err);
    _addRecord(err);
  }

  @override
  void onLog(TalkerData log) {
    /// Send log message to Grafana or backend
    super.onLog(log);
    _addRecord(log);
  }

  Future _addRecord(TalkerData data) async {
    try {
      var logDao = LogDao();

      var log = LogEntity();
      log.title = data.title;
      log.message = data.message;
      log.displayException = data.displayException.replaceAll('\n', '');
      log.displayError = data.displayError.replaceAll('\n', '');
      log.setLogLevel(data.logLevel);
      log.textMessage = data.generateTextMessage();

      await logDao.add(log);
    } catch (_) {}
  }
}

final observer = CustomTalkerObserver();
final talker = Talker(observer: observer);

void toTalkerScreen(BuildContext context) {
  showCupertinoModalBottomSheet(
    context: context,
    builder: (context) => TalkerScreen(
      talker: talker,
      appBarTitle: '日志',
      // appBarLeading: Container(),
    ),
  );
}
