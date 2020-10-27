import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:haat/src/MainWidgets/customDialog.dart';
import 'package:haat/src/Models/get/settingModel.dart';
import 'package:haat/src/Repository/appLocalization.dart';
import 'package:haat/src/Repository/networkUtlisGenral.dart';

class SettingProvider with ChangeNotifier {
  NetworkUtil _utils = new NetworkUtil();
  SettingModel userDataModel;
  String photo;
  String splashMsg;
  String centerPhone;
  CustomDialog dialog;
  getUserData(BuildContext context) async {
    Map<String, String> headers = {};
    Response response = await _utils.get("settings", headers: headers);
    if (response == null) {
      print('error change_password');
      dialog.showWarningDialog(
        btnOnPress: () {},
        context: context,
        msg: localization.text("internet"),
      );
    }
    if (response.statusCode == 200) {
      print("get settings sucsseful");

      userDataModel = SettingModel.fromJson(response.data);
      photo = userDataModel.data.photo;
      splashMsg = userDataModel.data.welcomeText;
      centerPhone = userDataModel.data.phoneNumber;
      print(photo);
      print(splashMsg);
      print(centerPhone);
      print('done');

      notifyListeners();
      return true;
    } else {
      print("error get settings data");
      userDataModel = SettingModel.fromJson(response.data);
      notifyListeners();
      return true;
    }
  }
}
