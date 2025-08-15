import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class ApiRoutes {
  Router get router {
    final router = Router();

    // 健康检查
    router.get('/health', (Request request) {
      return Response.ok(jsonEncode({
        'status': 'ok',
        'timestamp': DateTime.now().toIso8601String(),
      }));
    });

    // 获取应用信息
    router.get('/info', (Request request) {
      return Response.ok(jsonEncode({
        'appName': 'flutter_template',
        'version': '1.0.0',
        'platform': 'mobile',
      }));
    });

    // 示例数据接口
    router.get('/data', (Request request) {
      final data = [
        {'id': 1, 'name': '项目1', 'value': 100},
        {'id': 2, 'name': '项目2', 'value': 200},
        {'id': 3, 'name': '项目3', 'value': 300},
      ];
      return Response.ok(jsonEncode(data));
    });

    return router;
  }
}