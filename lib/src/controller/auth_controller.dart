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
      if (value.body['sucess'] == false) {
        isLoadingAuth.value = false;
        Get.offNamed('/loginView');
        update();
      } else {
        Get.offNamed('/feedsView');
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
