part of '../server_service.dart';

class ServerServiceImpl with AppDatabaseMixin implements ServerService {
  late ServerRepository serverRepository;

  ServerServiceImpl() {
    serverRepository = ServerRepository(db);
  }

  @override
  Future<List> getServers() async {
    return [];
  }
}
