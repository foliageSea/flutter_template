import 'package:dart_mappable/dart_mappable.dart';

part 'business_exception.mapper.dart';

/// 业务异常类
/// 用于区分业务逻辑异常和系统异常
@MappableClass()
class BusinessException implements Exception {
  final int code;
  final String message;
  final dynamic data;

  BusinessException({required this.code, required this.message, this.data});

  @override
  String toString() => 'BusinessException: $message (Code: $code)';

  /// 400 - 参数错误
  factory BusinessException.badRequest(String message, {dynamic data}) =>
      BusinessException(code: 400, message: message, data: data);

  /// 401 - 未授权
  factory BusinessException.unauthorized(String message, {dynamic data}) =>
      BusinessException(code: 401, message: message, data: data);

  /// 403 - 权限不足
  factory BusinessException.forbidden(String message, {dynamic data}) =>
      BusinessException(code: 403, message: message, data: data);

  /// 404 - 资源不存在
  factory BusinessException.notFound(String message, {dynamic data}) =>
      BusinessException(code: 404, message: message, data: data);

  /// 409 - 冲突
  factory BusinessException.conflict(String message, {dynamic data}) =>
      BusinessException(code: 409, message: message, data: data);

  /// 422 - 业务逻辑错误
  factory BusinessException.unprocessable(String message, {dynamic data}) =>
      BusinessException(code: 422, message: message, data: data);

  /// 500 - 业务处理失败
  factory BusinessException.internal(String message, {dynamic data}) =>
      BusinessException(code: 500, message: message, data: data);

  factory BusinessException.fromJson(String json) {
    return BusinessExceptionMapper.fromJson(json);
  }
}
