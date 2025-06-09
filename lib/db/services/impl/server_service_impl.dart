import 'dart:developer';

import 'package:flutter_template/app/common/global.dart';
import 'package:flutter_template/db/database.dart';
import 'package:flutter_template/db/repositories/server_repository.dart';
import 'package:realm/realm.dart';

import '../server_service.dart';

class ServerServiceImpl implements ServerService {
  late Realm db;
  late ServerRepository serverRepository;

  ServerServiceImpl() {
    db = Global.getIt<AppDatabase>().db;
    serverRepository = ServerRepository(db);
  }

  @override
  Future<List> getServers() async {
    log('$hashCode');
    return [];
  }
}
