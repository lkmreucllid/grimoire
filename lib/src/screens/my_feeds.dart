import 'package:flutter/material.dart';
import 'package:flutter_medium/src/clippers/line_clipper.dart';
import 'package:flutter_medium/src/controller/feed_list_controller.dart';
import 'package:flutter_medium/src/controller/selected_category_controller.dart';
import 'package:flutter_medium/src/utils/app_colors.dart';
import 'package:get/get.dart';
import 'open_feed.dart';
import 'package:intl/intl.dart';

class MyFeeds extends StatefulWidget {
  @override
  _MyFeedsState createState() => _MyFeedsState();
}

class _MyFeedsState extends State<MyFeeds> {
  int _selectedFeedIndex = 0;

  final FeedListController _feedListController = Get.put(FeedListController());
  final SelectedCategoryController _selectedCategoryController =
      Get.put(SelectedCategoryController());
  var formattedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "My Feeds",
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    //Search and Profile image Row
                    Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: TextFormField(
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: Colors.black,
                                ),
                                labelText: "Find Feed",
                                labelStyle: TextStyle(
                                  color: Colors.black,
                                ),
                                border: InputBorder.none,
                                filled: true,
                                fillColor: Colors.grey[100],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10.0),
                        InkWell(
                          onTap: () => Get.toNamed('/userProfile'),
                          child: Container(
                            width: Get.width * 0.10,
                            height: Get.width * 0.10,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: AssetImage("assets/male.jpg"),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    // Selected Feeds are shown in row Here.
                    Container(
                      width: Get.width,
                      height: 90,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: GetBuilder<SelectedCategoryController>(
                          builder: (value) => _selectedCategoryController
                                      .isSelCategoryLoading.value ==
                                  true
                              ? Center(
                                  child: Container(
                                    height: 3,
                                    width: Get.width * 0.90,
                                    child: LinearProgressIndicator(
                                      backgroundColor: Colors.white,
                                    ),
                                  ),
                                )
                              : Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 150,
                                      width: Get.width,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: _selectedCategoryController
                                            .selectedCategoryList.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  _feedListController
                                                      .onItemClicked(index == 0
                                                          ? ""
                                                          : _selectedCategoryController
                                                              .selectedCategoryList[
                                                                  index]
                                                              .id);
                                                  _selectedFeedIndex = index;
                                                  _feedListController
                                                      .isLoadingFeeds
                                                      .value = true;
                                                });
                                              },
                                              child: Column(
                                                children: [
                                                  Container(
                                                    padding:
                                                        EdgeInsets.all(10.0),
                                                    height: 50,
                                                    width: 50,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(25),
                                                        color:
                                                            _selectedFeedIndex ==
                                                                    index
                                                                ? Colors.amber
                                                                : Colors
                                                                    .black12),
                                                    child: ImageIcon(
                                                      NetworkImage(
                                                          '${_selectedCategoryController.selectedCategoryList[index].img}'),
                                                      color:
                                                          _selectedFeedIndex ==
                                                                  index
                                                              ? Colors.white
                                                              : Colors.black,
                                                      size: 25,
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 30,
                                                    width: 90,
                                                    child: Center(
                                                      child: Text(
                                                        _selectedCategoryController
                                                            .selectedCategoryList[
                                                                index]
                                                            .name,
                                                        textAlign:
                                                            TextAlign.center,
                                                        softWrap: true,
                                                        style: TextStyle(
                                                          color:
                                                              _selectedFeedIndex ==
                                                                      index
                                                                  ? Colors.black
                                                                  : Colors
                                                                      .black54,
                                                          fontFamily: "Poppins",
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 10,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Column(
                      children: [
                        ClipPath(
                          clipper: MyCustomClipperUpper(),
                          child: Stack(
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                  top: 5.0,
                                  bottom: 25.0,
                                  left: 5.0,
                                  right: 5.0,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColorBlue,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                width: Get.width,
                                height: Get.height * 0.60,
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(
                                            top: 15.0, bottom: 15.0),
                                        child: Text(
                                          "Top Readings",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline2,
                                        ),
                                      ),
                                      GetBuilder<FeedListController>(
                                        init: FeedListController(),
                                        builder: (value) => _feedListController
                                                    .isLoadingFeeds.value ==
                                                true
                                            ? Expanded(
                                                child: Center(
                                                  child: Stack(
                                                    children: [
                                                      Container(
                                                        child: Image.asset(
                                                            'assets/loading.png'),
                                                      ),
                                                      Center(
                                                        child: Container(
                                                          height: 26,
                                                          width: 26,
                                                          child:
                                                              CircularProgressIndicator(
                                                            backgroundColor:
                                                                Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            : Expanded(
                                                child: _feedListController
                                                        .feedList.isEmpty
                                                    ? Center(
                                                        child: Container(
                                                          child: Image.asset(
                                                              'assets/oops_robo.png'),
                                                        ),
                                                      )
                                                    : RefreshIndicator(
                                                        onRefresh: () async {
                                                          _feedListController
                                                              .apiGetFeedsList();
                                                        },
                                                        child: ListView.builder(
                                                          itemCount:
                                                              _feedListController
                                                                  .feedList
                                                                  .length,
                                                          itemBuilder:
                                                              (context, index) {
                                                            DateTime date = DateTime.parse(
                                                                _feedListController
                                                                    .feedList[
                                                                        index]
                                                                    .createdDate);
                                                            formattedDate =
                                                                DateFormat.yMMMMd(
                                                                        'en_US')
                                                                    .format(
                                                                        date);
                                                            return Column(
                                                              children: [
                                                                Container(
                                                                  padding: EdgeInsets.only(
                                                                      top: 2.0,
                                                                      bottom:
                                                                          10.0),
                                                                  child:
                                                                      InkWell(
                                                                    onTap: () {
                                                                      Get.to(
                                                                          OpenFeed(
                                                                        feedId: _feedListController
                                                                            .feedList[index]
                                                                            .feedId,
                                                                      ));
                                                                    },
                                                                    child: Row(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Center(
                                                                          child:
                                                                              Column(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.center,
                                                                            children: [
                                                                              Container(
                                                                                width: Get.width * 0.90,
                                                                                child: Text(
                                                                                  "${_feedListController.feedList[index].userName} in ${_feedListController.feedList[index].categoryName}",
                                                                                  softWrap: true,
                                                                                  maxLines: 1,
                                                                                  style: TextStyle(
                                                                                    fontFamily: "Poppins",
                                                                                    fontWeight: FontWeight.bold,
                                                                                    fontSize: 12,
                                                                                    color: Colors.white60,
                                                                                  ),
                                                                                  textAlign: TextAlign.center,
                                                                                ),
                                                                              ),
                                                                              Container(
                                                                                width: Get.width * 0.90,
                                                                                child: Text(
                                                                                  _feedListController.feedList[index].title,
                                                                                  softWrap: true,
                                                                                  maxLines: 1,
                                                                                  style: TextStyle(
                                                                                    fontFamily: "Poppins",
                                                                                    fontWeight: FontWeight.bold,
                                                                                    fontSize: 15,
                                                                                    color: Colors.white60,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Container(
                                                                                width: Get.width * 0.90,
                                                                                child: Text(
                                                                                  _feedListController.feedList[index].bodyText,
                                                                                  softWrap: true,
                                                                                  maxLines: 2,
                                                                                  style: TextStyle(
                                                                                    fontFamily: "Poppins",
                                                                                    fontSize: 12,
                                                                                    color: Colors.white60,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Container(
                                                                                width: Get.width * 0.90,
                                                                                child: Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                  children: [
                                                                                    Text(
                                                                                      "${_feedListController.feedList[index].likes.toString()} likes",
                                                                                      softWrap: true,
                                                                                      maxLines: 2,
                                                                                      style: TextStyle(
                                                                                        fontFamily: "Poppins",
                                                                                        fontSize: 12,
                                                                                        fontWeight: FontWeight.bold,
                                                                                        color: Colors.white60,
                                                                                      ),
                                                                                    ),
                                                                                    /* _feedListController.feedList[index].isLiked == true
                                                                                        ? new Icon(
                                                                                            Icons.favorite,
                                                                                            color: Colors.red,
                                                                                          )
                                                                                        : new Icon(
                                                                                            Icons.favorite,
                                                                                            color: Colors.black,
                                                                                          ),*/
                                                                                    Text(
                                                                                      formattedDate,
                                                                                      softWrap: true,
                                                                                      maxLines: 2,
                                                                                      style: TextStyle(
                                                                                        fontFamily: "Poppins",
                                                                                        fontSize: 12,
                                                                                        fontWeight: FontWeight.bold,
                                                                                        color: Colors.white60,
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                                Divider(
                                                                  height: 2.0,
                                                                  color: Colors
                                                                      .white,
                                                                  indent: 10,
                                                                  endIndent: 10,
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        ),
                                                      ),
                                              ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              /*Positioned(
                                bottom: 10.0,
                                right: 10.0,
                                child: Container(
                                  margin: EdgeInsets.only(top: 10.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: AppColors.primaryLightBlueColor,
                                  ),
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.expand_more_sharp,
                                    color: Colors.white,
                                  ),
                                ),
                              ),*/
                            ],
                          ),
                        ),
                        Container(
                          child: FloatingActionButton(
                            backgroundColor: Colors.white,
                            onPressed: () {
                              Get.back();
                              Get.toNamed('/createPost');
                            },
                            child: Icon(
                              Icons.mode_edit_sharp,
                              color: Colors.amber,
                            ),
                          ),
                        ),
                        /* ClipPath(
                          clipper: MyCustomClipperLower(),
                          child: Container(
                            padding: EdgeInsets.only(
                              top: 25.0,
                              bottom: 5.0,
                              left: 5.0,
                              right: 5.0,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            width: Get.width,
                            height: Get.height * 0.15,
                            child: GetBuilder<OpenFeedController>(
                              init: OpenFeedController(),
                              builder: (value) => _openFeedController
                                          .isLoadingFeed.value ==
                                      true
                                  ? Stack(
                                      children: [
                                        Container(
                                          height: Get.height,
                                          width: Get.width,
                                          color: AppColors.primaryColorBlue,
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
                                  : Container(
                                      height: Get.height,
                                      padding: EdgeInsets.all(10.0),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: Get.width * 0.90,
                                              child: Text(
                                                "Currently Reading",
                                                softWrap: true,
                                                maxLines: 1,
                                                style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 10,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: Get.width * 0.90,
                                              child: Text(
                                                _openFeedController
                                                    .updateFeedModel.title,
                                                softWrap: true,
                                                maxLines: 1,
                                                style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: Get.width * 0.90,
                                              child: Text(
                                                _openFeedController
                                                    .updateFeedModel.bodyText,
                                                softWrap: true,
                                                maxLines: 2,
                                                style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontSize: 12,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                            ),
                          ),
                        ),*/
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
