import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:haat/src/MainWidgets/custom_new_dialog.dart';
import 'package:haat/src/Models/auth/logOutModel.dart';
import 'package:haat/src/Repository/networkUtlisGenral.dart';

class LogOutProvider with ChangeNotifier {
  NetworkUtil _utils = new NetworkUtil();
  LogOutModel logOutModel;
  CustomDialog dialog = CustomDialog();

  logOut(String deviceToken,String token) async {
      Map<String, String> headers = {"Authorization": "Bearer $token"};

    FormData formData = FormData.fromMap({
      "device_token": deviceToken,
    });
    Response response =
        await _utils.post("logout", body: formData, headers: headers);

    if (response.statusCode == 200) {
      print("get device_token sucsseful");
      logOutModel = LogOutModel.fromJson(response.data);
    } else {
      print("error get device_token data");
      logOutModel = LogOutModel.fromJson(response.data);
    }
    if (logOutModel.code == 200) {
      return true;
    } else {
      print('error device_token');
    }
    notifyListeners();
  }
}
