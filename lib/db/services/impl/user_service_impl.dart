part of '../user_service.dart';

class UserServiceImpl extends UserService with AppDatabaseMixin {
  late UserMapper userMapper;

  UserServiceImpl() {
    userMapper = UserMapper(db);
  }

  @override
  Future add(User user) {
    return userMapper.add(user);
  }

  @override
  Future<List<User>> list() {
    return userMapper.list();
  }
}
