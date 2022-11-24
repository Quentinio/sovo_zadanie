import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../../../routes/app_pages.dart';
import '../../controllers/auth_controller.dart';


class SignUpForm extends GetView<AuthController> {
  late double _deviceHeight;
  late double _deviceWidth;

  GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    final textScale = MediaQuery.of(context);
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return MediaQuery(
      data: textScale.copyWith(textScaleFactor: 1),
      child: Scaffold(
        body : Stack(
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
                      key: signUpFormKey,
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
                                SizedBox(height: _deviceHeight * 0.12),
                                _nameTextField(),
                                SizedBox(height: _deviceHeight * 0.03),
                                _emailTextField(),
                                SizedBox(height: _deviceHeight * 0.03),
                                _passwordTextField(),
                                SizedBox(height: _deviceHeight * 0.05),
                                _loginButton(),
                                SizedBox(height: _deviceHeight * 0.04),
                                const Text('Or log in using following', style: TextStyle(
                                  color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500
                                ),),
                                SizedBox(height: _deviceHeight * 0.04),
                                _alternativeAuth(),
                                SizedBox(height: _deviceHeight * 0.04),
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
            // Form(
            //   key: signUpFormKey,
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       const SizedBox(height: 30),
            //       TextFormField(
            //         validator: (name) => controller.nameValidator(name!),
            //         onSaved: (name) => controller.saveName(name!),
            //         decoration: const InputDecoration(
            //           labelText: 'Name',
            //           border: OutlineInputBorder(),
            //         ),
            //       ),
            //       const SizedBox(height: 30),
            //       TextFormField(
            //         validator: (email) => controller.emailValidator(email!),
            //         onSaved: (email) => controller.saveEmail(email!),
            //         decoration: const InputDecoration(
            //           labelText: 'Email',
            //           border: OutlineInputBorder(),
            //         ),
            //       ),
            //       const SizedBox(height: 20),
            //       TextFormField(
            //         validator: (password) => controller.passwordValidator(password!),
            //         onSaved: (password) => controller.savePassword(password!),
            //         obscureText: true,
            //         decoration: const InputDecoration(
            //           labelText: 'Password',
            //           border: OutlineInputBorder(),
            //         ),
            //       ),
            //       const SizedBox(height: 30),
            //       ElevatedButton(
            //         onPressed: () => controller.signUp(signUpFormKey),
            //         child: const Text('Sign Up'),
            //       ),
            //       const SizedBox(height: 30),
            //       TextButton(
            //         onPressed: () => controller.switchToSignIn(),
            //         child: const Text('Already have an account'),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget _nameTextField() {
    return Column(
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 15.0, bottom: 5),
            child: Text(
              'Name',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        Container(
          height: _deviceHeight * 0.07,
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
                onSaved: (name) => controller.saveName(name!),
                decoration: const InputDecoration(
                    hintText: 'Enter your name',
                    hintStyle: TextStyle(color: Colors.white38),
                    border: InputBorder.none),
              ),
            ),
          ),
        ),
      ],
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
          height: _deviceHeight * 0.07,
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
                    hintText: 'example@email.com',
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
          height: _deviceHeight * 0.07,
          decoration: BoxDecoration(
              color: const Color(0xff302F2F),
              borderRadius: BorderRadius.circular(10)),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0, bottom: 5),
              child: TextFormField(
                textAlignVertical: TextAlignVertical.center,
                style: const TextStyle(color: Colors.white),
                obscureText: true,
                cursorColor: Colors.white,
                validator: (password) => controller.passwordValidator(password!),
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
        controller.signUp(signUpFormKey);
      },
      child: Container(
        height: _deviceHeight * 0.055,
        decoration: BoxDecoration(
            color: const Color(0xff20f3b4),
            borderRadius: BorderRadius.circular(10)),
        child: const Center(
          child: Text(
            'Sign Up',
            style: TextStyle(color: Color(0xff302F2F), fontSize: 26, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }

  Widget _alternativeAuth() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: _deviceHeight * 0.07,
          width: _deviceWidth * 0.37,
          decoration: BoxDecoration(
              color: const Color(0xff302F2F),
              borderRadius: BorderRadius.circular(10)),
          child: const Center(
            child: Text('Google'),
          ),
        ),
        Container(
          height: _deviceHeight * 0.07,
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

  Widget _goToSignUp() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:  [
        const Text("Already have an account? ", style: TextStyle(fontSize: 16, color: Colors.white),),
        GestureDetector(
          onTap: () {
            Get.toNamed(Routes.SIGNIN);
          },
          child: const Text("Sign in", style: TextStyle(
              color: const Color(0xff20f3b4), fontWeight: FontWeight.w600, fontSize: 16
          ),),
        ),
      ],
    );
  }

}



