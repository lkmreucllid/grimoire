import 'package:flutter_medium/src/models/open_feed_model.dart';
import 'package:flutter_medium/src/provider/likes_provider.dart';
import 'package:flutter_medium/src/utils/server_communicator.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LikesController extends GetxController {
  RxBool isLiked = false.obs;
  RxInt likes = 0.obs;
  LikesProvider likesProvider = new LikesProvider();
  OpenFeedModel openFeedModel;
  @override
  void onInit() {
    super.onInit();
    //print(openFeedModel.isLiked);
  }

  @override
  void onClose() {
    super.onClose();
  }

  void likePost(String feedId) async {
    likesProvider
        .likePost(ServerCommunicator().baseUrl + "post/like/$feedId")
        .then((value) async {
      if (value.body['sucess'] == true) {
        if (value.body['message'] == 'Post liked') {
          isLiked.value = true;
          likes.value = likes.value + 1;
          update();
        }
      } else if (value.body['message'] == 'User unauthorized') {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("token", "");
        Get.offNamed('/loginView');
      }
    });
  }

  void unLikePost(String feedId) async {
    likesProvider
        .unLikePost(ServerCommunicator().baseUrl + "post/unlike/$feedId")
        .then((value) async {
      if (value.body['sucess'] == true) {
        if (value.body['message'] == 'Post unliked') {
          isLiked.value = false;
          isLiked.value = false;
          likes.value = likes.value - 1;
          update();
        }
      } else if (value.body['message'] == 'User unauthorized') {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("token", "");
        Get.offNamed('/loginView');
      }
    });
  }
}
