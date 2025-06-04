import 'package:realm/realm.dart';

import '../entity/server_entity.dart';

class ServerMapper {
  late Realm db;

  ServerMapper(this.db);

  Future add(ServerEntity server) {
    return db.writeAsync(() {
      db.add(server);
    });
  }

  List<ServerEntity> list() {
    return db.all<ServerEntity>().toList();
  }

  Future deleteAll() {
    return db.writeAsync(() {
      db.deleteMany(list());
    });
  }
}
