import 'package:realm/realm.dart';

part 'server_entity.realm.dart';

@RealmModel()
class _ServerEntity {
  @Indexed()
  late ObjectId id;
  late String name;
  late String url;
  late String description;
}
