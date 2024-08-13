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
  final tenantCode = ''.val('tenantCode', getBox: getPrefBox);
  final account = ''.val('account', getBox: getPrefBox);
  final password = ''.val('password', getBox: getPrefBox);
}
