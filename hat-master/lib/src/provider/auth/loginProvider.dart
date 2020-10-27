import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:haat/src/Repository/networkUtlisGenral.dart';
import 'package:haat/src/Screens/DriverHome/mainPageDriver.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:haat/src/MainWidgets/custom_new_dialog.dart';
import 'package:haat/src/MainWidgets/custom_progress_dialog.dart';
import 'package:haat/src/Models/auth/LoginModel.dart';
import 'package:haat/src/Repository/appLocalization.dart';
import 'package:haat/src/Screens/HomePages/main_page.dart';

class LoginProvider with ChangeNotifier {
  String phone;
  String password;
  int type;

  NetworkUtil _utils = new NetworkUtil();
  CustomDialog dialog = CustomDialog();
  CustomProgressDialog customProgressDialog;
  ProgressDialog pr;
  LoginModel _model;
  SharedPreferences _prefs;
  login(
    String token,
    BuildContext context,
  ) async {
    customProgressDialog = CustomProgressDialog(context: context, pr: pr);
    customProgressDialog.showProgressDialog();
    customProgressDialog.showPr();

    Map<String, String> headers = {
      "X-localization": localization.currentLanguage.toString()
    };
    FormData formData = FormData.fromMap({
      "phone_number": phone,
      "password": password,
      "device_token": token,
    });

    Response response =
        await _utils.post("login", body: formData, headers: headers);
    if (response == null) {
      print('error login res == null');
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
      print("login sucsseful");
      _model = LoginModel.fromJson(response.data);
    } else {
      print("error login");
      Future.delayed(Duration(seconds: 1), () {
        customProgressDialog.hidePr();
      });
      _model = LoginModel.fromJson(response.data);
    }
    if (_model.code == 200) {
      Future.delayed(Duration(seconds: 1), () {
        customProgressDialog.hidePr();
      });
      _prefs = await SharedPreferences.getInstance();
      print('done');

      if (_model.data[0].type == 1) {
        _prefs.setInt('id', _model.data[0].id);
        _prefs.setString('token', _model.data[0].apiToken);
        _prefs.setString('name', _model.data[0].name);
        _prefs.setString('email', _model.data[0].email);
        _prefs.setString('phone', _model.data[0].phoneNumber);
        _prefs.setString('photo', _model.data[0].photo);
        _prefs.setString('city', _model.data[0].city);
        _prefs.setString('barthDay', _model.data[0].birthDate.toString());
        _prefs.setInt('cityId', _model.data[0].cityId);
        _prefs.setInt('active', _model.data[0].active);
        _prefs.setInt('type', _model.data[0].type);
        type = _model.data[0].type;
        notifyListeners();
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => MainPage(),
          ),
          (Route<dynamic> route) => false,
        );
        return _prefs;
      } else {
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
        _prefs.setInt('driverType', _model.data[0].deliveryType);
        _prefs.setInt('regionId', _model.data[0].regionId);
        _prefs.setInt('carTypeId', _model.data[0].carTypeId);
        _prefs.setString('carType', _model.data[0].carType);
        _prefs.setInt('identityTypeId', _model.data[0].identityTypeId);
        _prefs.setString('identityType', _model.data[0].identityType);
        _prefs.setInt('nationalityId', _model.data[0].nationalityId);
        _prefs.setString('idNumber', _model.data[0].idNumber.toString());
        _prefs.setString('nationality', _model.data[0].nationality);
        _prefs.setString('jop', _model.data[0].job);
        _prefs.setInt('rate', _model.data[0].rate);
        _prefs.setInt('charge', _model.data[0].charge);
        //----------------------car Data-------------------//
        _prefs.setString('identity', _model.data[0].identity);
        _prefs.setString('license', _model.data[0].license);
        _prefs.setString('carForm', _model.data[0].carForm);
        _prefs.setString(
            'transportationCard', _model.data[0].transportationCard);
        _prefs.setString('insurance', _model.data[0].insurance);
        type = _model.data[0].type;
        notifyListeners();
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => MainPageDriver(),
          ),
          (Route<dynamic> route) => false,
        );
      }
      return _prefs;
    } else {
      print('error login');

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
