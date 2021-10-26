import 'package:flutter_medium/src/provider/authorization_provider.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  RxBool isLoadingAuth = false.obs;
  AuthProvider authProvider = new AuthProvider();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future apiGetLogin() async {
    isLoadingAuth.value = true;

    authProvider
        .checkLogin("https://my-medium-app.herokuapp.com/user")
        .then((value) {
      if (value.isBlank == false && value.body["sucess"] == true) {
        Get.offNamed('/feedsView');
      } else {
        isLoadingAuth.value = false;
        logout();
        Get.offNamed('/loginView');
        update();
      }
    });
  }

  Future logout() async {
    authProvider
        .logout("https://my-medium-app.herokuapp.com/user/logout")
        .then((value) async {
      if (value.body['sucess'] == true) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("token", "");
        Get.offNamed('/loginView');
        update();
      }
    });
  }
}
