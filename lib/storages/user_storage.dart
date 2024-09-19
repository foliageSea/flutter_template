import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class UserStorage extends GetxService {
  static const container = 'UserStorage';

  static GetStorage getPrefBox() => GetStorage(container);

  // Init
  Future<UserStorage> init() async {
    await GetStorage.init(container);
    return this;
  }

  final token = ''.val('token', getBox: getPrefBox);
  final refreshToken = ''.val('refreshToken', getBox: getPrefBox);
  final account = ''.val('account', getBox: getPrefBox);
  final password = ''.val('password', getBox: getPrefBox);

  bool get isLogin => token.val.isNotEmpty == true;

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
