import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_medium/src/authentication/login_screen.dart';
import 'package:flutter_medium/src/clippers/line_clipper.dart';
import 'package:flutter_medium/src/controller/feed_list_controller.dart';
import 'package:flutter_medium/src/controller/selected_category_controller.dart';
import 'package:flutter_medium/src/utils/app_colors.dart';
import 'package:flutter_medium/src/utils/utility.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'open_feed.dart';

class MyFeeds extends StatefulWidget {
  @override
  _MyFeedsState createState() => _MyFeedsState();
}

class _MyFeedsState extends State<MyFeeds> {
  int _selectedFeedIndex = 0;

  final FeedListController _feedListController = Get.put(FeedListController());
  final SelectedCategoryController _selectedCategoryController =
      Get.put(SelectedCategoryController());

  startTimer() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigatePage);
  }

  void navigatePage() async {
    //Get.to(() => OpenFeed());
    Get.to(() => LoginScreen());
  }

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
                      height: 20,
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
                        Container(
                          width: Get.width * 0.10,
                          height: Get.width * 0.10,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: AssetImage("assets/dummyIcon3.jpeg"),
                                fit: BoxFit.fill,
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
                      width: Get.size.width,
                      height: 90,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: GetBuilder<SelectedCategoryController>(
                          builder: (value) => Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 150,
                                width: Get.size.width,
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
                                            _feedListController.onItemClicked(
                                                _selectedCategoryController
                                                    .selectedCategoryList[index]
                                                    .id);
                                            _selectedFeedIndex = index;
                                            _feedListController
                                                .isLoading.value = true;
                                          });
                                        },
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 50,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                  color: _selectedFeedIndex ==
                                                          index
                                                      ? Colors.red
                                                      : Colors.black12),
                                              child: IconButton(
                                                //onPressed: () {},
                                                icon: Image.network(
                                                    '${_selectedCategoryController.selectedCategoryList[index].img}'),
                                                color:
                                                    _selectedFeedIndex == index
                                                        ? Colors.white
                                                        : Colors.black,
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
                                                  textAlign: TextAlign.center,
                                                  softWrap: true,
                                                  style: TextStyle(
                                                    color: _selectedFeedIndex ==
                                                            index
                                                        ? Colors.black
                                                        : Colors.black54,
                                                    fontFamily: "Poppins",
                                                    fontWeight: FontWeight.bold,
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
                                height: Get.width * 1.15,
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
                                        builder:
                                            (value) =>
                                                _feedListController
                                                            .isLoading.value ==
                                                        true
                                                    ? Expanded(
                                                        child: Center(
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
                                                      )
                                                    : Expanded(
                                                        child:
                                                            _feedListController
                                                                    .feedList
                                                                    .isEmpty
                                                                ? Center(
                                                                    child:
                                                                        Container(
                                                                      child: Text(
                                                                          "No Feeds Found",
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Colors.white60,
                                                                            fontFamily:
                                                                                "Poppins",
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontSize:
                                                                                12,
                                                                          )),
                                                                    ),
                                                                  )
                                                                : ListView
                                                                    .builder(
                                                                    itemCount: _feedListController
                                                                        .feedList
                                                                        .length,
                                                                    itemBuilder:
                                                                        (context,
                                                                            index) {
                                                                      return InkWell(
                                                                        onTap:
                                                                            () {
                                                                          Utility.showMessage(
                                                                              "Testing: ",
                                                                              "Hello");
                                                                          startTimer();
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          padding: EdgeInsets.only(
                                                                              top: 2.0,
                                                                              bottom: 2.0),
                                                                          child:
                                                                              InkWell(
                                                                            onTap:
                                                                                () {
                                                                              Get.to(OpenFeed(
                                                                                feedId: _feedListController.feedList[index].feedId,
                                                                              ));
                                                                            },
                                                                            child:
                                                                                Row(
                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                              children: [
                                                                                Container(
                                                                                  width: Get.width * 0.20,
                                                                                  height: Get.width * 0.20,
                                                                                  padding: EdgeInsets.all(10.0),
                                                                                  child: Container(
                                                                                    decoration: BoxDecoration(
                                                                                      borderRadius: BorderRadius.circular(10),
                                                                                      image: DecorationImage(
                                                                                        image: AssetImage("assets/user_Tomhardy.jpg"),
                                                                                        fit: BoxFit.fill,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Center(
                                                                                  child: Column(
                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                                                    children: [
                                                                                      Container(
                                                                                        width: Get.width * 0.70,
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
                                                                                        width: Get.width * 0.70,
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
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      );
                                                                    },
                                                                  ),
                                                      ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
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
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          right: Get.width / 2,
                          child: FloatingActionButton(
                            backgroundColor: Colors.white,
                            onPressed: () {},
                            child: Icon(
                              Icons.mode_edit_sharp,
                              color: Colors.amber,
                            ),
                          ),
                        ),
                        ClipPath(
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
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: Get.width * 0.15,
                                  height: Get.width * 0.15,
                                  child: new Image.asset(
                                    "assets/honkLogo.png",
                                    scale: 5.0,
                                  ),
                                ),
                                Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: Get.width * 0.70,
                                        child: Text(
                                          'Discover Your Path To Success Discover Your Path To Success',
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
                                        width: Get.width * 0.70,
                                        child: Text(
                                          'Hello, this is for Testing purpose only. Hello, this is for Testing purpose only. Hello, this is for Testing purpose only. Hello, this is for Testing purpose only. Hello, this is for Testing purpose only. Hello, this is for Testing purpose only. Hello, this is for Testing purpose only. Hello, this is for Testing purpose only. Hello, this is for Testing purpose only. Hello, this is for Testing purpose only. Hello, this is for Testing purpose only. ',
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
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            /* Positioned(
              bottom: 15.0,
              right: 15.0,
              child: FloatingActionButton(
                backgroundColor: Colors.white,
                onPressed: () {},
                child: Icon(
                  Icons.mode_edit_sharp,
                  color: Colors.amber,
                ),
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}
