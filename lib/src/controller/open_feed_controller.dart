import 'package:flutter_medium/src/controller/likes_controller.dart';
import 'package:flutter_medium/src/models/open_feed_model.dart';
import 'package:flutter_medium/src/provider/open_feed_provider.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OpenFeedController extends GetxController {
  RxBool isLoadingFeed = false.obs;
  OpenFeedModel openFeedModel;
  LikesController _likesController = Get.put(LikesController());

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future apiGetFeed(String feedId) async {
    isLoadingFeed.value = true;
    OpenFeedProvider provideFeed = new OpenFeedProvider();

    provideFeed
        .getUpdateFeed("https://my-medium-app.herokuapp.com/post/$feedId")
        .then((value) async {
      if (value.body['sucess'] == true) {
        isLoadingFeed.value = false;
        openFeedModel = OpenFeedModel.fromJson(value.body);

        _likesController.isLiked.value = openFeedModel.isLiked;
        _likesController.likes.value = openFeedModel.likes;
        update();
      } else if (value.body['message'] == 'User unauthorized') {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("token", "");
        Get.offNamed('/loginView');
      }
    });
  }
}
