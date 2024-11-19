import 'package:dio/dio.dart';
import 'package:flutter_template/utils/common.dart';

typedef DioErrorInterceptorFunc = Function(
  DioException err,
  ErrorInterceptorHandler handler,
);

class DioErrorInterceptor extends Interceptor {
  static final Map<DioExceptionType, DioErrorInterceptorFunc> errorHandlers = {
    DioExceptionType.connectionError: (err, handler) {
      var message = "连接错误, 请检查网络";
      showSnackBar(message);
    },
    DioExceptionType.connectionTimeout: (err, handler) {
      var message = "连接超时，请检查网络";
      showSnackBar(message);
    },
    DioExceptionType.receiveTimeout: (err, handler) {
      var message = "响应超时，请检查网络";
      showSnackBar(message);
    },
    DioExceptionType.badResponse: (err, handler) {
      // final path = err.requestOptions.path;
      final statusCode = err.response?.statusCode;
      final statusMessage = err.response?.statusMessage;
      showSnackBar('服务器内部错误($statusCode)', detail: statusMessage);
    },
  };

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // 统一的异常处理 (状态码: 401, 用户信息过期)
    errorHandlers[err.type]?.call(err, handler);
    handler.next(err);
  }
}
