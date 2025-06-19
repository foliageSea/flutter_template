import 'package:core/core.dart';
import 'package:dio/dio.dart';

class DioErrorInterceptor extends Interceptor with AppLogMixin {
  static const Map<DioExceptionType, String> errorMessages = {
    DioExceptionType.connectionTimeout: '连接服务器超时',
    DioExceptionType.sendTimeout: '发送请求超时',
    DioExceptionType.receiveTimeout: '接收响应超时',
    DioExceptionType.badCertificate: '证书验证失败',
    DioExceptionType.badResponse: '服务器返回错误响应',
    DioExceptionType.cancel: '请求已取消',
    DioExceptionType.connectionError: '连接服务器失败',
    DioExceptionType.unknown: '未知网络错误',
  };

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    error(errorMessages[err.type] ?? '未知错误类型');
    return handler.next(err);
  }
}
