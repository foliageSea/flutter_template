import 'package:db_isar/src/models/user_model.dart';
import 'package:isar/isar.dart';

class DatabaseConfig {
  static List<CollectionSchema<dynamic>> schemas = [
    UserModelSchema,
  ];
}
