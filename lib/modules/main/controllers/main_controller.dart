import 'dart:async';

import 'package:get/get.dart';

import '../../../data/auth.dart';
import '../../../routes/app_pages.dart';
import '../../auth/models/user.dart';

class MainController extends GetxController {

  final authData = AuthData();
  Rx<AppUser?> user = Rx<AppUser?>(null);
  late StreamSubscription disableListener;

  var tabIndex = 0;

  void changeTabIndex(int index) {
    tabIndex = index;
    update();
  }


  Future<void> authTokenExists() async {
    user.value = await authData.getCurrentUser();
    await Future.delayed(Duration(milliseconds: 200));
    if (user.value != null) {
      Get.offNamed(Routes.HOME);
    } else {
      Get.offNamed(Routes.AUTH);
    }
  }

  Future <void> logout() async {
    await authData.logout();
    // user = Rx<AppUser?>(null);
    Get.offAllNamed(Routes.AUTH);
  }


  @override
  void onInit() {
    authTokenExists();
    super.onInit();
    print(authData.getCurrentUser());
  }



  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    user.close();
  }
}