import 'package:core/core.dart';
import 'package:core/src/config/config.dart';
import 'package:dio/dio.dart';

import 'interceptors/dio_auth_interceptor.dart';
import 'interceptors/dio_error_interceptor.dart';

abstract class Requestable extends CommonInitialize {
  void setBaseUrl(String baseUrl);

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
  });

  Future<Response<T>> post<T>(
    String path, {
    Map<String, dynamic>? data,
  });
}

class Request implements Requestable {
  static Request? _instance;

  Request._();

  factory Request() {
    return _instance ??= Request._();
  }

  static Duration connectTimeout = CoreConfig.requestClientConnectTimeout;
  static Duration receiveTimeout = CoreConfig.requestClientReceiveTimeout;

  late Dio _dio;
  String baseUrl = '';

  @override
  Future init() async {
    BaseOptions options = BaseOptions(
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
    );
    _dio = Dio(options);
    var storage = Storage();

    var appLoggerInterceptor = AppLogger().getDioInterceptor();

    _dio.interceptors.addAll([
      DioAuthInterceptor(storage: storage),
      appLoggerInterceptor,
      DioErrorInterceptor(),
    ]);
  }

  @override
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) {
    return _dio.get<T>(path, queryParameters: queryParameters);
  }

  @override
  Future<Response<T>> post<T>(
    String path, {
    Map<String, dynamic>? data,
  }) {
    return _dio.post<T>(path, data: data);
  }

  @override
  void setBaseUrl(String baseUrl) {
    this.baseUrl = baseUrl;
    _dio.options.baseUrl = baseUrl;
  }

  @override
  String getOutput() {
    return 'Request 初始化完成';
  }
}
