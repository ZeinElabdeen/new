import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:haat/src/MainWidgets/customDialog.dart';
import 'package:haat/src/MainWidgets/custom_progress_dialog.dart';
import 'package:haat/src/Models/post/carDataModel.dart';
import 'package:haat/src/Repository/appLocalization.dart';
import 'package:haat/src/Repository/networkUtlisGenral.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditCarDataProvider with ChangeNotifier {
  File identity;
  File license;
  File carForm;
  File transportationCard;
  File insurance;
  NetworkUtil _utils = new NetworkUtil();
  CustomDialog dialog = CustomDialog();

  CustomProgressDialog customProgressDialog;
  ProgressDialog pr;
  CarDataModel model;
  SharedPreferences _prefs;
  changeCarData(String token, BuildContext context) async {
    customProgressDialog = CustomProgressDialog(context: context, pr: pr);
    customProgressDialog.showProgressDialog();

    customProgressDialog.showPr();

    Map<String, String> headers = {"Authorization": "Bearer $token"};
    FormData formData = FormData.fromMap({
      "identity":
          identity == null ? null : await MultipartFile.fromFile(identity.path),
      "license":
          license == null ? null : await MultipartFile.fromFile(license.path),
      "car_form":
          carForm == null ? null : await MultipartFile.fromFile(carForm.path),
      "transportation_card": transportationCard == null
          ? null
          : await MultipartFile.fromFile(transportationCard.path),
      "insurance": insurance == null
          ? null
          : await MultipartFile.fromFile(insurance.path),
    });

    Response response =
        await _utils.post("edit-car-data", body: formData, headers: headers);
    if (response == null) {
      print('error change_password');
      Future.delayed(Duration(seconds: 1), () {
        customProgressDialog.hidePr();
        dialog.showWarningDialog(
          btnOnPress: () {},
          context: context,
          msg: localization.text("internet"),
        );
      });

      return;
    }
    if (response.statusCode == 200) {
      print("car data sucsseful");
      model = CarDataModel.fromJson(response.data);

      notifyListeners();
    } else {
      print("error  car data");

      model = CarDataModel.fromJson(response.data);
    }
    if (model.code == 200) {
      _prefs = await SharedPreferences.getInstance();
      _prefs.setInt('active', 0);
      Future.delayed(Duration(seconds: 1), () {
        customProgressDialog.hidePr();
      });
     return true;
    } else {
      print("error  car data");
      Future.delayed(Duration(seconds: 1), () {
        customProgressDialog.hidePr();
        dialog.showWarningDialog(
          btnOnPress: () {},
          context: context,
          msg: model.error[0].value,
          // ok: localization.text("ok"),
        );
      });
    }
    notifyListeners();
  }
}
