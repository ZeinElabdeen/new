import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:haat/src/Repository/networkUtlisGenral.dart';
import 'package:haat/src/Screens/DriverHome/mainPageDriver.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:haat/src/MainWidgets/custom_new_dialog.dart';
import 'package:haat/src/MainWidgets/custom_progress_dialog.dart';
import 'package:haat/src/Models/auth/signUpModel.dart';
import 'package:haat/src/Repository/appLocalization.dart';

class SignUpProvider with ChangeNotifier {
  String phone;
  String email;
  String name;
  String password;
  String passwordConfirmation;
  String cityId;
  String carTypeId;
  String identityTypeId;
  String nationalityId;
  String regionId;
  String idNumber;
  String job;
  String deliveryType;
  String bank;
  String bankAccount;
  File photo;
  File identity;
  File license;
  File carForm;
  File transportationCard;
  File insurance;
  String barithDay;

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
      "type": "2",
      "phone_number": phone,
      "name": name,
      "email": email,
      "photo": photo == null ? null : await MultipartFile.fromFile(photo.path),
      "password": password,
      "password_confirmation": passwordConfirmation,
      "device_token": token,
      "city_id": cityId,
      "carType_id": carTypeId,
      "identityType_id": identityTypeId,
      "nationality_id": nationalityId,
      "idNumber": idNumber,
      "job": job,
      "delivery_type": deliveryType,
      "bank_name": bank,
      "bank_account": bankAccount,
      "birth_date": barithDay,
      "region_id": regionId,
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
      print("${_model.data[0].name}...................");
      print("${_model.data[0].apiToken}...................");
      print("${_model.data[0].id}...................");
      print("${_model.data[0].active}...................");
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
      _prefs.setString('idNumber', _model.data[0].idNumber);
      _prefs.setString('nationality', _model.data[0].nationality);
      _prefs.setString('jop', _model.data[0].job);
      //----------------------car Data-------------------//
      _prefs.setString('identity', _model.data[0].identity);
      _prefs.setString('license', _model.data[0].license);
      _prefs.setString('carForm', _model.data[0].carForm);
      _prefs.setString('transportationCard', _model.data[0].transportationCard);
      _prefs.setString('insurance', _model.data[0].insurance);
      _prefs.setString('barthDay', _model.data[0].birthDate.toString());
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => MainPageDriver(),
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
