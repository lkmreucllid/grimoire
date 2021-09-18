import 'package:flutter/material.dart';
import 'package:flutter_medium/src/navigator/router.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

final String appName = "Grimoire";

class MyApp extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Grimoire",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Poppins",
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
          headline1: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: Color.fromARGB(250, 19, 45, 64),
          ),
          headline2: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Colors.white60,
          ),
          headline5: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.bold,
            fontSize: 15,
            color: Colors.white54,
          ),
          headline6: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.bold,
            fontSize: 12,
            color: Colors.white54,
          ),
        ),
      ),
      getPages: Routers.routes,
      //initialRoute: '/splashView',
      initialRoute: '/feedsView',
    );
  }
}
