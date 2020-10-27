import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:haat/src/Models/aboutUsModel.dart';
import 'package:haat/src/Repository/networkUtlisGenral.dart';

class AboutUsProvider with ChangeNotifier {
  String content;
  NetworkUtil _utils = new NetworkUtil();
  AboutUsModel aboutUsModel;
  Future<AboutUsModel> getAboutUs() async {
    Map<String, String> headers = {};
    Response response = await _utils.get("about-us", headers: headers);
    if (response.statusCode == 200) {
      print("get about_us sucsseful");

      aboutUsModel = AboutUsModel.fromJson(response.data);
      content = aboutUsModel.data.content;
      notifyListeners();
      return AboutUsModel.fromJson(response.data);
    } else {
      print("error get about_us data");
      return AboutUsModel.fromJson(response.data);
    }
  }
}
