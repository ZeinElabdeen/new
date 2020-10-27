import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:haat/src/MainWidgets/custom_new_dialog.dart';
import 'package:haat/src/Models/post/deletPlaceModel.dart';
import 'package:haat/src/Repository/appLocalization.dart';
import 'package:haat/src/Repository/networkUtlisGenral.dart';

class DeletePlaceProvider with ChangeNotifier {
  NetworkUtil _utils = new NetworkUtil();
  DeletePlaceDataModel deletePlaceModel;
  CustomDialog dialog = CustomDialog();

  deletePlace(
    String token,
    String id,
    BuildContext context,
  ) async {
    Map<String, String> headers = {"Authorization": "Bearer $token"};

    Response response = await _utils.post("delete-place/$id", headers: headers);
    if (response == null) {
      print('error rate');
      dialog.showWarningDialog(
        btnOnPress: () {},
        context: context,
        msg: localization.text("internet"),
      );
    }
    if (response.statusCode == 200) {
      print("get delete-place sucsseful");
      deletePlaceModel = DeletePlaceDataModel.fromJson(response.data);
    } else {
      print("error get delete-place data");
      deletePlaceModel = DeletePlaceDataModel.fromJson(response.data);
    }
    if (deletePlaceModel.code == 200) {
      Fluttertoast.showToast(
          msg: "تم حذف المكان",
          toastLength: Toast.LENGTH_LONG,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
      return true;
    } else {
      print('error confirmed');
      Fluttertoast.showToast(
          msg: localization.text("error"),
          toastLength: Toast.LENGTH_LONG,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
    }
    notifyListeners();
  }
}
