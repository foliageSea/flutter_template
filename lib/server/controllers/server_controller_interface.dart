import 'package:shelf_plus/shelf_plus.dart';

abstract class ServerControllerInterface {
  void registered(RouterPlus app, {Middleware? use}) {}
}
