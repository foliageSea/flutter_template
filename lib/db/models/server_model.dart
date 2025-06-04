import 'package:realm/realm.dart';

part 'server_model.realm.dart';

@RealmModel()
class _ServerModel {
  @Indexed()
  late ObjectId id;
  late String url;
  late String username;
  late String password;
}
