import 'package:get/get.dart';

import '../../../data/auth.dart';
import '../../auth/models/user.dart';



class HomeController extends GetxController {


  final count = 0.obs;
  Rx<AppUser?> user = Rx<AppUser?>(null);


  incrementCounter() {
      count.value++;
  }



  void logout() async {
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
