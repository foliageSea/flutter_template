import 'package:realm/realm.dart';

import '../database.dart';

abstract class BaseRepository {
  late final Realm db;

  BaseRepository() {
    db = AppDatabase().db;
  }
}
