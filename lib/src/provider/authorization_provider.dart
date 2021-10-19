import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_medium/src/utils/utility.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends GetConnect {
  Future<Response> checkLogin(String url) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token");
      final res = await http
          .get(Uri.parse(url), headers: {'Authorization': 'Bearer $token'});
      return Response(statusCode: res.statusCode, body: json.decode(res.body));
    } on SocketException {
      Get.back();
      Utility.showMessage(
          "No Internet Connection", "Please check your internet connection");
      return null;
    } on TimeoutException {
      Get.back();
      Utility.showMessage("Alert!", "Connection timed out");
      return null;
    } catch (e) {
      Utility.showMessage("Alert!", e.toString());
      return null;
    }
  }

  Future<Response> logout(String url) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token");
      final res = await http
          .patch(Uri.parse(url), headers: {'Authorization': 'Bearer $token'});
      return Response(statusCode: res.statusCode, body: json.decode(res.body));
    } on SocketException {
      Get.back();
      Utility.showMessage(
          "No Internet Connection", "Please check your internet connection");
      return null;
    } on TimeoutException {
      Get.back();
      Utility.showMessage("Alert!", "Connection timed out");
      return null;
    } catch (e) {
      Utility.showMessage("Alert!", e.toString());
      return null;
    }
  }
}
