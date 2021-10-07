import 'package:flutter_medium/src/provider/authorization_provider.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  RxBool isLoadingAuth = false.obs;

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

    AuthProvider authProvider = new AuthProvider();

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
}
