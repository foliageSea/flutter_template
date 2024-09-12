part of 'app_pages.dart';

abstract class Routes {
  static const home = _Paths.home;
  static const setting = _Paths.setting;
  static const login = _Paths.login;
}

abstract class _Paths {
  static const home = '/home';
  static const setting = '/setting';
  static const login = '/login';
}
