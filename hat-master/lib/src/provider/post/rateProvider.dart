import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:haat/src/MainWidgets/custom_new_dialog.dart';
import 'package:haat/src/Models/post/rateModel.dart';
import 'package:haat/src/Repository/appLocalization.dart';
import 'package:haat/src/Repository/networkUtlisGenral.dart';

class RateProvider with ChangeNotifier {
  NetworkUtil _utils = new NetworkUtil();
  RateModel rateModel;
  CustomDialog dialog = CustomDialog();

  rate(
    int rating,
    String token,
    String id,
    BuildContext context,
  ) async {
    Map<String, String> headers = {
      "X-localization": localization.currentLanguage.toString(),
      "Authorization": "Bearer $token"
    };
    FormData formData = FormData.fromMap({
      "rating": rating,
    });
    Response response =
        await _utils.post("rate/$id", body: formData, headers: headers);
    if (response == null) {
      print('error rate');
      dialog.showWarningDialog(
        btnOnPress: () {},
        context: context,
        msg: localization.text("internet"),
      );
    }
    if (response.statusCode == 200) {
      print("get rate sucsseful");
      rateModel = RateModel.fromJson(response.data);
    } else {
      print("error get rate data");
      rateModel = RateModel.fromJson(response.data);
    }
    if (rateModel.code == 200) {
      Fluttertoast.showToast(
          msg: localization.text("success_rating"),
          toastLength: Toast.LENGTH_LONG,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
      return true;
    } else {
      print('error confirmed');
      Fluttertoast.showToast(
          msg: localization.text("error"),
          toastLength: Toast.LENGTH_LONG,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
    }
    notifyListeners();
  }
}
