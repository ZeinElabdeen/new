import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:haat/src/Models/changeData/changeDriverDataModel.dart';
import 'package:haat/src/Repository/networkUtlisGenral.dart';
import 'package:haat/src/Screens/DriverHome/mainPageDriver.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:haat/src/MainWidgets/custom_new_dialog.dart';
import 'package:haat/src/MainWidgets/custom_progress_dialog.dart';
import 'package:haat/src/Repository/appLocalization.dart';

class EditDriverDataProvider with ChangeNotifier {
  String name;
  String email;
  File image;
  String cityId;
  String carTypeId;
  String identityTypeId;
  String nationalityId;
  String regionId;
  String idNumber;
  String job;
  String barithDay;

  NetworkUtil _utils = new NetworkUtil();
  CustomDialog dialog = CustomDialog();

  CustomProgressDialog customProgressDialog;
  ProgressDialog pr;
  ChangeDriverDataModel _model;
  SharedPreferences _prefs;
  changeDriverData(String token, BuildContext context) async {
    customProgressDialog = CustomProgressDialog(context: context, pr: pr);
    customProgressDialog.showProgressDialog();
    customProgressDialog.showPr();
    Map<String, String> headers = {"Authorization": "Bearer $token"};
    FormData formData = FormData.fromMap({
      "name": name,
      "email": email,
      "city_id": cityId,
      "carType_id": carTypeId,
      "identityType_id": identityTypeId,
      "nationality_id": nationalityId,
      "idNumber": idNumber,
      "job": job,
      "birth_date": barithDay,
      "photo": image == null ? null : await MultipartFile.fromFile(image.path),
    });

    Response response =
        await _utils.post("edit-driver", body: formData, headers: headers);
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
      print("edit_account data sucsseful");
      _model = ChangeDriverDataModel.fromJson(response.data);
    } else {
      print("error  edit_account data");

      _model = ChangeDriverDataModel.fromJson(response.data);
    }
    if (_model.code == 200) {
      _prefs = await SharedPreferences.getInstance();
      _prefs.setString("name", _model.data[0].name);
      _prefs.setString("photo", _model.data[0].photo);
      _prefs.setString("email", _model.data[0].email);
      _prefs.setString('city', _model.data[0].city);
      _prefs.setInt('cityId', _model.data[0].cityId);
      _prefs.setInt('carTypeId', _model.data[0].carTypeId);
      _prefs.setString('carType', _model.data[0].carType);
      _prefs.setInt('identityTypeId', _model.data[0].identityTypeId);
      _prefs.setString('identityType', _model.data[0].identityType);
      _prefs.setInt('nationalityId', _model.data[0].nationalityId);
      _prefs.setInt('idNumber', _model.data[0].idNumber);
      _prefs.setString('nationality', _model.data[0].nationality);
      _prefs.setString('jop', _model.data[0].job);
      _prefs.setString('barthDay', _model.data[0].birthDate.toString());
      Future.delayed(Duration(seconds: 1), () {
        customProgressDialog.hidePr();
        Fluttertoast.showToast(
            msg: localization.text("edit_success"),
            toastLength: Toast.LENGTH_LONG,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => MainPageDriver(
              index: 1,
              key: GlobalKey(),
            ),
          ),
          (Route<dynamic> route) => false,
        );
      });
      return true;
    } else {
      print("error  edit_account data");
      Future.delayed(Duration(seconds: 1), () {
        customProgressDialog.hidePr();
        dialog.showErrorDialog(
          btnOnPress: () {},
          context: context,
          msg: _model.error[0].value,
          ok: localization.text("ok"),
        );
      });
    }
    notifyListeners();
  }
}
