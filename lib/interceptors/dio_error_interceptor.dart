import 'package:dio/dio.dart';
import 'package:flutter_template/utils/common.dart';

typedef DioErrorInterceptorFunc = Function(
  DioException err,
  ErrorInterceptorHandler handler,
);

class DioErrorInterceptor extends Interceptor {
  final Map<DioExceptionType, DioErrorInterceptorFunc> errorHandlers = {
    DioExceptionType.connectionTimeout: (err, handler) =>
        showErrorToast("连接超时，请检查网络连接"),
    DioExceptionType.sendTimeout: (err, handler) =>
        showErrorToast("发送请求超时，请稍后重试"),
    DioExceptionType.receiveTimeout: (err, handler) =>
        showErrorToast("接收响应超时，请稍后重试"),
    DioExceptionType.badCertificate: (err, handler) =>
        showErrorToast("证书验证失败，请检查您的网络设置"),
    DioExceptionType.badResponse: (err, handler) =>
        showErrorToast("服务器响应错误，请稍后重试"),
    DioExceptionType.cancel: (err, handler) => showErrorToast("请求已被取消"),
    DioExceptionType.connectionError: (err, handler) =>
        showErrorToast("连接错误，请检查网络状态"),
    DioExceptionType.unknown: (err, handler) => showErrorToast("发生未知错误，请稍后重试"),
  };

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // 统一的异常处理 (状态码: 401, 用户信息过期)
    errorHandlers[err.type]?.call(err, handler);
    handler.next(err);
  }
}
