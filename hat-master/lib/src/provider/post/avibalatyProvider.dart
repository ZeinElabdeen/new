import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:haat/src/MainWidgets/custom_new_dialog.dart';
import 'package:haat/src/Models/post/avalableModel.dart';
import 'package:haat/src/Repository/appLocalization.dart';
import 'package:haat/src/Repository/networkUtlisGenral.dart';

class AvailabilityProvider with ChangeNotifier {
  NetworkUtil _utils = new NetworkUtil();
  AvailableModel avalableModel;
  CustomDialog dialog = CustomDialog();

  changeAvailable(
      {String token,
      int available,
      double lat,
      double long,
      BuildContext context}) async {
    FormData formData = FormData.fromMap({
      "availability": available,
      "latitude": lat,
      "longitude": long,
    });
    Map<String, String> headers = {"Authorization": "Bearer $token"};
    Response response = await _utils
        .post("availability", body: formData, headers: headers)
        .catchError((e) {
      throw e;
    });
    if (response == null) {
      print('error rate');
      dialog.showWarningDialog(
        btnOnPress: () {},
        context: context,
        msg: localization.text("internet"),
      );
    }
    if (response.statusCode == 200) {
      print("get availability sucsseful");
      avalableModel = AvailableModel.fromJson(response.data);
    } else {
      print("error get availability data");
      avalableModel = AvailableModel.fromJson(response.data);
    }
    if (avalableModel.code == 200) {
      return true;
    } else {
      print('error confirmed');
      Fluttertoast.showToast(
          msg: localization.text("error"),
          toastLength: Toast.LENGTH_LONG,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
    }
  }
}
