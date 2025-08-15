import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_cors_headers/shelf_cors_headers.dart';
import 'routes/api_routes.dart';
import 'services/static_file_service.dart';

class Server {
  static const _defaultPort = 8080;
  static const _defaultHost = 'localhost';

  Server._();

  static bool get isRunning => server != null;

  static HttpServer? server;

  static Future<void> start({
    String host = _defaultHost,
    int port = _defaultPort,
    String? webPath,
  }) async {
    if (server != null) {
      // ignore: avoid_print
      print('HTTP服务器已经在运行中');
      return;
    }

    final router = Router();

    // 注册API路由
    final apiRoutes = ApiRoutes();
    router.mount('/api', apiRoutes.router.call);

    // 静态文件服务
    if (webPath != null) {
      final staticService = StaticFileService(webPath);
      router.get('/<path|.*>', staticService.handler);
    }

    // 配置中间件
    final handler = const Pipeline()
        .addMiddleware(corsHeaders())
        .addMiddleware(logRequests())
        .addHandler(router.call);

    server = await io.serve(handler, host, port);
    // ignore: avoid_print
    print('HTTP服务器启动在 http://${server!.address.host}:${server!.port}');
  }

  static Future<void> stop() async {
    // ignore: avoid_print
    if (server != null) {
      await server!.close();
      server = null;
    }
    print('HTTP服务器已停止');
  }

  static String? get serverUrl {
    return 'http://localhost:8080';
  }
}
