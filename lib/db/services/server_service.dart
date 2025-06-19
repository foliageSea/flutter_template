import '../database.dart';
import '../repositories/server_repository.dart';

part 'impl/server_service_impl.dart';

abstract class ServerService {
  Future<List<dynamic>> getServers();
}
