import 'package:realm/realm.dart';

class BaseRepository {
  late Realm db;
  BaseRepository(this.db);
}
