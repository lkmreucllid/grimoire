import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatelessWidget {
  startTimer() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigatePage);
  }

  void navigatePage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Get.offNamed('/feedsView');
  }

  @override
  Widget build(BuildContext context) {
    startTimer();
    return Scaffold(
      backgroundColor: Color.fromARGB(213, 213, 209, 1),
      body: Stack(
        children: [
          new Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("assets/honkbg.png"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Center(
            child: new Image.asset(
              "assets/honkLogo.png",
              scale: 2.5,
            ),
          ),
        ],
      ),
    );
  }
}
