import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_medium/src/utils/utility.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LikesProvider extends GetConnect {
  Future<Response> likePost(String url) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token");
      final res = await http
          .post(Uri.parse(url), headers: {'Authorization': 'Bearer $token'});
      return Response(statusCode: res.statusCode, body: json.decode(res.body));
    } on SocketException {
      Get.back();
      Utility.showMessage(
          "No Internet Connection", "Please check your internet Connection");
      return null;
    } on TimeoutException {
      Get.back();
      //Utility.showMessage("Alert", "Connection timed out");
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<Response> unLikePost(String url) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token");
      final res = await http
          .delete(Uri.parse(url), headers: {'Authorization': 'Bearer $token'});
      return Response(statusCode: res.statusCode, body: json.decode(res.body));
    } on SocketException {
      Get.back();
      Utility.showMessage(
          "No Internet Connection", "Please check your internet Connection");
      return null;
    } on TimeoutException {
      Get.back();
      //Utility.showMessage("Alert", "Connection timed out");
      return null;
    } catch (e) {
      return null;
    }
  }
}
