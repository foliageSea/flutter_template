import 'package:flutter_template/db/mapper/base_mapper.dart';
import 'package:objectbox/objectbox.dart';

import '../entity/user.dart';

class UserMapper extends BaseMapper {
  late Box<User> userBox;

  UserMapper(super.db) {
    userBox = db.box<User>();
  }

  Future add(User user) async {
    await userBox.putAsync(user);
  }

  Future<List<User>> list() async {
    return await userBox.getAllAsync();
  }
}
