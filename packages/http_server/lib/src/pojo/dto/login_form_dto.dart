import 'package:dart_mappable/dart_mappable.dart';

part 'login_form_dto.mapper.dart';

@MappableClass()
class LoginFormDto {
  String username;
  String password;

  LoginFormDto({this.username = "", this.password = ""});
}
