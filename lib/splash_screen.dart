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
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          new Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("assets/stars_bkg.jpg"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0.5),
          ),
          Positioned(
            bottom: 0.0,
            right: 0.0,
            child: new Image.asset(
              "assets/jupi_qua.png",
              scale: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
