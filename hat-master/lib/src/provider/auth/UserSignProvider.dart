import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:haat/src/Repository/networkUtlisGenral.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:haat/src/MainWidgets/custom_new_dialog.dart';
import 'package:haat/src/MainWidgets/custom_progress_dialog.dart';
import 'package:haat/src/Models/auth/signUpModel.dart';
import 'package:haat/src/Repository/appLocalization.dart';
import 'package:haat/src/Screens/HomePages/main_page.dart';

class SignUpUserProvider with ChangeNotifier {
  String phone;
  String email;
  String name;
  String password;
  String passwordConfirmation;
  String cityId;
  NetworkUtil _utils = new NetworkUtil();
  CustomDialog dialog = CustomDialog();
  CustomProgressDialog customProgressDialog;
  ProgressDialog pr;
  SignUpModel _model;
  SharedPreferences _prefs;
  signUp(String token, BuildContext context) async {
    customProgressDialog = CustomProgressDialog(context: context, pr: pr);
    customProgressDialog.showProgressDialog();
    customProgressDialog.showPr();
    Map<String, String> headers = {
      "X-localization": localization.currentLanguage.toString(),
    };
    FormData formData = FormData.fromMap({
      "type": 1,
      "email": email,
      "phone_number": phone,
      "name": name,
      "city_id": cityId,
      "password": password,
      "password_confirmation": passwordConfirmation,
      "device_token": token,
    });

    Response response =
        await _utils.post("register", body: formData, headers: headers);
    if (response == null) {
      print('error register res == null');
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
      print("register sucsseful");
      _model = SignUpModel.fromJson(response.data);
    } else {
      print("error register");
      _model = SignUpModel.fromJson(response.data);
    }
    if (_model.code == 200) {
      Future.delayed(Duration(seconds: 1), () {
        customProgressDialog.hidePr();
      });
      _prefs = await SharedPreferences.getInstance();
      print('done');
     _prefs.setInt('id', _model.data[0].id);
        _prefs.setString('token', _model.data[0].apiToken);
        _prefs.setString('name', _model.data[0].name);
        _prefs.setString('email', _model.data[0].email);
        _prefs.setString('phone', _model.data[0].phoneNumber);
        _prefs.setString('photo', _model.data[0].photo);
        _prefs.setString('city', _model.data[0].city);
        _prefs.setInt('cityId', _model.data[0].cityId);
        _prefs.setInt('active', _model.data[0].active);
        _prefs.setInt('type', _model.data[0].type);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => MainPage(),
        ),
        (Route<dynamic> route) => false,
      );
      return _prefs;
    } else {
      print('error register');
      Future.delayed(Duration(seconds: 1), () {
        customProgressDialog.hidePr();
        dialog.showErrorDialog(
            btnOnPress: () {},
            context: context,
            msg: _model.error[0].value,
            ok: localization.text("ok"),
            code: _model.code);
      });
    }
    notifyListeners();
  }
}
