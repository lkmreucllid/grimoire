import 'package:flutter_medium/src/models/open_feed_model.dart';
import 'package:flutter_medium/src/provider/open_feed_provider.dart';
import 'package:get/get.dart';

class OpenFeedController extends GetxController {
  RxBool isLoadingFeed = false.obs;
  OpenFeedModel updateFeedModel;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future apiGetFeed(String feedId) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.setString("currentlyReading", feedId);
    isLoadingFeed.value = true;
    OpenFeedProvider provideFeed = new OpenFeedProvider();

    provideFeed
        .getUpdateFeed("https://my-medium-app.herokuapp.com/post/$feedId")
        .then((value) {
      if (value.body['sucess'] == true) {
        isLoadingFeed.value = false;
        updateFeedModel = OpenFeedModel.fromJson(value.body);
        update();
      }
    });
  }
}
