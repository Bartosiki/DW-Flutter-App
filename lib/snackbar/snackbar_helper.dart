import 'package:flutter/material.dart';

class SnackbarHelper {
  static void showSimpleSnackbar(
    GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey,
    String message,
    Color backgroundColor,
  ) {
    scaffoldMessengerKey.currentState?.removeCurrentSnackBar();
    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: backgroundColor,
        duration: const Duration(seconds: 4),
      ),
    );
  }
}
