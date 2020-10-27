import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:haat/src/Models/post/createPlaceModel.dart';
import 'package:haat/src/Repository/appLocalization.dart';
import 'package:haat/src/Repository/networkUtlisGenral.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:haat/src/MainWidgets/custom_new_dialog.dart';
import 'package:haat/src/MainWidgets/custom_progress_dialog.dart';

class CreatePlaceProvider with ChangeNotifier {
  String placeDetails;
  String placeName;
  String longitude;
  String latitude;

  NetworkUtil _utils = new NetworkUtil();
  CustomDialog dialog = CustomDialog();
  CustomProgressDialog customProgressDialog;
  ProgressDialog pr;

  CreatePlaceModel _model;
  setNull() {
    placeDetails = null;
    placeName = null;
    longitude = null;
    latitude = null;
    notifyListeners();
  }

  createPlace(String token, BuildContext context) async {
    customProgressDialog = CustomProgressDialog(context: context, pr: pr);
    customProgressDialog.showProgressDialog();
    customProgressDialog.showPr();
    Map<String, String> headers = {"Authorization": "Bearer $token"};
    FormData formData = FormData.fromMap({
      "place_name": placeName,
      "place_details": placeDetails,
      "longitude": longitude,
      "latitude": latitude,
    });

    Response response =
        await _utils.post("create-place", body: formData, headers: headers);
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
      print("create-place sucsseful");
      _model = CreatePlaceModel.fromJson(response.data);
    } else {
      print("error create-place");
      _model = CreatePlaceModel.fromJson(response.data);
    }
    if (_model.code == 200) {
      Future.delayed(Duration(seconds: 1), () {
        customProgressDialog.hidePr();
      });
      Fluttertoast.showToast(
          msg: "تم اضافة عنوان جديد",
          toastLength: Toast.LENGTH_LONG,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
      Future.delayed(Duration(seconds: 1), () {
        Navigator.pop(context);
      });

      setNull();
      notifyListeners();
      return true;
    } else {
      print('error create-order');
      _model = CreatePlaceModel.fromJson(response.data);
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
