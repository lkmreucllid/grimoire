import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:flutter_medium/src/utils/utility.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class TopFeedsProvider extends GetConnect {
  Future<Response> getTopFeeds(String url) async {
    try {
      final res = await http.get(Uri.parse(url));
      return Response(statusCode: res.statusCode, body: json.decode(res.body));
    } on SocketException {
      Get.back();
      Utility.showMessage(
          "No Internet Connection", "Please check your internet Connection");
      return null;
    } on TimeoutException {
      Get.back();
      Utility.showMessage("Alert", "Connection timed out");
      return null;
    } catch (e) {
      Utility.showMessage("Alert", e.toString());
      return null;
    }
  }
}
