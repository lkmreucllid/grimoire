import 'dart:async';

import 'package:flutter_medium/src/models/feeds_model.dart';
import 'package:get/get.dart';
import 'package:flutter_medium/src/provider/top_feeds_provider.dart';

class FeedListController extends GetxController {
  FeedsModel feedsModel;
  RxList<FeedsList> feedList = <FeedsList>[].obs;
  String selectedCategoryId = '';
  RxBool isLoadingFeeds = false.obs;

  @override
  void onInit() {
    super.onInit();
    apiGetFeedsList();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void onItemClicked(String categorySelectedStr) {
    selectedCategoryId = categorySelectedStr;
    apiGetFeedsList();
  }

  Future apiGetFeedsList() async {
    isLoadingFeeds.value = true;
    TopFeedsProvider topFeeds = new TopFeedsProvider();

    //void getFeedFromAPI() {
    topFeeds
        .getTopFeeds(
            "https://my-medium-app.herokuapp.com/post?category=$selectedCategoryId")
        .then((value) {
      if (value.body['sucess'] == true) {
        if (value.body['message'] == 'Posts found') {
          Get.back();
          isLoadingFeeds.value = false;
          feedsModel = FeedsModel.fromJson(value.body);

          feedList.value = feedsModel.data;

          update();
        } else if (value.body['message'] == 'No Posts found') {
          isLoadingFeeds.value = false;

          feedList = <FeedsList>[].obs;

          update();
        }
      }
    });
    //}

    // startTimer() async {
    //   var _duration = new Duration(seconds: 10);
    //   return new Timer.periodic(_duration, (Timer t) => getFeedFromAPI);
    // }

    // getFeedFromAPI();
    //startTimer();
  }
}
