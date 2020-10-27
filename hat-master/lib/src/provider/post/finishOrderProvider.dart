import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:haat/src/MainWidgets/custom_alert.dart';
import 'package:haat/src/MainWidgets/custom_new_dialog.dart';
import 'package:haat/src/MainWidgets/custom_progress_dialog.dart';
import 'package:haat/src/Models/post/finishOrderModel.dart';
import 'package:haat/src/Repository/appLocalization.dart';
import 'package:haat/src/Repository/networkUtlisGenral.dart';
import 'package:haat/src/Screens/HomePages/Orders/internal/rating.dart';
import 'package:haat/src/Screens/HomePages/Settings/Internal/Wallet/online_payment.dart';
import 'package:progress_dialog/progress_dialog.dart';

class FinishOrderProvider with ChangeNotifier {
  NetworkUtil _utils = new NetworkUtil();
  FinishOrderModel finshOrderModel;
  CustomDialog dialog = CustomDialog();
  CustomProgressDialog customProgressDialog;
  ProgressDialog pr;

  finishOrder(
    int driverId,
    String token,
    int orderId,
    BuildContext context,
  ) async {
    customProgressDialog = CustomProgressDialog(context: context, pr: pr);
    customProgressDialog.showProgressDialog();
    customProgressDialog.showPr();
    Map<String, String> headers = {"Authorization": "Bearer $token"};
    FormData formData = FormData.fromMap({});
    Response response = await _utils.post("finish-order/$orderId",
        body: formData, headers: headers);
    if (response == null) {
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
      print("get finish-order sucsseful");
      finshOrderModel = FinishOrderModel.fromJson(response.data);
    } else {
      print("error get finish-order data");
      finshOrderModel = FinishOrderModel.fromJson(response.data);
    }
    if (finshOrderModel.code == 200) {
      Future.delayed(Duration(seconds: 1), () {
        customProgressDialog.hidePr();
        CustomAlert().toast(
            context: context, title: 'تم إنهاء الطلب من فضلك قم بتقييم السائق');
        if (finshOrderModel.data.paymentUrl == null)
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (_) => Rating(
                        orderID: orderId,
                        driverID: driverId,
                      )));
        else {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (_) => OnlinePaymentScreen(
                        url: finshOrderModel.data.paymentUrl,
                      )));
        }
      });

      return true;
    } else {
      print('error finish-order');
      Future.delayed(Duration(seconds: 1), () {
        customProgressDialog.hidePr();
        dialog.showErrorDialog(
          btnOnPress: () {},
          context: context,
          msg: finshOrderModel.error[0].value,
          ok: localization.text("ok"),
        );
      });
    }
    notifyListeners();
  }
}
