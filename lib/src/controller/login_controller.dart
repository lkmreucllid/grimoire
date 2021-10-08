import 'package:flutter/material.dart';
import 'package:flutter_medium/src/provider/user_provider.dart';
import 'package:flutter_medium/src/screens/my_feeds.dart';
import 'package:flutter_medium/src/utils/server_communicator.dart';
import 'package:flutter_medium/src/utils/utility.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  RxBool emailFocusNode = false.obs;
  RxBool passwordFocusNode = false.obs;
  RxBool obscureText = true.obs;
  String accessToken, userId, name, email, contact, gender, country, address;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void toggle() {
    obscureText.value = !obscureText.value;
    update();
  }

  String validateEmail(String value) {
    if (value == null || value.trim().isEmpty) {
      return "Please enter email address";
    }
    return isValidEmail(value) ? null : "Please enter valid email address";
  }

  bool isValidEmail(String email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }

  static const passErrorMsg =
      "Required atleast 1 capital letter, 1 special character and minimum 7 characters.";
  String validatePassword(String value) {
    if (value == null || value.trim().isEmpty) {
      return "Please enter password";
    }
    return validateStructure(value) ? null : passErrorMsg;
  }

  bool validateStructure(String password, [int minLength = 6]) {
    if (password == null || password.isEmpty) {
      return false;
    }
    final bool hasUpperCase = password.contains(RegExp(r'[A-Z]'));
    final bool hasSpecialCharacters =
        password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    final bool hasMinLength = password.length > minLength;
    return hasUpperCase & hasSpecialCharacters & hasMinLength;
  }

  Future apiLogin() async {
    if (emailTextController.text.trim() == "") {
      Utility.showMessage("Alert", "Please enter email address");
    } else if (!GetUtils.isEmail(emailTextController.text)) {
      Utility.showMessage("Alert", "Please enter a valid email address");
    } else if (passwordTextController.text.trim() == "") {
      Utility.showMessage("Alert", "Please enter password");
    } else if (passwordTextController.text.trim().length < 8) {
      Utility.showMessage("Alert", "Password must consist 8 characters");
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      Map _data = {
        "email": emailTextController.text,
        "password": passwordTextController.text
      };

      Get.dialog(Center(child: CircularProgressIndicator()),
          barrierDismissible: false);

      UserProvider()
          .postApi(_data,
              ServerCommunicator().baseUrl + ServerCommunicator().loginUrl)
          .then((value) {
        if (value != null) {
          print("LOGIN RESPONSE *******" + value.body.toString());
          Get.back();
          if (value.body['sucess'] == true) {
            accessToken = value.body['data']['token'].toString();
            userId = value.body['data']['_id'].toString();
            name = value.body['data']['name'].toString();
            email = value.body['data']['email'].toString();
            contact = value.body['data']['contact'].toString();
            address = value.body['data']['address'].toString();
            country = value.body['data']['country'].toString();
            gender = value.body['data']['gender'].toString();
            prefs.setString("token", accessToken);
            prefs.setString("userId", userId);
            prefs.setString("name", name);
            prefs.setString("email", email);
            prefs.setString("contact", contact);
            prefs.setString("address", address);
            prefs.setString("country", country);
            prefs.setString("gender", gender);
            emailTextController.clear();
            passwordTextController.clear();
            Get.offAll(() => MyFeeds());
          } else {
            Utility.showMessage("Alert", value.body['message']);
            emailTextController.clear();
            passwordTextController.clear();
          }
        }
      });
    }
  }
}
