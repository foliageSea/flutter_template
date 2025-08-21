import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../logger.dart';

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
      talker: talker,
      settings: const TalkerDioLoggerSettings(
        printRequestHeaders: true,
        printResponseHeaders: true,
        printResponseMessage: true,
      ),
    );
  }
}
