import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:haat/src/Repository/networkUtlisGenral.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:haat/src/MainWidgets/custom_new_dialog.dart';
import 'package:haat/src/MainWidgets/custom_progress_dialog.dart';
import 'package:haat/src/Models/auth/phoneVerificationModel.dart';
import 'package:haat/src/Repository/appLocalization.dart';
// import 'package:haat/src/Repository/networkUtlis.dart';

class ChangePhoneCodeProvider with ChangeNotifier {
  String phone;
  String code;

  NetworkUtil _utils = new NetworkUtil();
  CustomDialog dialog = CustomDialog();
  CustomProgressDialog customProgressDialog;
  ProgressDialog pr;
  PhoneVerificationModel _model;
  SharedPreferences _prefs;
  changePhoneCode(String token, BuildContext context) async {
    customProgressDialog = CustomProgressDialog(context: context, pr: pr);
    customProgressDialog.showProgressDialog();
    customProgressDialog.showPr();
    Map<String, String> headers = {
      "X-localization": localization.currentLanguage.toString(),
      "Authorization": "Bearer $token"
    };
    FormData formData = FormData.fromMap({
      "phone_number": phone,
      "code": code,
    });

    Response response = await _utils.post("check-code-change-phone",
        body: formData, headers: headers);
    if (response == null) {
      Future.delayed(Duration(seconds: 1), () {
        customProgressDialog.hidePr();
        print('error check-code-change-phone');
        dialog.showWarningDialog(
          btnOnPress: () {},
          context: context,
          msg: localization.text("internet"),
        );
      });

      return;
    }
    if (response.statusCode == 200) {
      print("check-code-change-phone sucsseful");
      _model = PhoneVerificationModel.fromJson(response.data);
    } else {
      print("error check-code-change-phone");
      Future.delayed(Duration(seconds: 1), () {
        customProgressDialog.hidePr();
      });
      _model = PhoneVerificationModel.fromJson(response.data);
    }
    if (_model.code == 200) {
      _prefs = await SharedPreferences.getInstance();
      print('success check-code-change-phone');
      _prefs.setString("email", phone);

      Future.delayed(Duration(seconds: 1), () {
        customProgressDialog.hidePr();
        dialog.showSuccessDialog(
          btnOnPress: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
          context: context,
          msg: localization.text("phone_changed"),
          btnMsg: localization.text("ok"),
        );
      });
    } else {
      print('error check-code-change-phone');
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
