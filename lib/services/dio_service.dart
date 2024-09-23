import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_template/logs/log.dart';
import 'package:flutter_template/storages/user_storage.dart';
import 'package:get/get.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

class DioService extends GetxService {
  static DioService get to => Get.find();

  final Dio _dio = Dio();

  Dio get dio => _dio;

  Function(String message)? onErrorMessage;

  // 连接超时时间
  static const Duration connectTimeout = Duration(seconds: 10);

  // 响应超时时间 5 min
  static const Duration receiveTimeout = Duration(seconds: 30);

  Future<DioService> init() async {
    _dio.options
      ..connectTimeout = connectTimeout
      ..receiveTimeout = receiveTimeout;

    _dio.interceptors.add(DioInterceptors(onErrorMessage: onErrorMessage));

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
  Function(String message)? onErrorMessage;

  DioInterceptors({this.onErrorMessage});

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
    late Map<String, dynamic> data;
    if (response.data.runtimeType == String) {
      data = jsonDecode(response.data);
    } else {
      data = response.data;
    }

    if (data['code'] == 401) {
      Get.find<UserStorage>().clearToken();
      talker.warning("登录失效，请重新登录");
      onErrorMessage?.call('登录失效，请重新登录');
      handler.next(response);
      return;
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

    handler.next(response);
  }

  @override
  void onError(err, handler) {
    // 统一的异常处理 (状态码: 401, 用户信息过期)
    var message = "";
    if (err.type == DioExceptionType.connectionError) {
      message = "连接错误, 请检查网络";
      onErrorMessage?.call(message);
      handler.next(err);
      return;
    }

    if (err.type == DioExceptionType.connectionTimeout) {
      message = "连接超时，请检查网络";
      onErrorMessage?.call(message);
      handler.next(err);
      return;
    }

    if (err.type == DioExceptionType.badResponse) {
      // final path = err.requestOptions.path;
      final statusCode = err.response?.statusCode;
      // final statusMessage = err.response?.statusMessage;
      onErrorMessage?.call('服务器内部错误($statusCode)');
      handler.next(err);
      return;
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
