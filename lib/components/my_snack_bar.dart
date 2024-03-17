import 'package:flutter/material.dart';

void mySnackBar(BuildContext context, String errorMessage, Color color) {
  ScaffoldMessengerState scaffoldMessenger = ScaffoldMessenger.of(context);

  scaffoldMessenger.hideCurrentSnackBar();

  scaffoldMessenger.showSnackBar(
    SnackBar(
      content: Center(
        child: Text(
          errorMessage,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
      behavior: SnackBarBehavior.floating,
      closeIconColor: Color(0xFF07070A),
      showCloseIcon: true,
      backgroundColor: color,
    ),
  );
}
