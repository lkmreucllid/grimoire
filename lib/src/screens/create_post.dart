import 'package:flutter/material.dart';
import 'package:flutter_medium/src/controller/create_post_controller.dart';
import 'package:flutter_medium/src/controller/selected_category_controller.dart';
import 'package:flutter_medium/src/models/selected_category_model.dart';
import 'package:flutter_medium/src/utils/app_colors.dart';
import 'package:flutter_medium/src/utils/common_widgets.dart';
import 'package:get/get.dart';

class CreatePost extends StatefulWidget {
  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final SelectedCategoryController selectedCategoryController =
      Get.put(SelectedCategoryController());
  final CreatePostController createPostController =
      Get.put(CreatePostController());

  SelectedCategoryList selectedCategory;
  @override
  void initState() {
    super.initState();
    selectedCategory = selectedCategoryController.selectedCategoryList[0];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              color: AppColors.primaryColorBlue,
              width: Get.width,
              height: Get.height,
            ),
            Container(
              width: Get.width,
              height: Get.height,
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      DropdownButton<SelectedCategoryList>(
                        value: selectedCategory,
                        icon: const Icon(Icons.arrow_drop_down),
                        iconSize: 16,
                        elevation: 16,
                        style: TextStyle(color: Colors.amber),
                        onChanged: (SelectedCategoryList newValue) {
                          setState(() {
                            selectedCategory = newValue;
                            createPostController.selectedCategory.value =
                                selectedCategory.id;
                            createPostController.selectedCategoryName.value =
                                selectedCategory.name;
                          });
                        },
                        items: selectedCategoryController.selectedCategoryList
                            .map((element) {
                          return DropdownMenuItem(
                            value: element,
                            child: Text(
                              element.name,
                              style: TextStyle(
                                color: Colors.amber,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Obx(() => Focus(
                            onFocusChange: (hasFocus) {
                              createPostController.titleFocusNode.value =
                                  hasFocus;
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              height: 100.0,
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              margin: EdgeInsets.symmetric(horizontal: 10.0),
                              child: PhysicalModel(
                                elevation:
                                    createPostController.titleFocusNode.value
                                        ? 5
                                        : 0,
                                color: createPostController.titleFocusNode.value
                                    ? AppColors.white
                                    : Colors.transparent,
                                child: TextField(
                                  minLines: 2,
                                  maxLines: 5,
                                  style: TextStyle(
                                      color: createPostController
                                              .titleFocusNode.value
                                          ? AppColors.black
                                          : AppColors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                  keyboardAppearance: Brightness.light,
                                  textInputAction: TextInputAction.done,
                                  controller:
                                      createPostController.titleTextController,
                                  decoration: InputDecoration(
                                    fillColor: createPostController
                                            .titleFocusNode.value
                                        ? AppColors.white
                                        : AppColors.white,
                                    errorMaxLines: 5,
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 5.0, horizontal: 10.0),
                                    labelText: 'Title',
                                    labelStyle: TextStyle(
                                      color: AppColors.white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14.0,
                                    ),
                                    border: InputBorder.none,
                                    focusedErrorBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    focusColor: AppColors.white,
                                  ),
                                ),
                              ),
                            ),
                          )),
                      SizedBox(
                        height: 10.0,
                      ),
                      Obx(() => Focus(
                            onFocusChange: (hasFocus) {
                              createPostController.descFocusNode.value =
                                  hasFocus;
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              height: 600.0,
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              margin: EdgeInsets.symmetric(horizontal: 10.0),
                              child: PhysicalModel(
                                elevation:
                                    createPostController.descFocusNode.value
                                        ? 5
                                        : 0,
                                color: createPostController.descFocusNode.value
                                    ? AppColors.white
                                    : Colors.transparent,
                                child: TextField(
                                  minLines: 10,
                                  maxLines: 50,
                                  style: TextStyle(
                                      color: createPostController
                                              .descFocusNode.value
                                          ? AppColors.black
                                          : AppColors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                  keyboardAppearance: Brightness.light,
                                  textInputAction: TextInputAction.done,
                                  controller:
                                      createPostController.descTextController,
                                  keyboardType: TextInputType.multiline,
                                  decoration: InputDecoration(
                                    fillColor:
                                        createPostController.descFocusNode.value
                                            ? AppColors.white
                                            : AppColors.white,
                                    errorMaxLines: 5,
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 5.0, horizontal: 10.0),
                                    labelText: 'Description',
                                    labelStyle: TextStyle(
                                      color: AppColors.white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14.0,
                                    ),
                                    border: InputBorder.none,
                                    focusedErrorBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    focusColor: AppColors.white,
                                  ),
                                ),
                              ),
                            ),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            FocusScope.of(context).requestFocus();
                            createPostController.apiCreatePost();
                          },
                          child: Container(
                            height: 55,
                            width: Get.width * 0.8,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.white,
                                    spreadRadius: 5,
                                    // blurRadius: 7,
                                    offset: Offset(0, 3),
                                  ),
                                ]),
                            child: Center(
                              child: CommonWidgets.txtViewMediumBold(
                                "Post",
                                AppColors.black,
                                14,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
