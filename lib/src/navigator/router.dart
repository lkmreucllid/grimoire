import 'package:flutter_medium/src/authentication/login_screen.dart';
import 'package:flutter_medium/src/authentication/signup_screen.dart';
import 'package:flutter_medium/src/bindings/login_binding.dart';
import 'package:flutter_medium/src/screens/create_feed.dart';
import 'package:flutter_medium/src/screens/my_feeds.dart';
import 'package:flutter_medium/src/screens/open_feed.dart';
import 'package:get/get.dart';
import 'package:flutter_medium/splash_screen.dart';

class Routers {
  static final routes = [
    GetPage(
      name: '/splashView',
      page: () => SplashScreen(),
    ),
    GetPage(
      name: '/feedsView',
      page: () => MyFeeds(),
    ),
    GetPage(
      name: '/selectFeedView',
      page: () => OpenFeed(),
    ),
    GetPage(
      name: '/loginView',
      page: () => LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: '/signUpView',
      page: () => SignUpScreen(),
    ),
    GetPage(
      name: '/createFeed',
      page: () => CreateFeed(),
    ),
  ];
}
