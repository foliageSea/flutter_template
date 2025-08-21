import 'package:shelf_plus/shelf_plus.dart';

abstract class RestController {
  Router getRouter();

  String getController();
}
