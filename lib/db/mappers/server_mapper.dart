import '../db.dart';

class ServerMapper {
  late AppDatabase db;

  ServerMapper(this.db);

  Future add(ServerEntityCompanion data) async {
    await db.into(db.serverEntity).insert(data);
  }
}
