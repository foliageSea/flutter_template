import 'package:flutter_template/logs/log.dart';
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
    try {
      var list = await LocalIp.getIp();

      context = await shelfRun(_init,
          defaultEnableHotReload: false, defaultBindAddress: list.first);

      talker.info('Sever running on http://${list.first}:8080');
    } catch (e) {
      talker.error('Sever run error: $e');
    }
  }

  static Handler _init() {
    var app = Router().plus;

    app.get('/', () {
      return 'Sever running...';
    });

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
