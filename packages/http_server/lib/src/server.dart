import 'dart:io';

import 'package:http_server/src/controllers/user_controller.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_plus/shelf_plus.dart';
import 'package:shelf_cors_headers/shelf_cors_headers.dart';

import 'middlewares/auth_middleware.dart';
import 'middlewares/errors_handler.dart';

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

    final app = Router().plus;

    var apiHandler = _createApiHandler();
    var staticHandler = _createStaticHandler(webPath);

    app.mount('/api', apiHandler);
    if (staticHandler != null) {
      app.mount('/', staticHandler);
    }

    server = await io.serve(app.call, host, port);
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
    return 'http://$_defaultHost:$_defaultPort';
  }

  static Handler _createApiHandler() {
    final router = Router().plus;
    // 注册API路由
    router.mount(UserController.controller, UserController().router.call);
    // 配置中间件
    Handler handler = const Pipeline()
        .addMiddleware(corsHeaders())
        .addMiddleware(logRequests())
        .addMiddleware(errorsHandler())
        .addMiddleware(AuthMiddleware.create())
        .addHandler(router.call);

    return handler;
  }

  static Handler? _createStaticHandler(String? webPath) {
    Handler? handler;
    // 静态文件服务
    if (webPath != null) {
      var staticHandler = createStaticHandler(
        webPath,
        defaultDocument: 'index.html',
      );
      handler = const Pipeline().addHandler(staticHandler);
    }
    return handler;
  }
}
