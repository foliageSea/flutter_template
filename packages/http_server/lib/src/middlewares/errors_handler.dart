import 'package:http_server/src/exceptions/business_exception.dart';
import 'package:http_server/src/result/result.dart';
import 'package:shelf/shelf.dart';
import 'package:core/core.dart' show AppLogger;

// 错误处理中间件 - 区分业务异常和未捕获异常
Middleware errorsHandler() {
  return (Handler handler) {
    return (Request request) async {
      try {
        return await handler(request);
      } catch (e, stackTrace) {
        // 记录异常日志
        _logError(e, stackTrace, request);

        // 区分业务异常和系统异常
        if (e is BusinessException) {
          return _handleBusinessException(e);
        } else {
          return _handleSystemException(e, stackTrace);
        }
      }
    };
  };
}

/// 处理业务异常
Response _handleBusinessException(BusinessException e) {
  final result = Result.error(e.message, code: e.code);
  return result;
}

/// 处理系统异常（未捕获异常）
Response _handleSystemException(dynamic e, StackTrace stackTrace) {
  return Result.internalServerError(e.message);
}

/// 记录错误日志
void _logError(dynamic e, StackTrace stackTrace, Request request) {
  // final timestamp = DateTime.now().toIso8601String();
  // final method = request.method;
  // final url = request.requestedUri;

  // final logEntry = {
  //   'timestamp': timestamp,
  //   'method': method,
  //   'url': url.toString(),
  //   'error': e.toString(),
  //   'stackTrace': stackTrace.toString(),
  // };

  // 这里可以根据需要接入实际的日志系统
  // 例如：logger.error(logEntry);

  // 临时输出到控制台
  // print('[ERROR] $logEntry');
  AppLogger().handle(e, stackTrace);
}
