import 'package:flutter/material.dart';
import 'package:flutter_medium/src/controller/open_feed_controller.dart';
import 'package:flutter_medium/src/utils/app_colors.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OpenFeed extends StatefulWidget {
  final feedId;

  const OpenFeed({Key key, this.feedId}) : super(key: key);

  @override
  _OpenFeedState createState() => _OpenFeedState();
}

class _OpenFeedState extends State<OpenFeed> {
  final OpenFeedController _openFeedController = Get.put(OpenFeedController());

  var formattedDate;

  @override
  Widget build(BuildContext context) {
    _openFeedController.apiGetFeed(widget.feedId);

    return Scaffold(
      body: SafeArea(
        child: GetBuilder<OpenFeedController>(
          init: OpenFeedController(),
          builder: (value) => _openFeedController.isLoadingFeed.value == true
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
              : Container(
                  height: Get.height,
                  padding: EdgeInsets.all(10.0),
                  color: AppColors.primaryColorBlue,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          width: Get.width,
                          color: AppColors.primaryColorBlue,
                          child: Text(
                            _openFeedController.openFeedModel.title,
                            softWrap: true,
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white60,
                            ),
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: EdgeInsets.all(5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                _openFeedController.openFeedModel.userName,
                                softWrap: true,
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                DateFormat.yMMMMd('en_US').format(
                                    DateTime.parse(_openFeedController
                                        .openFeedModel.createdDate)),
                                softWrap: true,
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Container(
                          width: Get.width,
                          color: AppColors.primaryColorBlue,
                          child: Text(
                            _openFeedController.openFeedModel.bodyText,
                            softWrap: true,
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 15,
                              color: Colors.white60,
                            ),
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: EdgeInsets.all(5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: 1 == 1
                                    ? Icon(
                                        Icons.favorite,
                                        color: Colors.red,
                                      )
                                    : Icon(
                                        Icons.favorite_border,
                                        color: Colors.black,
                                      ),
                              ),
                              Text(
                                "${_openFeedController.openFeedModel.likes.toString()} likes",
                                softWrap: true,
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: 1 == 1
                                    ? Icon(
                                        Icons.bookmark,
                                        color: Colors.black,
                                      )
                                    : Icon(
                                        Icons.bookmark_border,
                                        color: Colors.black,
                                      ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
