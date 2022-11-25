import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../data/auth.dart';
import '../../../routes/app_pages.dart';
import '../../../util/load.dart';
import '../../main/controllers/main_controller.dart';
import '../models/user.dart';


class AuthController extends GetxController {
  MainController get homeController => Get.find<MainController>();

  final pageController = PageController();

  final authData = AuthData();

  String _email = '';
  String _password = '';
  String _name = '';
  int _points = 3;


  String? emailValidator(String email) {
    if (email.isEmail) {
      return null;
    } else {
      return 'Please enter correct e-mail';
    }
  }

  String? passwordValidator(String password) {
    if (password.length > 5) {
      return null;
    } else {
      return 'Password should be more than 5 characters';
    }
  }


  String? nameValidator(String name) {
    if (name.length > 3) {
      return null;
    } else {
      return 'Name too short';
    }
  }

  void saveEmail(String email) {
    _email = email;
  }

  void savePassword(String password) {
    _password = password;
  }


  void saveName(String name) {
    _name = name;
  }



  void savePoints(int points) {
    _points = points;
  }


  void resetPassword(GlobalKey<FormState> resetFormKey) async {
    if (resetFormKey.currentState!.validate()) {
      resetFormKey.currentState!.save();
      // load(Get.context!);
      await authData.resetPassword(email: _email).then((value) {
        // Get.offAll(SignInForm());
        Fluttertoast.showToast(msg: "Password reset link has been sent to your email.");
        print(_email);
      }).catchError((onError) => Get.snackbar("Error In Email Reset", onError.message));
    }
  }


  Future<void> signin(GlobalKey<FormState> signInFormKey) async {
    try {
      if (signInFormKey.currentState!.validate()) {
        signInFormKey.currentState!.save();
        load(Get.context!);
        final user = await authData.signIn(email: _email, password: _password);
        if (user == null) {
          Fluttertoast.showToast(msg: 'Login Failed');
          Get.back();
        } else {
          homeController.user.value = user;
          Get.offAllNamed(Routes.HOME);
        }
      }
    } catch (e) {
      print('$e');
    }
  }


  Future<void> signUp(GlobalKey<FormState> signUpFormKey) async {
    try {
      if (signUpFormKey.currentState!.validate()) {
        signUpFormKey.currentState!.save();
        load(Get.context!);
        final appUser = AppUser(
          uid: '${DateTime.now().millisecondsSinceEpoch}',
          email: _email,
          name: _name,
          points: _points,

          // isAdmin: false,
        );
        final user = await authData.signUp(
          appUser: appUser,
          password: _password,
        );

        if (user == null) {
          Fluttertoast.showToast(msg: 'Signup Failed');
          Get.back();
        } else {
          homeController.user.value = user;
          Get.offAllNamed(Routes.HOME);
        }
      }
    } catch (e) {
      print('$e');
    }
  }

  Future<void> editPoints() async {
    String uid = homeController.user.value!.uid;
    try {
        load(Get.context!);
        await authData.editPoints(
          uid: uid,
          points: _points,
        );
    } catch (e) {
      print('$e');
    }
  }





  void switchToReset() {
    pageController.animateToPage(
        1,
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease
    );
  }


  void switchToSignIn() {
    pageController.animateToPage(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }



  void switchToSignUp() {
    pageController.animateToPage(
      2,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}


