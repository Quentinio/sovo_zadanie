import 'package:flutter/material.dart';

import 'package:get/get.dart';


import '../controllers/auth_controller.dart';
import 'forms/pass_reset_view.dart';
import 'forms/sign_in_view.dart';
import 'forms/sign_up_view.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        width: Get.width,
        // padding: EdgeInsets.symmetric(horizontal: Get.width * 0.1),
        child: PageView(
          controller: controller.pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            SignInForm(),
            SignUpForm(),
            ResetForm(),
          ],
        ),
      ),
    );
  }
}
