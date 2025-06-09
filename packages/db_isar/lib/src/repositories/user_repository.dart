import 'package:db_isar/src/mappers/user_mapper.dart';
import 'package:db_isar/src/repositories/base_repository.dart';

class UserRepository extends BaseRepository {
  late UserMapper userMapper;

  UserRepository() : super() {
    userMapper = UserMapper(db);
  }
}
