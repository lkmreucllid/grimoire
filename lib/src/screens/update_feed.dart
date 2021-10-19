import 'package:flutter/material.dart';
import 'package:flutter_medium/src/controller/selected_category_controller.dart';
import 'package:flutter_medium/src/controller/update_feed_controller.dart';
import 'package:flutter_medium/src/models/selected_category_model.dart';
import 'package:flutter_medium/src/utils/app_colors.dart';
import 'package:flutter_medium/src/utils/common_widgets.dart';
import 'package:get/get.dart';

class UpdatePost extends StatefulWidget {
  final feedId;
  const UpdatePost({Key key, this.feedId}) : super(key: key);

  @override
  _UpdatePostState createState() => _UpdatePostState();
}

class _UpdatePostState extends State<UpdatePost> {
  final UpdateFeedController _updateFeedController =
      Get.put(UpdateFeedController());
  final SelectedCategoryController selectedCategoryController = Get.find();

  SelectedCategoryList selectedCategory;
  @override
  void initState() {
    super.initState();
    selectedCategory = selectedCategoryController.selectedCategoryList[0];
  }

  @override
  Widget build(BuildContext context) {
    _updateFeedController.apiGetFeedUpdate(widget.feedId);
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<UpdateFeedController>(
          builder: (value) => _updateFeedController.isLoadingFeed.value == true
              ? Stack(
                  children: [
                    Container(
                      height: Get.height,
                      width: Get.width,
                      color: AppColors.primaryColorBlue,
                    ),
                    Center(
                      child: Container(
                        child: Image.asset('assets/processing_orange.png'),
                      ),
                    ),
                    Center(
                      child: Container(
                        height: 26,
                        width: 26,
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                )
              : Stack(
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
                              SizedBox(
                                height: 10.0,
                              ),
                              /* DropdownButton<SelectedCategoryList>(
                                value: selectedCategoryController
                                    .selectedCategoryList
                                    .singleWhere((element) =>
                                        element.id ==
                                        _updateFeedController
                                            .openFeedModel.categoryId),
                                icon: const Icon(Icons.arrow_drop_down),
                                iconSize: 16,
                                elevation: 16,
                                style: TextStyle(color: Colors.amber),
                                onChanged: (SelectedCategoryList newValue) {
                                  setState(() {
                                    selectedCategory = newValue;
                                    _updateFeedController.selectedCategory
                                        .value = selectedCategory.id;
                                    _updateFeedController.selectedCategoryName
                                        .value = selectedCategory.name;
                                  });
                                },
                                items: selectedCategoryController
                                    .selectedCategoryList
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
                              ),*/
                              Obx(() => Focus(
                                    onFocusChange: (hasFocus) {
                                      _updateFeedController
                                          .titleFocusNode.value = hasFocus;
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      height: 100.0,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: PhysicalModel(
                                        elevation: _updateFeedController
                                                .titleFocusNode.value
                                            ? 5
                                            : 0,
                                        color: _updateFeedController
                                                .titleFocusNode.value
                                            ? AppColors.white
                                            : Colors.transparent,
                                        child: TextField(
                                          minLines: 2,
                                          maxLines: 5,
                                          style: TextStyle(
                                              color: _updateFeedController
                                                      .titleFocusNode.value
                                                  ? AppColors.black
                                                  : AppColors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                          keyboardAppearance: Brightness.light,
                                          textInputAction: TextInputAction.done,
                                          controller: _updateFeedController
                                              .titleTextController,
                                          decoration: InputDecoration(
                                            fillColor: _updateFeedController
                                                    .titleFocusNode.value
                                                ? AppColors.white
                                                : AppColors.black,
                                            errorMaxLines: 5,
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 5.0,
                                                    horizontal: 10.0),
                                            labelText: 'Title',
                                            labelStyle: TextStyle(
                                              color: AppColors.black,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14.0,
                                            ),
                                            border: InputBorder.none,
                                            focusedErrorBorder:
                                                InputBorder.none,
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
                                      _updateFeedController
                                          .descFocusNode.value = hasFocus;
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      height: 600.0,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: PhysicalModel(
                                        elevation: _updateFeedController
                                                .descFocusNode.value
                                            ? 5
                                            : 0,
                                        color: _updateFeedController
                                                .descFocusNode.value
                                            ? AppColors.white
                                            : Colors.transparent,
                                        child: TextField(
                                          minLines: 10,
                                          maxLines: 50,
                                          style: TextStyle(
                                              color: _updateFeedController
                                                      .descFocusNode.value
                                                  ? AppColors.black
                                                  : AppColors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                          keyboardAppearance: Brightness.light,
                                          textInputAction: TextInputAction.done,
                                          controller: _updateFeedController
                                              .descTextController,
                                          keyboardType: TextInputType.multiline,
                                          decoration: InputDecoration(
                                            fillColor: _updateFeedController
                                                    .descFocusNode.value
                                                ? AppColors.white
                                                : AppColors.white,
                                            errorMaxLines: 5,
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 5.0,
                                                    horizontal: 10.0),
                                            labelText: 'Description',
                                            labelStyle: TextStyle(
                                              color: AppColors.black,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14.0,
                                            ),
                                            border: InputBorder.none,
                                            focusedErrorBorder:
                                                InputBorder.none,
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
                                    _updateFeedController
                                        .updateFeed(widget.feedId);
                                  },
                                  child: Container(
                                    height: 55,
                                    width: Get.width * 0.8,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50)),
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
                                        "Update",
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
      ),
    );
  }
}
