import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_medium/src/controller/auth_controller.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());

  startTimer() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigatePage);
  }

  void navigatePage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    if (token != null && token != "") {
      authController.apiGetLogin();
    } else {
      Get.offNamed('/loginView');
    }
  }

  @override
  Widget build(BuildContext context) {
    startTimer();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("assets/learning.png"),
              ),
            ),
          ),
          Positioned(
            bottom: 50.0,
            child: Text(
              "Something new to Learn",
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
        ],
      ),
    );
  }
}
