import 'package:flutter/material.dart';
import 'package:flutter_medium/src/controller/login_controller.dart';
import 'package:flutter_medium/src/utils/app_colors.dart';
import 'package:flutter_medium/src/utils/common_widgets.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  final LoginController loginController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: Get.width,
            height: Get.height,
            child: Stack(
              children: [
                Center(
                  child: Image.asset("assets/loginscreen_jpg.jpg"),
                ),
                Container(
                  height: Get.height,
                  width: Get.width,
                  color: AppColors.primaryColorBlue,
                ),
                Container(
                  width: Get.width,
                  height: Get.height,
                  color: Color(0xFFFFFFFF).withOpacity(0.2),
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 20.0, bottom: 10.0, left: 10.0, right: 10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Welcome Back",
                            style: Theme.of(context).textTheme.headline1,
                          ),
                          Container(
                            padding:
                                EdgeInsets.only(left: 32, right: 32, top: 50.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Obx(() => Focus(
                                      onFocusChange: (hasFocus) {
                                        loginController.emailFocusNode.value =
                                            hasFocus;
                                      },
                                      child: PhysicalModel(
                                        elevation:
                                            loginController.emailFocusNode.value
                                                ? 5
                                                : 0,
                                        color:
                                            loginController.emailFocusNode.value
                                                ? AppColors.white
                                                : Colors.transparent,
                                        child: TextFormField(
                                          keyboardAppearance: Brightness.light,
                                          textInputAction: TextInputAction.done,
                                          style: TextStyle(
                                              color: AppColors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                          controller: loginController
                                              .emailTextController,
                                          validator:
                                              loginController.validateEmail,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          decoration: InputDecoration(
                                            fillColor: loginController
                                                    .emailFocusNode.value
                                                ? AppColors.white
                                                : Colors.transparent,
                                            errorMaxLines: 5,
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 5.0,
                                                    horizontal: 10.0),
                                            labelText: 'Email',
                                            labelStyle: TextStyle(
                                              color: AppColors.white,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14.0,
                                            ),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: AppColors.darkGrey),
                                            ),
                                            focusedErrorBorder:
                                                InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            focusColor: AppColors.black,
                                          ),
                                        ),
                                      ),
                                    )),
                                SizedBox(
                                  height: 20,
                                ),
                                Obx(() => Focus(
                                      onFocusChange: (hasFocus) {
                                        loginController
                                            .passwordFocusNode.value = hasFocus;
                                      },
                                      child: PhysicalModel(
                                        elevation: loginController
                                                .passwordFocusNode.value
                                            ? 5
                                            : 0,
                                        color: loginController
                                                .passwordFocusNode.value
                                            ? AppColors.white
                                            : Colors.transparent,
                                        child: TextFormField(
                                          obscureText:
                                              loginController.obscureText.value,
                                          keyboardAppearance: Brightness.light,
                                          textInputAction: TextInputAction.done,
                                          style: TextStyle(
                                              color: AppColors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                          controller: loginController
                                              .passwordTextController,
                                          validator:
                                              loginController.validatePassword,
                                          decoration: InputDecoration(
                                            fillColor: loginController
                                                    .passwordFocusNode.value
                                                ? AppColors.white
                                                : Colors.transparent,
                                            suffixIconConstraints:
                                                BoxConstraints(
                                                    minWidth: 43,
                                                    minHeight: 40),
                                            suffixIcon: InkWell(
                                                onTap: () =>
                                                    loginController.toggle(),
                                                child: loginController
                                                        .obscureText.value
                                                    ? Image.asset(
                                                        'assets/showEyeIcon.png',
                                                        scale: 2,
                                                      )
                                                    : Image.asset(
                                                        'assets/hideEyeIcon.png',
                                                        scale: 2,
                                                      )),
                                            errorMaxLines: 3,
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 5.0,
                                                    horizontal: 10.0),
                                            labelText: 'Password',
                                            labelStyle: TextStyle(
                                              color: AppColors.white,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14.0,
                                            ),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: AppColors.darkGrey),
                                            ),
                                            focusedErrorBorder:
                                                InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            focusColor: AppColors.black,
                                          ),
                                        ),
                                      ),
                                    )),
                                SizedBox(
                                  height: 30,
                                ),
                                Center(
                                  child: GestureDetector(
                                    onTap: () {
                                      FocusScope.of(context).requestFocus();
                                      loginController.apiLogin();
                                    },
                                    child: Container(
                                      height: 55,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(50)),
                                          boxShadow: [
                                            BoxShadow(
                                              color: AppColors.white,
                                              spreadRadius: 5,
                                              blurRadius: 7,
                                              offset: Offset(0, 3),
                                            ),
                                          ]),
                                      child: Center(
                                        child: CommonWidgets.txtViewMediumBold(
                                          "Login",
                                          AppColors.black,
                                          14,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Get.toNamed('/signUpView');
                                  },
                                  child: Text(
                                    "Create Account",
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Get.toNamed('/feedsView');
                                  },
                                  child: Text(
                                    "Need Help?",
                                    style:
                                        Theme.of(context).textTheme.headline6,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
