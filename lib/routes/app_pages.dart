import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/views/auth_view.dart';
import '../modules/auth/views/forms/sign_in_view.dart';
import '../modules/auth/views/forms/sign_up_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/main/bindings/main_binding.dart';
import '../modules/main/views/main_view.dart';


part 'app_routes.dart';


class AppPages {
  AppPages._();


  static const initial = Routes.MAIN;

  static final routes = [

    GetPage(
      name: _Paths.MAIN,
      page: () => MainView(),
      binding: MainBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.AUTH,
      page: () => AuthView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => SignUpForm(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.SIGNIN,
      page: () => SignInForm(),
      binding: AuthBinding(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
