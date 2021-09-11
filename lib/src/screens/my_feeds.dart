import 'package:flutter/material.dart';
import 'package:flutter_medium/src/clippers/line_clipper.dart';
import 'package:get/get.dart';
import 'package:flutter_medium/src/models/selectedfeeds_model.dart';

class MyFeeds extends StatefulWidget {
  const MyFeeds({Key? key}) : super(key: key);

  @override
  _MyFeedsState createState() => _MyFeedsState();
}

class _MyFeedsState extends State<MyFeeds> {
  int _selectedFeedIndex = 0;

  Widget _buildSelectedFeedRow(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFeedIndex = index;
        });
      },
      child: Container(
        width: Get.width * 0.18,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: _selectedFeedIndex == index
                      ? Colors.black
                      : Colors.black12),
              padding: EdgeInsets.all(8.0),
              child: Icon(
                demoSelectFeeds[index].img,
                color:
                    _selectedFeedIndex == index ? Colors.white : Colors.black,
              ),
            ),
            Container(
              width: Get.width * 0.20,
              child: Center(
                child: Text(
                  demoSelectFeeds[index].name,
                  softWrap: true,
                  style: TextStyle(
                    color: _selectedFeedIndex == index
                        ? Colors.black
                        : Colors.black54,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
                          padding: EdgeInsets.all(5.0),
                          width: Get.width * 0.10,
                          height: Get.width * 0.10,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: new Image.asset(
                            "assets/honkLogo.png",
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    // Selected Feeds are shown in row Here.
                    SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.max,
                          children: demoSelectFeeds
                              .asMap()
                              .entries
                              .map((MapEntry map) =>
                                  _buildSelectedFeedRow(map.key))
                              .toList(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Column(
                      children: [
                        ClipPath(
                          clipper: MyCustomClipperUpper(),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color.fromARGB(250, 19, 45, 64),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            width: Get.width,
                            height: Get.width * 1.10,
                            child: Container(
                              width: Get.width,
                              height: Get.width * 1.10,
                              color: Colors.amber,
                              margin: EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  Container(
                                    child: Text(
                                      "Top Readings",
                                      style:
                                          Theme.of(context).textTheme.headline1,
                                    ),
                                  ),
                                  Row(),
                                  Positioned(
                                    bottom: 0.0,
                                    right: 0.0,
                                    child: IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.expand_more_sharp),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        ClipPath(
                          clipper: MyCustomClipperMiddle(),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color.fromARGB(250, 19, 45, 64),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            width: Get.width,
                            height: 50,
                          ),
                        ),
                        ClipPath(
                          clipper: MyCustomClipperLower(),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color.fromARGB(250, 19, 45, 64),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            width: Get.width,
                            height: 50,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
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
            ),
          ],
        ),
      ),
    );
  }
}
