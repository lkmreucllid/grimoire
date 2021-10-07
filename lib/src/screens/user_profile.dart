import 'package:flutter/material.dart';
import 'package:flutter_medium/src/utils/app_colors.dart';
import 'package:flutter_medium/src/utils/common_widgets.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  String userName = "",
      userEmail = "",
      userContact = "",
      userAddress = "",
      userGender = "";

  void getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      userName = prefs.getString("name").capitalizeFirst;
      userEmail = prefs.getString("email");
      userContact = prefs.getString("contact");
      userAddress =
          prefs.getString("address") + ', ' + prefs.getString("country");
      userGender = prefs.getString("gender").capitalizeFirst;
    });
  }

  @override
  Widget build(BuildContext context) {
    getUserInfo();
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              width: Get.width,
              height: Get.height,
              color: AppColors.eggPlant,
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 25.0),
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new AssetImage("assets/user_profile.png"),
                  fit: BoxFit.fill,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: Get.height * 0.30,
                    width: Get.width,
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            "Hey,",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 25,
                              color: Colors.white60,
                            ),
                          ),
                        ),
                        Container(
                          child: Text(
                            userName,
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.bold,
                              fontSize: 35,
                              color: Colors.white60,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: 2.0,
                    color: Colors.white,
                    indent: 20,
                    endIndent: 20,
                  ),
                  Container(
                    height: Get.height * 0.15,
                    width: Get.width,
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            "here are your registered details:",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 12,
                              color: Colors.white60,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Container(
                          child: Row(
                            children: [
                              Text(
                                "Email: ",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 15,
                                  color: Colors.white60,
                                ),
                              ),
                              Text(
                                userEmail,
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.white60,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            children: [
                              Text(
                                "Address: ",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 15,
                                  color: Colors.white60,
                                ),
                              ),
                              Text(
                                userAddress,
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.white60,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            children: [
                              Text(
                                "Contact: ",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 15,
                                  color: Colors.white60,
                                ),
                              ),
                              Text(
                                userContact,
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.white60,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            children: [
                              Text(
                                "Gender: ",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 15,
                                  color: Colors.white60,
                                ),
                              ),
                              Text(
                                userGender,
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.white60,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: 2.0,
                    color: Colors.white,
                    indent: 20,
                    endIndent: 20,
                  ),
                  Container(
                    height: 55,
                    width: Get.width,
                    padding: const EdgeInsets.only(left: 15.0),
                    child: GestureDetector(
                      onTap: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setString("token", "");
                        Get.offNamed('/loginView');
                      },
                      child: Container(
                        height: 55,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.mustardColor,
                                spreadRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ]),
                        child: Center(
                          child: CommonWidgets.txtViewMediumBold(
                            "Logout",
                            AppColors.white,
                            14,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
