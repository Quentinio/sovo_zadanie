import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../../../data/auth.dart';
import '../../controllers/auth_controller.dart';

class ResetForm extends GetView<AuthController> {
  late double _deviceHeight;
  late double _deviceWidth;

  final authData = AuthData();

  String text = "Please enter the email address associated with your account";
  String buttonText = "Send reset link";

  GlobalKey<FormState> resetFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {


    final textScale = MediaQuery.of(context);
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return MediaQuery(
      data: textScale.copyWith(textScaleFactor: 1),
      child: Scaffold(
        // backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Form(
            key: resetFormKey,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: _deviceHeight * 0.24),
                  _headingWidget(),
                  SizedBox(height: _deviceHeight * 0.08),
                  _emailTextField(),
                  SizedBox(height: _deviceHeight * 0.1),
                  _resetButton(),
                  SizedBox(height: _deviceHeight * 0.02),
                  _signIn()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _headingWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          "Let's find your account",
          style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.w700,
              // color: Color(0xff232426),
              fontFamily: 'Helvetica'),
        ),
        SizedBox(height: _deviceHeight * 0.03),
        Text(
          text,
          style: const TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.w300,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _emailTextField() {
    return Stack(
      children: [
        Container(
          height: _deviceHeight * 0.07,
          decoration: BoxDecoration(
              color: Colors.grey[200], borderRadius: BorderRadius.circular(20)),
        ),
        TextFormField(
          keyboardType: TextInputType.emailAddress,
          style: const TextStyle(color: Colors.black),
          cursorColor: Colors.black,
          validator: (email) => controller.emailValidator(email!),
          onSaved: (email) => controller.saveEmail(email!),
          decoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
              border: InputBorder.none,
              errorBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none,
              errorStyle: const TextStyle(fontSize: 13),
              prefixIcon: Icon(
                Icons.email_outlined,
                color: Colors.grey[700],
              ),
              focusedBorder: InputBorder.none,
              labelText: 'E-mail',
              labelStyle: TextStyle(color: Colors.grey[700])),
        ),
      ],
    );
  }

  Widget _resetButton() {
    return ElevatedButton(
      onPressed: () {
        controller.resetPassword(resetFormKey);
        controller.switchToSignIn();
      },
      child: Container(
        height: _deviceHeight * 0.04,
        width: _deviceWidth * 0.4,
        decoration: BoxDecoration(
            color: const Color(0xffcc3333), borderRadius: BorderRadius.circular(20)),
        child: Center(
          child: Text(
            buttonText,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 20,
              // fontFamily: 'Helvetica',
            ),
          ),
        ),
      ),
      // style: ElevatedButton.styleFrom(
      //   backgroundColor: const Color(0xffcc3333),
      //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      // ),
    );
  }

  Widget _signIn() {
    return Padding(
      padding: const EdgeInsets.only(right: 15.0, top: 5),
      child: SizedBox(
        width: _deviceWidth * 0.8,
        child: TextButton(
          onPressed: () => controller.switchToSignIn(),
          child: const Text(
            'Back to sign in',
            style: TextStyle(
                fontSize: 17,
                color: Colors.grey,
                fontFamily: 'Helvetica'),
          ),
        ),
      ),
    );
  }
}
