import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:haat/src/Repository/networkUtlisGenral.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:haat/src/MainWidgets/custom_new_dialog.dart';
import 'package:haat/src/MainWidgets/custom_progress_dialog.dart';
import 'package:haat/src/Models/changeData/editAccountModel.dart';
import 'package:haat/src/Repository/appLocalization.dart';
import 'package:haat/src/Screens/HomePages/main_page.dart';

class EditUserDataProvider with ChangeNotifier {
  String name;
  String email;
  File image;

  NetworkUtil _utils = new NetworkUtil();
  CustomDialog dialog = CustomDialog();

  CustomProgressDialog customProgressDialog;
  ProgressDialog pr;
  EditAccountModel _model;
  SharedPreferences _prefs;
  changeUserData(String token, BuildContext context) async {
    customProgressDialog = CustomProgressDialog(context: context, pr: pr);
    customProgressDialog.showProgressDialog();
    customProgressDialog.showPr();
    Map<String, String> headers = {"Authorization": "Bearer $token"};
    FormData formData = FormData.fromMap({
      "name": name,
      "email": email,
      "photo": image == null ? null : await MultipartFile.fromFile(image.path),
    });

    Response response =
        await _utils.post("edit-client", body: formData, headers: headers);
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
      _model = EditAccountModel.fromJson(response.data);
    } else {
      print("error  edit_account data");

      _model = EditAccountModel.fromJson(response.data);
    }
    if (_model.code == 200) {
      _prefs = await SharedPreferences.getInstance();
      _prefs.setString("name", _model.data.name);
      _prefs.setString("photo", _model.data.photo);
      _prefs.setString("email", _model.data.email);
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
            builder: (context) => MainPage(
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
