import 'package:dio/dio.dart';
import 'package:flutter_template/interceptors/dio_error_interceptor.dart';
import 'package:flutter_template/interceptors/logger_interceptor.dart';

abstract class IRequest {
  void updateBaseUrl(String url);

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
  });

  Future<Response<T>> post<T>(
    String path, {
    Map<String, dynamic>? data,
  });
}

class Request extends IRequest {
  static Request? _request;
  static Duration sendTimeout = const Duration(seconds: 10);
  static Duration receiveTimeout = const Duration(seconds: 10);

  late Dio _dio;

  Request._() {
    _dio = Dio();
    _dio.options.sendTimeout = sendTimeout;
    _dio.options.receiveTimeout = receiveTimeout;
    _dio.interceptors.addAll([
      LoggerInterceptor(),
      DioErrorInterceptor(),
    ]);
  }

  factory Request() {
    _request ??= Request._();
    return _request!;
  }

  @override
  void updateBaseUrl(String url) {
    _dio.options.baseUrl = url;
  }

  @override
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) {
    return _dio.get(
      path,
      queryParameters: queryParameters,
    );
  }

  @override
  Future<Response<T>> post<T>(String path, {Map<String, dynamic>? data}) {
    return _dio.post(path, data: data);
  }
}
