import 'package:flutter/material.dart';
import 'package:flutter_medium/src/models/selected_category_model.dart';
import 'package:flutter_medium/src/provider/create_post_provider.dart';
import 'package:flutter_medium/src/screens/my_feeds.dart';
import 'package:flutter_medium/src/utils/server_communicator.dart';
import 'package:flutter_medium/src/utils/utility.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreatePostController extends GetxController {
  RxString selectedCategory = "".obs;
  RxString selectedCategoryName = "".obs;
  TextEditingController titleTextController = TextEditingController();
  TextEditingController descTextController = TextEditingController();
  RxBool titleFocusNode = false.obs;
  RxBool descFocusNode = false.obs;
  SelectCategoryModel selectedCatergoryModel;
  RxList<SelectedCategoryList> selectedCategoryList =
      <SelectedCategoryList>[].obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future apiCreatePost() async {
    if (selectedCategoryName.value == "Popular" ||
        selectedCategoryName.value == "") {
      Utility.showMessage("Alert!", "Please select Category.");
    } else if (titleTextController.text.trim() == "") {
      Utility.showMessage("Alert!", "Please enter Title.");
    } else if (descTextController.text.trim() == "") {
      Utility.showMessage("Alert!", "Please enter Description.");
    } else {
      Map _data = {
        "category": selectedCategory.value,
        "title": titleTextController.text,
        "body": descTextController.text
      };
      Get.dialog(Center(child: CircularProgressIndicator()),
          barrierDismissible: false);

      CreatePostProvider()
          .postFeed(_data, ServerCommunicator().baseUrl + 'post')
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
