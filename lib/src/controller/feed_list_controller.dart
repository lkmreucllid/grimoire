import 'package:flutter_medium/src/models/feeds_model.dart';
import 'package:get/get.dart';
import 'package:flutter_medium/src/provider/top_feeds_provider.dart';

class FeedListController extends GetxController {
  FeedsModel feedsModel;
  RxList<FeedsList> feedList = <FeedsList>[].obs;

  @override
  void onInit() {
    super.onInit();
    apiGetFeedsList();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future apiGetFeedsList() async {
    TopFeedsProvider topFeeds = new TopFeedsProvider();

    topFeeds
        .getTopFeeds("https://my-medium-app.herokuapp.com/post")
        .then((value) {
      if (value.body['sucess'] == true) {
        feedsModel = FeedsModel.fromJson(value.body);
        // print(feedsModel.data[1].feedId);
        feedList.value = feedsModel.data;
        update();
      }
    });
  }
}
