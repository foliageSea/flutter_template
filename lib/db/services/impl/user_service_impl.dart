part 'impl/user_service_impl.dart';

abstract class UserService {
  Future<List<dynamic>> getUsers();
}
