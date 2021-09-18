import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_medium/src/screens/open_feed.dart';
import 'package:flutter_medium/src/utils/utility.dart';
import 'package:get/get.dart';

Widget topDummyFeeds() {
  void navigatePage() async {
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    Get.to(() => OpenFeed());
  }

  startTimer() async {
    var _duration = new Duration(seconds: 5);
    return new Timer(_duration, navigatePage);
  }

  return InkWell(
    onTap: () {
      Utility.showMessage("Testing: ", "Hello");
      startTimer();
    },
    child: Container(
      padding: EdgeInsets.only(top: 2.0, bottom: 2.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: Get.width * 0.20,
            height: Get.width * 0.20,
            padding: EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage("assets/user_Tomhardy.jpg"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: Get.width * 0.70,
                  child: Text(
                    'Discover Your Path To Success Discover Your Path To Success',
                    softWrap: true,
                    maxLines: 1,
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.white60,
                    ),
                  ),
                ),
                Container(
                  width: Get.width * 0.70,
                  child: Text(
                    'Hello, this is for Testing purpose only. Hello, this is for Testing purpose only. Hello, this is for Testing purpose only. Hello, this is for Testing purpose only. Hello, this is for Testing purpose only. Hello, this is for Testing purpose only. Hello, this is for Testing purpose only. Hello, this is for Testing purpose only. Hello, this is for Testing purpose only. Hello, this is for Testing purpose only. Hello, this is for Testing purpose only. ',
                    softWrap: true,
                    maxLines: 2,
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 12,
                      color: Colors.white60,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
