import '../mappers/server_mapper.dart';
import 'base_repository.dart';

class ServerRepository extends BaseRepository {
  late ServerMapper serverMapper;

  ServerRepository() : super() {
    serverMapper = ServerMapper(db);
  }
}
