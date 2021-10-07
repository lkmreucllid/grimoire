import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_medium/src/controller/signup_controller.dart';
import 'package:flutter_medium/src/utils/app_colors.dart';
import 'package:flutter_medium/src/utils/common_widgets.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final SignUpController _signUpController = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SingleChildScrollView(
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
                color: Color(0x000000).withOpacity(0.2),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 20.0, bottom: 10.0, left: 10.0, right: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Join Us",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.only(left: 32, right: 32, top: 50.0),
                        child: Column(
                          children: [
                            Obx(() => Focus(
                                  onFocusChange: (hasFocus) {
                                    _signUpController.nameFocusNode.value =
                                        hasFocus;
                                  },
                                  child: PhysicalModel(
                                    elevation:
                                        _signUpController.nameFocusNode.value
                                            ? 5
                                            : 0,
                                    color: _signUpController.nameFocusNode.value
                                        ? AppColors.white
                                        : Colors.transparent,
                                    child: TextFormField(
                                      keyboardAppearance: Brightness.light,
                                      textInputAction: TextInputAction.done,
                                      style: TextStyle(
                                          color: AppColors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                      controller:
                                          _signUpController.nameTextController,
                                      validator: _signUpController.validateName,
                                      decoration: InputDecoration(
                                        fillColor: _signUpController
                                                .nameFocusNode.value
                                            ? AppColors.white
                                            : Colors.transparent,
                                        errorMaxLines: 5,
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 5.0, horizontal: 10.0),
                                        labelText: 'Name',
                                        labelStyle: TextStyle(
                                          color: AppColors.white,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14.0,
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColors.darkGrey),
                                        ),
                                        focusedErrorBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        focusColor: AppColors.black,
                                      ),
                                    ),
                                  ),
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            Obx(() => Focus(
                                  onFocusChange: (hasFocus) {
                                    _signUpController.emailFocusNode.value =
                                        hasFocus;
                                  },
                                  child: PhysicalModel(
                                    elevation:
                                        _signUpController.emailFocusNode.value
                                            ? 5
                                            : 0,
                                    color:
                                        _signUpController.emailFocusNode.value
                                            ? AppColors.white
                                            : Colors.transparent,
                                    child: TextFormField(
                                      keyboardAppearance: Brightness.light,
                                      textInputAction: TextInputAction.done,
                                      style: TextStyle(
                                          color: AppColors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                      controller:
                                          _signUpController.emailTextController,
                                      validator:
                                          _signUpController.validateEmail,
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                        fillColor: _signUpController
                                                .emailFocusNode.value
                                            ? AppColors.white
                                            : Colors.transparent,
                                        errorMaxLines: 5,
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 5.0, horizontal: 10.0),
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
                                        focusedErrorBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        focusColor: AppColors.black,
                                      ),
                                    ),
                                  ),
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            Obx(() => Focus(
                                  onFocusChange: (hasFocus) {
                                    _signUpController.passwordFocusNode.value =
                                        hasFocus;
                                  },
                                  child: PhysicalModel(
                                    elevation: _signUpController
                                            .passwordFocusNode.value
                                        ? 5
                                        : 0,
                                    color: _signUpController
                                            .passwordFocusNode.value
                                        ? AppColors.white
                                        : Colors.transparent,
                                    child: TextFormField(
                                      obscureText:
                                          _signUpController.obscureText.value,
                                      keyboardAppearance: Brightness.light,
                                      textInputAction: TextInputAction.done,
                                      style: TextStyle(
                                          color: AppColors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                      controller: _signUpController
                                          .passwordTextController,
                                      validator:
                                          _signUpController.validatePassword,
                                      decoration: InputDecoration(
                                        fillColor: _signUpController
                                                .passwordFocusNode.value
                                            ? AppColors.white
                                            : Colors.transparent,
                                        suffixIconConstraints: BoxConstraints(
                                            minWidth: 43, minHeight: 40),
                                        suffixIcon: InkWell(
                                            onTap: () =>
                                                _signUpController.toggle(),
                                            child: _signUpController
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
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 5.0, horizontal: 10.0),
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
                                        focusedErrorBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        focusColor: AppColors.black,
                                      ),
                                    ),
                                  ),
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            Obx(() => Focus(
                                  onFocusChange: (hasFocus) {
                                    _signUpController.confirmPasswordFocusNode
                                        .value = hasFocus;
                                  },
                                  child: PhysicalModel(
                                    elevation: _signUpController
                                            .confirmPasswordFocusNode.value
                                        ? 5
                                        : 0,
                                    color: _signUpController
                                            .confirmPasswordFocusNode.value
                                        ? AppColors.white
                                        : Colors.transparent,
                                    child: TextFormField(
                                      obscureText: _signUpController
                                          .obscureConfirmText.value,
                                      keyboardAppearance: Brightness.light,
                                      textInputAction: TextInputAction.done,
                                      style: TextStyle(
                                          color: AppColors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                      controller: _signUpController
                                          .confirmPasswordTextController,
                                      validator: _signUpController
                                          .validateConfirmPassword,
                                      decoration: InputDecoration(
                                        fillColor: _signUpController
                                                .confirmPasswordFocusNode.value
                                            ? AppColors.white
                                            : Colors.transparent,
                                        suffixIconConstraints: BoxConstraints(
                                            minWidth: 43, minHeight: 40),
                                        suffixIcon: InkWell(
                                            onTap: () => _signUpController
                                                .toggleConfirm(),
                                            child: _signUpController
                                                    .obscureConfirmText.value
                                                ? Image.asset(
                                                    'assets/showEyeIcon.png',
                                                    scale: 2,
                                                  )
                                                : Image.asset(
                                                    'assets/hideEyeIcon.png',
                                                    scale: 2,
                                                  )),
                                        errorMaxLines: 3,
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 5.0, horizontal: 10.0),
                                        labelText: 'Confirm Password',
                                        labelStyle: TextStyle(
                                          color: AppColors.white,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14.0,
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColors.darkGrey),
                                        ),
                                        focusedErrorBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        focusColor: AppColors.black,
                                      ),
                                    ),
                                  ),
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            Obx(() => Focus(
                                  onFocusChange: (hasFocus) {
                                    _signUpController.contactFocusNode.value =
                                        hasFocus;
                                  },
                                  child: PhysicalModel(
                                    elevation:
                                        _signUpController.contactFocusNode.value
                                            ? 5
                                            : 0,
                                    color:
                                        _signUpController.contactFocusNode.value
                                            ? AppColors.white
                                            : Colors.transparent,
                                    child: TextFormField(
                                      keyboardAppearance: Brightness.light,
                                      textInputAction: TextInputAction.done,
                                      style: TextStyle(
                                          color: AppColors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                      controller: _signUpController
                                          .contactTextController,
                                      validator:
                                          _signUpController.validateContact,
                                      keyboardType: TextInputType.phone,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp('[0-9]')),
                                      ],
                                      decoration: InputDecoration(
                                        fillColor: _signUpController
                                                .contactFocusNode.value
                                            ? AppColors.white
                                            : Colors.transparent,
                                        errorMaxLines: 3,
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 5.0, horizontal: 10.0),
                                        labelText: 'Contact',
                                        labelStyle: TextStyle(
                                          color: AppColors.white,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14.0,
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColors.darkGrey),
                                        ),
                                        focusedErrorBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        focusColor: AppColors.black,
                                      ),
                                    ),
                                  ),
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            CountryListPick(
                              theme: CountryTheme(
                                isShowFlag: false,
                                isShowTitle: true,
                                isShowCode: false,
                                isDownIcon: true,
                                showEnglishName: true,
                                labelColor: AppColors.white,
                              ),
                              initialSelection: '+91',
                              onChanged: (CountryCode code) {
                                _signUpController.country.value = code.name;
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Obx(() => Focus(
                                  onFocusChange: (hasFocus) {
                                    _signUpController.addressFocusNode.value =
                                        hasFocus;
                                  },
                                  child: PhysicalModel(
                                    elevation:
                                        _signUpController.addressFocusNode.value
                                            ? 5
                                            : 0,
                                    color:
                                        _signUpController.addressFocusNode.value
                                            ? AppColors.white
                                            : Colors.transparent,
                                    child: TextFormField(
                                      keyboardAppearance: Brightness.light,
                                      textInputAction: TextInputAction.done,
                                      style: TextStyle(
                                          color: AppColors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                      controller: _signUpController
                                          .addressTextController,
                                      validator:
                                          _signUpController.validateAddress,
                                      decoration: InputDecoration(
                                        fillColor: _signUpController
                                                .addressFocusNode.value
                                            ? AppColors.white
                                            : Colors.transparent,
                                        errorMaxLines: 3,
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 5.0, horizontal: 10.0),
                                        labelText: 'Address',
                                        labelStyle: TextStyle(
                                          color: AppColors.white,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14.0,
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColors.darkGrey),
                                        ),
                                        focusedErrorBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        focusColor: AppColors.black,
                                      ),
                                    ),
                                  ),
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            Obx(
                              () => Focus(
                                onFocusChange: (hasFocus) {
                                  _signUpController.genderFocusNode.value =
                                      hasFocus;
                                },
                                child: DropdownButton<String>(
                                  value: _signUpController.gender.value,
                                  icon: const Icon(Icons.arrow_drop_down),
                                  iconSize: 16,
                                  elevation: 16,
                                  style: TextStyle(color: Colors.blue),
                                  onChanged: (String newValue) {
                                    setState(() {
                                      _signUpController.gender.value = newValue;
                                    });
                                  },
                                  items: <String>['Male', 'Female', 'Other']
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: GestureDetector(
                                onTap: () {
                                  FocusScope.of(context).requestFocus();
                                  _signUpController.apisignUp();
                                },
                                child: Container(
                                  height: 55,
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
                                      "Sign Up",
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
                                Get.toNamed('/loginView');
                              },
                              child: Text(
                                "Login",
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Get.toNamed('/needHelp');
                              },
                              child: Text(
                                "Need Help?",
                                style: Theme.of(context).textTheme.headline6,
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
        ),
      ),
    );
  }
}
