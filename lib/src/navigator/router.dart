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
  ];
}
