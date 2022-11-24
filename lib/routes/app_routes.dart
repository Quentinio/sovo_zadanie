part of 'app_pages.dart';

abstract class Routes {
  Routes._();

  static const AUTH = _Paths.AUTH;
  static const SIGNUP = _Paths.SIGNUP;
  static const SIGNIN = _Paths.SIGNIN;
  static const MAIN = _Paths.MAIN;
  static const HOME = _Paths.HOME;







}

abstract class _Paths {

  static const AUTH = '/auth';
  static const SIGNUP = '/signup';
  static const SIGNIN = '/signin';
  static const MAIN = '/main';
  static const HOME = '/home';





}