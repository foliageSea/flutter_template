import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_template/events/events.dart';
import 'package:flutter_template/logs/log.dart';
import 'package:flutter_template/storages/user_storage.dart';
import 'package:flutter_template/utils/common.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

class DioService extends GetxService {
  static DioService get to => Get.find();

  final Dio _dio = Dio();
  Dio get dio => _dio;

  // 连接超时时间
  static const Duration connectTimeout = Duration(seconds: 10);

  // 响应超时时间 5 min
  static const Duration receiveTimeout = Duration(seconds: 30);

  Future<DioService> init() async {
    _dio.options
      ..connectTimeout = connectTimeout
      ..receiveTimeout = receiveTimeout;

    _dio.interceptors.add(DioInterceptors());

    _dio.interceptors.add(
      TalkerDioLogger(
        settings: const TalkerDioLoggerSettings(
          printRequestHeaders: true,
          printResponseHeaders: true,
          printResponseMessage: true,
        ),
      ),
    );

    return this;
  }
}

class DioInterceptors extends Interceptor {
  @override
  void onRequest(options, handler) {
    final token = Get.find<UserStorage>().token.val;
    final refreshToken = Get.find<UserStorage>().refreshToken.val;
    options.headers.addAll(
      {
        'Authorization': _handleToken(token),
        'X-Authorization': _handleToken(refreshToken),
        'source-client': 'app',
      }..removeWhere((key, value) => value == null),
    );
    return handler.next(options);
  }

  @override
  void onResponse(response, handler) {
    final tokenRW = Get.find<UserStorage>().token;
    final refreshTokenRW = Get.find<UserStorage>().refreshToken;
    final tenantCodeRW = Get.find<UserStorage>().tenantCode;
    late Map<String, dynamic> data;
    if (response.data.runtimeType == String) {
      data = jsonDecode(response.data);
    } else {
      data = response.data;
    }

    if (data['code'] == 401) {
      tokenRW.val = '';
      refreshTokenRW.val = '';
      talker.warning("401 未授权, 请重新登录");

      eventBus.fire(LogoutEvent( msg: '401 未授权, 请重新登录'));
    }

    final accessToken = response.headers['access-token'];
    final xAccessToken = response.headers['x-access-token'];
    if (accessToken != null &&
        accessToken.isNotEmpty &&
        xAccessToken != null &&
        xAccessToken.isNotEmpty) {
      tokenRW.val = accessToken.first;
      refreshTokenRW.val = xAccessToken.first;
    }

    final tenantCode = response.headers['Tenant-Code'];
    if (tenantCode != null && tenantCode.isNotEmpty) {
      tenantCodeRW.val = tenantCode.first;
    }

    handler.next(response);
  }

  @override
  void onError(err, handler) {
    // 统一的异常处理 (状态码: 401, 用户信息过期)
    var message = "";
    if (err.type == DioExceptionType.connectionError) {
      message = "连接错误, 请检查网络";
    }
    if (err.type == DioExceptionType.connectionTimeout) {
      message = "连接超时，请检查网络";
    }

    if (message.isNotEmpty) {
      showSnackBar(message);
    }

    handler.next(err);
  }

  String? _handleToken(String token) {
    if (token.isEmpty) {
      return null;
    }
    return ['Bearer', token].join(' ');
  }
}
