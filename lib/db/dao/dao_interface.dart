import 'package:flutter_template/services/db_service.dart';
import 'package:isar/isar.dart';

class DaoInterface {
  Isar get db => DbService.to.database;
}
