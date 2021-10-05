import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_medium/src/utils/utility.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SelCategoryListProvider extends GetConnect {
  Future<Response> getSelectedCategory(String url) async {
    try {
      final res = await http.get(Uri.parse(url));
      return Response(body: jsonDecode(res.body), statusCode: res.statusCode);
    } on SocketException {
      Get.back();
      Utility.showMessage(
          "No Internet Connection", 'Please check your internet connection');
      return null;
    } on TimeoutException {
      Get.back();
      Utility.showMessage("Alert", "Connetion timed out");
      return null;
    } catch (e) {
      Utility.showMessage("Alert", e.toString());
      return null;
    }
  }
}
