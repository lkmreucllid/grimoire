import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_medium/src/utils/utility.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class UserProvider extends GetConnect {
  Future<Response> postApi(
    Map data,
    String url,
  ) async {
    try {
      final res = await http.post(Uri.parse(url), body: data);
      return Response(statusCode: res.statusCode, body: json.decode(res.body));
    } on SocketException {
      Get.back();
      Utility.showMessage(
          "No Internet Connection!", "Please check your network connection");
      return null;
    } on TimeoutException {
      Get.back();
      Utility.showMessage("Alert!", "Connection timed out");
      return null;
    } catch (e) {
      Get.back();
      Utility.showMessage("Alert", e.toString());
      return null;
    }
  }
}
