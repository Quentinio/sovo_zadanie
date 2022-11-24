import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../routes/app_pages.dart';
import '../../controllers/auth_controller.dart';

class SignInForm extends GetView<AuthController> {
  late double _deviceHeight;
  late double _deviceWidth;

  GlobalKey<FormState> signInFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final textScale = MediaQuery.of(context);
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return MediaQuery(
      data: textScale.copyWith(textScaleFactor: 1),
      child: Scaffold(
          body: Stack(
        children: [
          ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Container(
                height: _deviceHeight * 1,
                decoration:
                    BoxDecoration(color: Colors.black54.withOpacity(0.2)),
                child: SingleChildScrollView(
                  child: Form(
                    key: signInFormKey,
                    child: Column(
                      children: [
                        SizedBox(height: _deviceHeight * 0.07),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: Get.width * 0.1),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: _deviceHeight * 0.10),
                              const Text(
                                'SOVO',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 40
                                ),
                              ),
                              SizedBox(height: _deviceHeight * 0.10),
                              _emailTextField(),
                              SizedBox(height: _deviceHeight * 0.03),
                              _passwordTextField(),
                              SizedBox(height: _deviceHeight * 0.08),
                              _loginButton(),
                              SizedBox(height: _deviceHeight * 0.02),
                              _forgotPassword(),
                              SizedBox(height: _deviceHeight * 0.05),
                              _alternativeAuth(),
                              SizedBox(height: _deviceHeight * 0.05),
                              _goToSignUp()
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }

  Widget _emailTextField() {
    return Column(
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 15.0, bottom: 5),
            child: Text(
              'Email',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        Container(
          height: _deviceHeight * 0.065,
          decoration: BoxDecoration(
              color: const Color(0xff302F2F),
              borderRadius: BorderRadius.circular(10)),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                validator: (email) => controller.emailValidator(email!),
                onSaved: (email) => controller.saveEmail(email!),
                decoration: const InputDecoration(
                    hintText: 'example@gmail.com',
                    hintStyle: TextStyle(color: Colors.white38),
                    border: InputBorder.none),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _passwordTextField() {
    return Column(
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 15.0, bottom: 5),
            child: Text(
              'Password',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        Container(
          height: _deviceHeight * 0.065,
          decoration: BoxDecoration(
              color: const Color(0xff302F2F),
              borderRadius: BorderRadius.circular(10)),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: TextFormField(
                textAlignVertical: TextAlignVertical.center,
                style: const TextStyle(color: Colors.white),
                obscureText: true,
                cursorColor: Colors.white,
                validator: (password) =>
                    controller.passwordValidator(password!),
                onSaved: (password) => controller.savePassword(password!),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  errorBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                  errorStyle: TextStyle(fontSize: 15),
                  focusedBorder: InputBorder.none,
                  hintText: 'Enter your password',
                  hintStyle: TextStyle(color: Colors.white38),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _loginButton() {
    return GestureDetector(
      onTap: () {
        controller.signin(signInFormKey);
      },
      child: Container(
        height: _deviceHeight * 0.055,
        decoration: BoxDecoration(
            color: const Color(0xff20f3b4),
            borderRadius: BorderRadius.circular(10)),
        child: const Center(
          child: Text(
            'Log in',
            style: TextStyle(color: Color(0xff302F2F), fontSize: 26, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
    // return ElevatedButton(
    //   onPressed: () => controller.signin(signInFormKey),
    //   child: SizedBox(
    //     height: _deviceHeight * 0.04,
    //     width: _deviceWidth * 0.4,
    //     child: const Center(
    //       child: Text(
    //         "LOG IN",
    //         style: TextStyle(
    //             color: Colors.white, fontWeight: FontWeight.w600, fontSize: 20),
    //       ),
    //     ),
    //   ),
    //   style: ElevatedButton.styleFrom(
    //     backgroundColor: const Color(0xffcc3333),
    //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
    //   ),
    // );
  }

  Widget _alternativeAuth() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: _deviceHeight * 0.06,
          width: _deviceWidth * 0.37,
          decoration: BoxDecoration(
              color: const Color(0xff302F2F),
              borderRadius: BorderRadius.circular(10)),
          child: const Center(
            child: Text('Google'),
          ),
        ),
        Container(
          height: _deviceHeight * 0.06,
          width: _deviceWidth * 0.37,
          decoration: BoxDecoration(
              color: const Color(0xff302F2F),
              borderRadius: BorderRadius.circular(10)),
          child: const Center(
            child: Text('Facebook'),
          ),
        ),
      ],
    );
  }

  Widget _forgotPassword() {
    return const Align(
      alignment: Alignment.centerRight,
      child: Text(
        '  Forgot password?',
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: Colors.white,
          fontFamily: 'Helvetica',
        ),
      ),
    );
  }

  Widget _goToSignUp() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't have an account? ",
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
        GestureDetector(
          onTap: () {
            Get.toNamed(Routes.SIGNUP);
          },
          child: const Text(
            "Sign up",
            style: TextStyle(
                color: Color(0xff20f3b4),
                fontWeight: FontWeight.w600,
                fontSize: 16),
          ),
        ),
      ],
    );
    // return RichText(
    //   text: const TextSpan(
    //       text: "Don't have an account? ",
    //       style: TextStyle(fontSize: 16),
    //       children: <TextSpan>[
    //         TextSpan(
    //             text: 'Sign up',
    //             style: TextStyle(
    //                 color: Color(0xffFF6B00), fontWeight: FontWeight.w600))
    //       ]),
    // );
  }
}
