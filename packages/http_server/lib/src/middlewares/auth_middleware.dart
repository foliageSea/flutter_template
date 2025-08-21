import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:http_server/src/result/result.dart';
import 'package:http_server/src/utils/jwt_util.dart';
import 'package:shelf/shelf.dart';

class AuthMiddleware {
  static const String _authorizationHeader = 'authorization';
  static const String _bearerPrefix = 'Bearer ';
  static const String contextKey = 'jwtPayload';

  // 白名单路径 - 不需要token验证
  static final List<String> _whiteList = ['user/login'];

  // 创建中间件
  static Middleware create() {
    return (Handler innerHandler) {
      return (Request request) async {
        final path = request.url.path;

        // 检查是否在白名单中
        if (_isInWhitelist(path)) {
          return await innerHandler(request);
        }

        // 获取Authorization头
        final authHeader = request.headers[_authorizationHeader];

        if (authHeader == null || !authHeader.startsWith(_bearerPrefix)) {
          return Result.unauthorized(message: 'Invalid token');
        }

        final token = authHeader.substring(_bearerPrefix.length);

        late Map<String, dynamic> payload;

        try {
          payload = _validateToken(token) as Map<String, dynamic>;
        } on JWTExpiredException {
          return Result.unauthorized(message: 'Invalid token');
        } on JWTException {
          return Result.unauthorized(message: 'Invalid token');
        }

        var changeRequest = request.change(context: {contextKey: payload});

        // Token验证通过，继续处理请求
        return await innerHandler(changeRequest);
      };
    };
  }

  // 检查路径是否在白名单中
  static bool _isInWhitelist(String path) {
    for (final whitePath in _whiteList) {
      if (path == whitePath) {
        return true;
      }
      // 支持前缀匹配
      if (whitePath.endsWith('/') && path.startsWith(whitePath)) {
        return true;
      }
    }
    return false;
  }

  // 验证token有效性
  static dynamic _validateToken(String token) {
    final payload = JwtUtil.verifyToken(token);
    return payload;
  }

  // 添加白名单路径
  static void addToWhitelist(String path) {
    if (!_whiteList.contains(path)) {
      _whiteList.add(path);
    }
  }

  // 从白名单中移除路径
  static void removeFromWhitelist(String path) {
    _whiteList.remove(path);
  }

  // 获取当前白名单
  static List<String> getWhitelist() => List.unmodifiable(_whiteList);
}
