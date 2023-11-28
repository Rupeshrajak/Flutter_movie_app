import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'app_colors.dart';


class Utility {
  static const int pageSize = 7;

  Utility();

  void showErrorSnackBarOnTop(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.red,
      margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height - 100, right: 5, left: 5),
    ));
  }

  void showErrorSnackBar(BuildContext context, String message) {
    hideCurrentSnackBar(context);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    ));
  }

  void showSnackBar(BuildContext context, String message) {
    hideCurrentSnackBar(context);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void showSuccessSnackBar(BuildContext context, String message) {
    hideCurrentSnackBar(context);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Colors.green,
    ));
  }

  void showInfoSnackBar(BuildContext context, String message) {
    hideCurrentSnackBar(context);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message), backgroundColor: AppColors.instructionColor));
  }

  void hideCurrentSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }

}
