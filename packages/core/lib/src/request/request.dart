import 'package:core/core.dart';
import 'package:dio/dio.dart';

import 'interceptors/dio_auth_interceptor.dart';
import 'interceptors/dio_error_interceptor.dart';

abstract class Requestable {
  void init();

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

  static Duration connectTimeout = const Duration(seconds: 10);
  static Duration receiveTimeout = const Duration(seconds: 30);

  late Dio _dio;
  String baseUrl = '';

  @override
  void init() {
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
}
