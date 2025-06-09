import 'package:flutter_template/app/common/global.dart';
import 'package:realm/realm.dart';

import '../database.dart';

abstract class BaseRepository {
  late final Realm db;

  BaseRepository() {
    db = Global.getIt<AppDatabase>().db;
  }
}
