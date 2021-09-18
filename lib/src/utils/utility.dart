import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Utility {
  static void showMessage(String title, String message) {
    Get.snackbar(
      title,
      message,
      margin: EdgeInsets.only(bottom: 20, left: 15, right: 15),
      duration: Duration(seconds: 2),
      snackPosition: SnackPosition.BOTTOM,
      colorText: Colors.white,
      backgroundColor: Colors.amber,
    );
  }
}
