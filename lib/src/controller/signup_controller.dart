import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_medium/src/provider/user_provider.dart';
import 'package:flutter_medium/src/screens/my_feeds.dart';
import 'package:flutter_medium/src/utils/server_communicator.dart';
import 'package:flutter_medium/src/utils/utility.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpController extends GetxController {
  TextEditingController nameTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController confirmPasswordTextController = TextEditingController();
  TextEditingController contactTextController = TextEditingController();
  TextEditingController addressTextController = TextEditingController();
  FirebaseMessaging _firebaseMessaging;

  RxBool nameFocusNode = false.obs;
  RxBool countryFocusNode = false.obs;
  RxBool addressFocusNode = false.obs;
  RxBool passwordFocusNode = false.obs;
  RxBool confirmPasswordFocusNode = false.obs;
  RxBool contactFocusNode = false.obs;
  RxBool genderFocusNode = false.obs;
  RxBool emailFocusNode = false.obs;
  RxBool obscureText = true.obs;
  RxBool obscureConfirmText = true.obs;
  String accessToken,
      userId,
      name,
      email,
      contact,
      address,
      countryStr,
      genderStr,
      deviceToken;
  RxString gender = "Male".obs;
  RxString country = "India".obs;

  @override
  void onInit() {
    super.onInit();
    _firebaseMessaging = FirebaseMessaging.instance;
    _firebaseMessaging.getToken().then((value) {
      deviceToken = value.toString();
    });
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

  void toggleConfirm() {
    obscureConfirmText.value = !obscureConfirmText.value;
    update();
  }

  String validateName(String value) {
    if (value == null || value.trim().isEmpty) {
      return "Please enter Name";
    }
    return null;
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
      "Password requires atleast 1 capital letter, 1 special character and minimum 7 characters.";
  String validatePassword(String value) {
    if (value == null || value.trim().isEmpty) {
      return "Please enter password";
    }
    return validateStructure(value) ? null : passErrorMsg;
  }

  String validateConfirmPassword(String value) {
    if (value == null || value.trim().isEmpty) {
      return "Please enter password";
    } else if (value != passwordTextController.text) {
      return "password must be same";
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

  String validateContact(String value) {
    if (value == null || value.trim().isEmpty) {
      return "Please enter contact number";
    }
    return isValidContact(value) ? null : "Please enter valid contact number";
  }

  bool isValidContact(String contact, [int minLength = 10]) {
    final bool hasMinLength = contact.length > minLength;
    return hasMinLength;
  }

  String validateAddress(String value) {
    if (value == null || value.trim().isEmpty) {
      return "Please enter Address";
    }
    return null;
  }

  Future apisignUp() async {
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
        "name": nameTextController.text,
        "country": country.value.toString(),
        "address": addressTextController.text,
        "password": passwordTextController.text,
        "contact": contactTextController.text,
        "gender": gender.value.toString().toUpperCase(),
        "email": emailTextController.text,
        "deviceToken": deviceToken
      };
      print(_data);

      Get.dialog(Center(child: CircularProgressIndicator()),
          barrierDismissible: false);

      UserProvider()
          .postApi(_data,
              ServerCommunicator().baseUrl + ServerCommunicator().signupUrl)
          .then((value) {
        if (value != null) {
          print("SignUp RESPONSE *******" + value.body.toString());
          Get.back();
          if (value.body['sucess'] == true) {
            accessToken = value.body['data']['token'].toString();
            userId = value.body['data']['_id'].toString();
            name = value.body['data']['name'].toString();
            email = value.body['data']['email'].toString();
            contact = value.body['data']['contact'].toString();
            address = value.body['data']['address'].toString();
            countryStr = value.body['data']['country'].toString();
            genderStr = value.body['data']['gender'].toString();
            prefs.setString("token", accessToken);
            prefs.setString("userId", userId);
            prefs.setString("name", name);
            prefs.setString("email", email);
            prefs.setString("contact", contact);
            prefs.setString("address", address);
            prefs.setString("country", countryStr);
            prefs.setString("gender", genderStr);
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
