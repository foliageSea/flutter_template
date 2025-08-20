import 'package:shelf_plus/shelf_plus.dart';

import '../middlewares/auth_middleware.dart';

class ContextUtil {
  static String? getJwtPayloadString(Request request, String key) {
    var payload =
        request.context[AuthMiddleware.contextKey] as Map<String, dynamic>?;
    return payload?[key];
  }

  static int? getJwtPayloadInt(Request request, String key) {
    var payload =
        request.context[AuthMiddleware.contextKey] as Map<String, dynamic>?;
    return payload?[key] as int?;
  }
}
