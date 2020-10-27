import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:haat/src/Models/post/editCartOrderModel.dart';
import 'package:haat/src/Repository/appLocalization.dart';
import 'package:haat/src/Repository/networkUtlisGenral.dart';
import 'package:haat/src/Screens/HomePages/main_page.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:haat/src/MainWidgets/custom_new_dialog.dart';
import 'package:haat/src/MainWidgets/custom_progress_dialog.dart';

class EditCartOrderProvider with ChangeNotifier {
  String orderDetails;
  String placeName;
  String providerId;
  String longitude;
  String latitude;
  String orderLatitude;
  String orderLongitude;

  File photo;
  NetworkUtil _utils = new NetworkUtil();
  CustomDialog dialog = CustomDialog();
  CustomProgressDialog customProgressDialog;
  ProgressDialog pr;

  EditCartOrderModel _model;
  setNull() {
    orderDetails = null;
    photo = null;
    placeName = null;
    providerId = null;
    longitude = null;
    latitude = null;
    orderLatitude = null;
    orderLongitude = null;

    notifyListeners();
  }

  editCartOrder(String token, int id, BuildContext context) async {
    customProgressDialog = CustomProgressDialog(context: context, pr: pr);
    customProgressDialog.showProgressDialog();
    customProgressDialog.showPr();
    Map<String, String> headers = {"Authorization": "Bearer $token"};
    FormData formData = FormData.fromMap({
      "place_name": placeName,
      "order_details": orderDetails,
      "longitude": longitude,
      "latitude": latitude,
      "order_latitude": orderLatitude,
      "order_longitude": orderLongitude,
      "photo": photo == null ? null : await MultipartFile.fromFile(photo.path),
      "provider_id": providerId,
    });

    Response response = await _utils.post("edit/$id",
        body: formData, headers: headers);
    if (response == null) {
      print('error edit res == null');
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
      print("edit sucsseful");

      _model = EditCartOrderModel.fromJson(response.data);
    } else {
      print("error edit");
      _model = EditCartOrderModel.fromJson(response.data);
    }
    if (_model.code == 200) {
      Future.delayed(Duration(seconds: 1), () {
        customProgressDialog.hidePr();
      });

      Fluttertoast.showToast(
          msg: "تم تعديل طلبك",
          toastLength: Toast.LENGTH_LONG,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
      Future.delayed(Duration(seconds: 1), () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => MainPage(
                      index: 3,
                    )));
      });

      notifyListeners();
    } else {
      print('error create-order');
      _model = EditCartOrderModel.fromJson(response.data);
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
