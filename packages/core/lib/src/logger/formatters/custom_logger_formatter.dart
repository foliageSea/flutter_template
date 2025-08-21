import 'package:talker_flutter/talker_flutter.dart';

class CustomLoggerFormatter implements LoggerFormatter {
  const CustomLoggerFormatter();

  @override
  String fmt(LogDetails details, TalkerLoggerSettings settings) {
    var msg = details.message?.toString() ?? '';
    // msg = msg.replaceFirst('StackTrace: ', 'StackTrace:\n');

    var list = msg.split('StackTrace: ');
    if (list.length > 1) {
      msg = list[0];
      msg += 'StackTrace:\n';
      msg += list[1];
      msg = msg.substring(0, msg.length - 1);
    }

    return msg;
  }
}
