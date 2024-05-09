import 'package:flutter/material.dart';

class SnackbarHelper {
  static void showSimpleSnackbar(
    GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey,
    BuildContext context,
    String message,
    Color backgroundColor,
  ) {
    final snackBarSource = scaffoldMessengerKey.currentState != null
        ? scaffoldMessengerKey.currentState!
        : ScaffoldMessenger.of(context);

    snackBarSource.removeCurrentSnackBar();
    snackBarSource.showSnackBar(
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
      ),
    );
  }
}
