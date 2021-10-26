import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Utility {
  /* static void showMessage(String title, String message) {
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
*/
  static void showMessage(String title, String message) {
    Get.bottomSheet(
      makeDisimissible(
        child: DraggableScrollableSheet(
          builder: (_, controller) => Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
            ),
            padding: EdgeInsets.all(16.0),
            child: ListView(
              controller: controller,
              children: [
                Center(
                    child: Text(
                  title,
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                )),
                Center(
                  child: Text(
                    message,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget makeDisimissible({Widget child}) => GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => Get.back(),
      child: GestureDetector(
        onTap: () {},
        child: child,
      ),
    );
