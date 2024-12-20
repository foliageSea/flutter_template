import 'package:flutter_template/server/controllers/server_controller_interface.dart';
import 'package:shelf_plus/shelf_plus.dart';

class UserController implements ServerControllerInterface {
  static const controller = '/user';

  @override
  void registered(RouterPlus app, {Middleware? use}) {
    app.get('$controller/get', get, use: use);
  }

  get(Request request) {
    return {
      'status': 200,
      'ok': true,
      'data': {'name': '张三'}
    };
  }
}
