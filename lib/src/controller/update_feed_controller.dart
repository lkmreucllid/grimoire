import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_medium/src/models/open_feed_model.dart';
import 'package:flutter_medium/src/provider/create_post_provider.dart';
import 'package:flutter_medium/src/provider/open_feed_provider.dart';
import 'package:flutter_medium/src/screens/my_feeds.dart';
import 'package:flutter_medium/src/utils/server_communicator.dart';
import 'package:flutter_medium/src/utils/utility.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateFeedController extends GetxController {
  RxBool isLoadingFeed = false.obs;
  OpenFeedModel openFeedModel;

  RxString selectedCategory = "".obs;
  RxString selectedCategoryName = "".obs;
  TextEditingController titleTextController = TextEditingController();
  TextEditingController descTextController = TextEditingController();
  RxBool titleFocusNode = false.obs;
  RxBool descFocusNode = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future apiGetFeedUpdate(String feedId) async {
    isLoadingFeed.value = true;
    OpenFeedProvider providerFeed = new OpenFeedProvider();

    providerFeed
        .getUpdateFeed("https://my-medium-app.herokuapp.com/post/$feedId")
        .then((value) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (value.body['sucess'] == true) {
        isLoadingFeed.value = false;
        openFeedModel = OpenFeedModel.fromJson(value.body);
        titleTextController..text = openFeedModel.title;
        descTextController..text = openFeedModel.bodyText;

        update();
      } else if (value.body['message'] == 'User unauthorized') {
        prefs.setString("token", "");
        Get.offNamed('/loginView');
      }
    });
  }

  Future updateFeed(String feedId) async {
    if (titleTextController.text.trim() == "") {
      Utility.showMessage("Alert!", "Please enter Title.");
    } else if (titleTextController.text.trim() == openFeedModel.title &&
        descTextController.text.trim() == openFeedModel.bodyText) {
      Utility.showMessage("Alert!", "Please modify Title or Description.");
    } else if (descTextController.text.trim() == "") {
      Utility.showMessage("Alert!", "Please enter Description.");
    } else {
      Map _data = {
        "category": openFeedModel.categoryId,
        "title": titleTextController.text,
        "body": descTextController.text
      };
      Get.dialog(Center(child: CircularProgressIndicator()),
          barrierDismissible: false);
      CreatePostProvider()
          .updateFeed(_data, ServerCommunicator().baseUrl + 'post/$feedId')
          .then((value) async {
        if (value != null) {
          Get.back();
          if (value.body['sucess'] == true) {
            Get.offAll(() => MyFeeds());
          } else if (value.body['message'] == 'User unauthorized') {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString("token", "");
            Get.offNamed('/loginView');
          } else {
            Utility.showMessage("Alert", value.body['message']);
          }
        }
      });
    }
  }
}
