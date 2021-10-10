import 'package:flutter_medium/src/models/selected_category_model.dart';
import 'package:flutter_medium/src/provider/sel_category_list_provider.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectedCategoryController extends GetxController {
  SelectCategoryModel selectedCatergoryModel;
  RxList<SelectedCategoryList> selectedCategoryList =
      <SelectedCategoryList>[].obs;

  RxBool isSelCategoryLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    apiGetSelectedCategoryList();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future apiGetSelectedCategoryList() async {
    isSelCategoryLoading.value = true;

    SelCategoryListProvider selCat = SelCategoryListProvider();

    selCat
        .getSelectedCategory("https://my-medium-app.herokuapp.com/category")
        .then((value) async {
      if (value.body['sucess'] == true) {
        Get.back();
        isSelCategoryLoading.value = false;
        selectedCatergoryModel = SelectCategoryModel.fromJson(value.body);
        selectedCategoryList.value = selectedCatergoryModel.data;
        update();
      } else if (value.body['message'] == 'User unauthorized') {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("token", "");
        Get.offNamed('/loginView');
      }
    });
  }
}
