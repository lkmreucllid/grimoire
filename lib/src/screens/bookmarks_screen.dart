import 'package:flutter/material.dart';
import 'package:flutter_medium/src/controller/bookmarks_controller.dart';
import 'package:flutter_medium/src/screens/open_feed.dart';
import 'package:get/get.dart';

class BookmarksScreen extends StatelessWidget {
  final BookmarkController _bookmarkController = Get.put(BookmarkController());

  @override
  Widget build(BuildContext context) {
    _bookmarkController.getAllBookMarks();
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<BookmarkController>(
          builder: (value) =>
              _bookmarkController.isBookmarkScreenLoading.value == true
                  ? Expanded(
                      child: Center(
                        child: Stack(
                          children: [
                            Container(
                              child: Image.asset('assets/loading.png'),
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
                        ),
                      ),
                    )
                  : Stack(
                      children: [
                        Container(
                          height: Get.height,
                          width: Get.width,
                          color: Colors.grey[200],
                        ),
                        Center(
                          child: _bookmarkController.bookmarkList.isEmpty
                              ? Center(
                                  child: Container(
                                    child: Image.asset('assets/oops_robo.png'),
                                  ),
                                )
                              : ListView.builder(
                                  itemCount:
                                      _bookmarkController.bookmarkList.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        InkWell(
                                          onTap: () => Get.to(OpenFeed(
                                            feedId: _bookmarkController
                                                .bookmarkList[index].feedId,
                                          )),
                                          child: Container(
                                            width: Get.width,
                                            height: 100.0,
                                            decoration: BoxDecoration(
                                              color: Colors.grey[200],
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10.0)),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey[500],
                                                  offset: Offset(4.0, 4.0),
                                                  blurRadius: 5.0,
                                                  spreadRadius: 1.0,
                                                ),
                                                BoxShadow(
                                                  color: Colors.white,
                                                  offset: Offset(-4.0, -4.0),
                                                  blurRadius: 5.0,
                                                  spreadRadius: 1.0,
                                                )
                                              ],
                                            ),
                                            padding: EdgeInsets.all(5.0),
                                            margin: EdgeInsets.all(10.0),
                                            child: Text(
                                                _bookmarkController
                                                    .bookmarkList[index].title,
                                                softWrap: true,
                                                maxLines: 2,
                                                style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontSize: 14,
                                                  color: Colors.black,
                                                )),
                                          ),
                                        ),
                                        Divider(
                                          height: 2.0,
                                          color: Colors.black,
                                          indent: 10,
                                          endIndent: 10,
                                        ),
                                      ],
                                    );
                                  }),
                        ),
                      ],
                    ),
        ),
      ),
    );
  }
}
