import 'package:flutter_template/utils/local_ip.dart';
import 'package:shelf_cors_headers/shelf_cors_headers.dart';
import 'package:shelf_plus/shelf_plus.dart';

import 'controllers/server_controller.dart';
import 'controllers/user_controller.dart';

class Server {
  static ShelfRunContext? context;

  static List<ServerController> controllers = <ServerController>[
    UserController(),
  ];

  static Future run() async {
    var list = await LocalIp.getIp();

    context = await shelfRun(_init,
        defaultEnableHotReload: false, defaultBindAddress: list.first);
  }

  static Handler _init() {
    var app = Router().plus;

    for (var e in controllers) {
      e.registered(app);
    }

    return corsHeaders(headers: {
          ACCESS_CONTROL_ALLOW_ORIGIN: '*',
          'Content-Type': 'application/json;charset=utf-8'
        }) >>
        app.call;
  }

  static Future stop() async {
    context?.close();
  }
}
