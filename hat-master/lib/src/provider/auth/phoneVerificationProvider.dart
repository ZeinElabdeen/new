import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:haat/src/Repository/networkUtlisGenral.dart';
import 'package:haat/src/Screens/Registeration/userType.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:haat/src/MainWidgets/custom_new_dialog.dart';
import 'package:haat/src/MainWidgets/custom_progress_dialog.dart';
import 'package:haat/src/Models/auth/phoneVerificationModel.dart';
import 'package:haat/src/Repository/appLocalization.dart';
import 'package:haat/src/provider/auth/signUpProvider.dart';

import 'UserSignProvider.dart';

class PhoneVerificationProvider with ChangeNotifier {
  String countryCode;
  String phone;
  String code;

  NetworkUtil _utils = new NetworkUtil();
  CustomDialog dialog = CustomDialog();
  CustomProgressDialog customProgressDialog;
  ProgressDialog pr;
  PhoneVerificationModel _model;
  phoneVerification(BuildContext context) async {
    customProgressDialog = CustomProgressDialog(context: context, pr: pr);
    customProgressDialog.showProgressDialog();
    customProgressDialog.showPr();
    Map<String, String> headers = {
      "X-localization": localization.currentLanguage.toString()
    };
    FormData formData = FormData.fromMap({
      "phone_number": phone,
      "code": code,
    });

    Response response = await _utils.post(
        "phone-verification",
        body: formData,
        headers: headers);
    if (response == null) {
      Future.delayed(Duration(seconds: 1), () {
        customProgressDialog.hidePr();
        print('error phone_verification');
        dialog.showWarningDialog(
          btnOnPress: () {},
          context: context,
          msg: localization.text("internet"),
        );
      });

      return;
    }
    if (response.statusCode == 200) {
      print("phone_verification sucsseful");
      _model = PhoneVerificationModel.fromJson(response.data);
    } else {
      print("error phone_verification");
      Future.delayed(Duration(seconds: 1), () {
        customProgressDialog.hidePr();
      });
      _model = PhoneVerificationModel.fromJson(response.data);
    }
    if (_model.code == 200) {
      print('success phone_verification');
      Future.delayed(Duration(seconds: 1), () {
        customProgressDialog.hidePr();
      });
      Provider.of<SignUpProvider>(context, listen: false).phone = phone;
      Provider.of<SignUpUserProvider>(context, listen: false).phone = phone;

      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => UserType()));
    } else {
      print('error phone_verification');
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
