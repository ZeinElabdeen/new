import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:haat/src/Helpers/sharedPref_helper.dart';
import 'package:haat/src/MainWidgets/custom_new_dialog.dart';
import 'package:haat/src/MainWidgets/custom_progress_dialog.dart';
import 'package:haat/src/Models/post/acceptModel.dart';
import 'package:haat/src/Repository/appLocalization.dart';
import 'package:haat/src/Repository/networkUtlisGenral.dart';
import 'package:haat/src/Screens/DriverHome/mainPageDriver.dart';
import 'package:haat/src/Screens/HomePages/main_page.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';

class SubscribeProvider with ChangeNotifier {
  NetworkUtil _utils = new NetworkUtil();
  CustomDialog dialog = CustomDialog();
  CustomProgressDialog customProgressDialog;
  ProgressDialog pr;
  AcceptModel subscribeModel;
  subscribe(
      String token, String price, File image, BuildContext context) async {
    customProgressDialog = CustomProgressDialog(context: context, pr: pr);
    customProgressDialog.showProgressDialog();
    customProgressDialog.showPr();
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };
    FormData formData = FormData.fromMap({
      "cash": price,
      "photo": image == null ? null : await MultipartFile.fromFile(image.path),
    });

    Response response = await _utils.post("charge-bank-transform",
        body: formData, headers: headers);
    if (response == null) {
      print('error pay');
      Future.delayed(Duration(seconds: 1), () {
        customProgressDialog.hidePr();
        dialog.showWarningDialog(
          btnOnPress: () {},
          context: context,
          msg: localization.text("internet"),
        );
      });
    }
    if (response.statusCode == 200) {
      print("pay data sucsseful");
      subscribeModel = AcceptModel.fromJson(response.data);
    } else {
      print("error  pay data");
      subscribeModel = AcceptModel.fromJson(response.data);
    }
    if (subscribeModel.code == 200) {
      Future.delayed(Duration(seconds: 1), () {
        customProgressDialog.hidePr();
        dialog.showSuccessDialog(
          btnOnPress: () {
            if (Provider.of<SharedPref>(context, listen: false).type == 1) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => MainPage(
                    index: 2,
                  ),
                ),
                (Route<dynamic> route) => false,
              );
            } else {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => MainPageDriver(
                    index: 2,
                  ),
                ),
                (Route<dynamic> route) => false,
              );
            }
          },
          context: context,
          msg: subscribeModel.data.value,
          btnMsg: localization.text("ok"),
        );
      });
    } else {
      Future.delayed(Duration(seconds: 1), () {
        customProgressDialog.hidePr();
      });
      print('error pay');
      dialog.showErrorDialog(
          btnOnPress: () {},
          context: context,
          msg: subscribeModel.error[0].value,
          ok: localization.text("ok"),
          code: subscribeModel.code);
    }
    notifyListeners();
  }
}
