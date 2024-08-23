import 'package:flutter/material.dart';
import 'package:flutter_template/utils/common.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:talker_flutter/talker_flutter.dart';

class CustomTalkerObserver extends TalkerObserver {
  CustomTalkerObserver();

  @override
  void onError(TalkerError err) {
    /// Send data to your error tracking system like Sentry or backend
    super.onError(err);
  }

  @override
  void onException(TalkerException err) {
    /// Send Exception to your error tracking system like Sentry or backend
    showSnackBar('客户端内部错误', detail: '${err.exception}\n' '${err.stackTrace}');
    super.onException(err);
  }

  @override
  void onLog(TalkerData log) {
    /// Send log message to Grafana or backend
    super.onLog(log);
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
