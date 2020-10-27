import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:haat/src/Models/post/createOrderModel.dart';
import 'package:haat/src/Repository/appLocalization.dart';
import 'package:haat/src/Repository/networkUtlisGenral.dart';
import 'package:haat/src/Screens/HomePages/main_page.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:haat/src/MainWidgets/custom_new_dialog.dart';
import 'package:haat/src/MainWidgets/custom_progress_dialog.dart';

class CreateOrderProvider with ChangeNotifier {
  String orderDetails;
  String placeName;
  String cart;
  String providerId;
  String code;
  String longitude;
  String latitude;
  String orderLatitude;
  String orderLongitude;
  String arrivalDetails;
  String paid;

  File photo;
  NetworkUtil _utils = new NetworkUtil();
  CustomDialog dialog = CustomDialog();
  CustomProgressDialog customProgressDialog;
  ProgressDialog pr;

  CreateOrderModel _model;
  setNull() {
    orderDetails = null;
    photo = null;
    placeName = null;
    cart = null;
    providerId = null;
    code = null;
    longitude = null;
    latitude = null;
    orderLatitude = null;
    orderLongitude = null;
    arrivalDetails = null;
    paid = null;

    notifyListeners();
  }

  createOrder(String token, int type, BuildContext context) async {
    customProgressDialog = CustomProgressDialog(context: context, pr: pr);
    customProgressDialog.showProgressDialog();
    customProgressDialog.showPr();
    Map<String, String> headers = {"Authorization": "Bearer $token"};
    FormData formData = FormData.fromMap({
      "place_name": placeName,
      "order_details": orderDetails,
      "code": code,
      "longitude": longitude,
      "latitude": latitude,
      "order_latitude": orderLatitude,
      "order_longitude": orderLongitude,
      "address_details": arrivalDetails,
      "photo": photo == null ? null : await MultipartFile.fromFile(photo.path),
      "cart": cart,
      "provider_id": providerId,
      "paid": paid
    });

    Response response = await _utils.post("create-order/$type",
        body: formData, headers: headers);
    if (response == null) {
      print('error create-order res == null');
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
      print("create-order sucsseful");

      _model = CreateOrderModel.fromJson(response.data);
    } else {
      print("error create-order");
      _model = CreateOrderModel.fromJson(response.data);
    }
    if (_model.code == 200) {
      Future.delayed(Duration(seconds: 1), () {
        customProgressDialog.hidePr();
      });
      if (cart == 1.toString()) {
        Fluttertoast.showToast(
            msg: "تم اضافة الطلب الي السلة",
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
      } else
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => MainPage(
              index: 2,
            ),
          ),
          (Route<dynamic> route) => false,
        );
      setNull();
      notifyListeners();
    } else {
      print('error create-order');
      _model = CreateOrderModel.fromJson(response.data);
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
