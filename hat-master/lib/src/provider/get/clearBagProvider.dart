import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:haat/src/MainWidgets/custom_new_dialog.dart';
import 'package:haat/src/Models/get/ClearBagModel.dart';
import 'package:haat/src/Repository/appLocalization.dart';
import 'package:haat/src/Repository/networkUtlisGenral.dart';

class ClearBagProvider with ChangeNotifier {
  NetworkUtil _utils = new NetworkUtil();
  CleanBagModel clearBagModel;
  CustomDialog dialog = CustomDialog();

  clearBag(String token, BuildContext context) async {
    Map<String, String> headers = {"Authorization": "Bearer $token"};

    Response response = await _utils.get("delete-all", headers: headers);
    if (response == null) {
      print('error delete-all');
      dialog.showWarningDialog(
        btnOnPress: () {},
        context: context,
        msg: localization.text("internet"),
      );
    }
    if (response.statusCode == 200) {
      print("get delete-all sucsseful");
      clearBagModel = CleanBagModel.fromJson(response.data);
    } else {
      print("error get delete-all data");
      clearBagModel = CleanBagModel.fromJson(response.data);
    }
    if (clearBagModel.code == 200) {
      Fluttertoast.showToast(
          msg: "السلة فارغة",
          toastLength: Toast.LENGTH_LONG,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
          return true;
    } else {
      print('error confirmed');
      Fluttertoast.showToast(
          msg: clearBagModel.error[0].value,
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1,
          fontSize: 16.0,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.black,
          textColor: Colors.white
          
          );
    }
    notifyListeners();
  }
}
