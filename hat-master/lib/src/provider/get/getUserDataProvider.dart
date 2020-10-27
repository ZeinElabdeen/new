import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:haat/src/Repository/networkUtlisGenral.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:haat/src/Models/get/getUserDataModel.dart';

class GetUserDataProvider with ChangeNotifier {
  NetworkUtil _utils = new NetworkUtil();
  GetUserDataModel userDataModel;
  Future<GetUserDataModel> getUserData(String token) async {
    Map<String, String> headers = {"Authorization": "Bearer $token"};
    Response response = await _utils.get("user-data", headers: headers);
    if (response.statusCode == 200) {
      print("get user-data sucsseful");

      userDataModel = GetUserDataModel.fromJson(response.data);
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      print('done');
      _prefs.setInt('id', userDataModel.data[0].id);
      _prefs.setString('token', userDataModel.data[0].apiToken);
      _prefs.setString('name', userDataModel.data[0].name);
      _prefs.setInt('rate', userDataModel.data[0].rate);
      _prefs.setString('phone', userDataModel.data[0].phoneNumber);
      _prefs.setString('photo', userDataModel.data[0].photo);
      _prefs.setString('city', userDataModel.data[0].city);
      _prefs.setInt('cityId', userDataModel.data[0].cityId);
      _prefs.setInt('active', userDataModel.data[0].active);
      _prefs.setInt('type', userDataModel.data[0].type);

      notifyListeners();
      return GetUserDataModel.fromJson(response.data);
    } else {
      print("error get user-data data");
      return GetUserDataModel.fromJson(response.data);
    }
  }
}
