import 'package:flutter_template/global.dart';
import 'package:flutter_template/storages/storage_mixin.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class UserStorage extends GetxService with StorageMixin {
  static GetStorage getPrefBox() => GetStorage(Global.appName);

  // Init
  Future<UserStorage> init() async {
    return this;
  }

  final token = ''.val('token', getBox: getPrefBox);
  final refreshToken = ''.val('refreshToken', getBox: getPrefBox);
  final account = ''.val('account', getBox: getPrefBox);
  final password = ''.val('password', getBox: getPrefBox);

  bool get isLogin => token.val.isNotEmpty == true;

  @override
  void clearPrefBox() {
    final prefBox = getPrefBox();
    prefBox.remove('token');
    prefBox.remove('refreshToken');
    prefBox.remove('account');
    prefBox.remove('password');
  }

  void clearToken() {
    final prefBox = getPrefBox();
    prefBox.remove('token');
    prefBox.remove('refreshToken');
  }
}
