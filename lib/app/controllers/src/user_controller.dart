import 'package:core/core.dart';
import 'package:get/get.dart';

abstract class UserControllerAble {
  Future login();
}

class UserController extends GetxService
    with AppLogMixin, AppMessageMixin
    implements UserControllerAble {
  @override
  Future login() async {}
}
