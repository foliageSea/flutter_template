part of '../user_service.dart';

@LazySingleton(as: UserService)
class UserServiceImpl implements UserService {
  late UserMapper userMapper;

  UserServiceImpl(AppDatabase db) {
    userMapper = UserMapper(db.store);
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
