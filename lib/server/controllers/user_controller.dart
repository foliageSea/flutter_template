import 'package:flutter_template/server/controllers/server_controller.dart';
import 'package:shelf_plus/shelf_plus.dart';

class UserController implements ServerController {
  static const controller = '/user';

  @override
  void registered(RouterPlus app) {
    app.get('$controller/get', get);
  }

  get(Request request) {
    return {
      'ok': true,
      'data': {'name': '张三'}
    };
  }
}
