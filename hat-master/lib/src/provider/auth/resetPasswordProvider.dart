import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:haat/src/Repository/networkUtlisGenral.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:haat/src/MainWidgets/custom_new_dialog.dart';
import 'package:haat/src/MainWidgets/custom_progress_dialog.dart';
import 'package:haat/src/Models/auth/resetPasswordModel.dart';
import 'package:haat/src/Repository/appLocalization.dart';
// import 'package:haat/src/Repository/networkUtlis.dart';
import 'package:haat/src/Screens/Registeration/sign_in_screen.dart';

class ResetPasswordProvider with ChangeNotifier {
  String phone;
  String password;
  String passwordConfirmation;

  NetworkUtil _utils = new NetworkUtil();
  CustomDialog dialog = CustomDialog();
  CustomProgressDialog customProgressDialog;
  ProgressDialog pr;
  ResetPasswordModel _model;
  resetPassword(BuildContext context) async {
    customProgressDialog = CustomProgressDialog(context: context, pr: pr);
    customProgressDialog.showProgressDialog();
    customProgressDialog.showPr();
    Map<String, String> headers = {};
    FormData formData = FormData.fromMap({
      "phone_number": phone,
      "password": password,
      "password_confirmation": passwordConfirmation,
    });

    Response response =
        await _utils.post("reset-password", body: formData, headers: headers);
    if (response == null) {
      print('error reset_password');
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
      print("reset_password sucsseful");
      _model = ResetPasswordModel.fromJson(response.data);
    } else {
      print("error reset_password");
      _model = ResetPasswordModel.fromJson(response.data);
    }
    if (_model.code == 200) {
      Future.delayed(Duration(seconds: 1), () {
        customProgressDialog.hidePr();
        dialog.showSuccessDialog(
          btnOnPress: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => SignInScreen()));
          },
          context: context,
          msg: localization.text("password_changed"),
          btnMsg: localization.text("ok"),
        );
      });
    } else {
      print('error reset_password');
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
