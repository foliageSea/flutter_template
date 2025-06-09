import 'package:isar/isar.dart';

import '../database.dart';

abstract class BaseRepository {
  late final Isar db;

  BaseRepository() {
    db = AppDatabase().db;
  }
}
