import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:haat/src/Models/post/postCartModel.dart';
import 'package:haat/src/Repository/appLocalization.dart';
import 'package:haat/src/Repository/networkUtlisGenral.dart';
import 'package:haat/src/Screens/HomePages/main_page.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:haat/src/MainWidgets/custom_new_dialog.dart';
import 'package:haat/src/MainWidgets/custom_progress_dialog.dart';

class PostCartProvider with ChangeNotifier {
  String orderDetails;
  String code;
  String longitude;
  String latitude;
  String arrivalDetails;
  String paid;
  NetworkUtil _utils = new NetworkUtil();
  CustomDialog dialog = CustomDialog();
  CustomProgressDialog customProgressDialog;
  ProgressDialog pr;

  PostCartModel _model;
  setNull() {
    orderDetails = null;
    code = null;
    longitude = null;
    latitude = null;
    arrivalDetails = null;
    paid = null;
    notifyListeners();
  }

  postCart(String token, BuildContext context) async {
    customProgressDialog = CustomProgressDialog(context: context, pr: pr);
    customProgressDialog.showProgressDialog();
    customProgressDialog.showPr();
    Map<String, String> headers = {"Authorization": "Bearer $token"};
    FormData formData = FormData.fromMap({
      "order_details": orderDetails,
      "code": code,
      "longitude": longitude,
      "latitude": latitude,
      "address_details": arrivalDetails,
      "paid": paid,
    });

    Response response =
        await _utils.post("post-cart", body: formData, headers: headers);
    if (response == null) {
      print('error post-cart res == null');
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
      print("post-cart sucsseful");

      _model = PostCartModel.fromJson(response.data);
    } else {
      print("error post-cart");
      _model = PostCartModel.fromJson(response.data);
    }
    if (_model.code == 200) {
      Future.delayed(Duration(seconds: 1), () {
        customProgressDialog.hidePr();
      });
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
      print('error post-cart');
      _model = PostCartModel.fromJson(response.data);
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
