import 'package:dio/dio.dart';
import 'package:flutter_template/utils/common.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onRequest(options, handler) {
    return handler.next(options);
  }

  @override
  void onResponse(response, handler) {
    handler.next(response);
  }

  @override
  void onError(err, handler) {
    var message = "";
    switch (err.type) {
      case DioExceptionType.connectionError:
        message = "连接错误, 请检查网络";
        break;
      case DioExceptionType.connectionTimeout:
        message = "连接超时，请检查网络";
        break;
      case DioExceptionType.badResponse:
        final statusCode = err.response?.statusCode;
        message = "错误响应($statusCode)";
        break;
      default:
    }
    if (message.isNotEmpty) {
      showToast(message);
    }
    handler.next(err);
  }
}
