import 'package:shelf_cors_headers/shelf_cors_headers.dart';
import 'package:shelf_plus/shelf_plus.dart';
import 'package:shelf_router/shelf_router.dart' as r;

import 'controllers/server_controller.dart';
import 'controllers/user_controller.dart';

class Server {
  static ShelfRunContext? context;

  static List<ServerController> controllers = <ServerController>[
    UserController(),
  ];

  static Future run() async {
    context = await shelfRun(_init, defaultEnableHotReload: false);
  }

  static Handler _init() {
    var app = r.Router().plus;

    for (var e in controllers) {
      e.registered(app);
    }

    return corsHeaders() >> app;
  }

  static Future stop() async {
    context?.close();
  }
}
