import 'package:flutter/material.dart';



void load(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (_) => const AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Center(
        child: CircularProgressIndicator(
          color: Color(0xffFF6B00),
        ),
      ),
    ),
  );
}



