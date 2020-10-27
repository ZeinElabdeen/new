import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:haat/src/Models/get/orderStateModel.dart';
import 'package:haat/src/Repository/networkUtlisGenral.dart';

class OrderStateProcider with ChangeNotifier {
  int orderState;
  NetworkUtil _utils = new NetworkUtil();
  OrderStateModel orderStateModel;
   getOrderState(String token, String id) async {
    Map<String, String> headers = {"Authorization": "Bearer $token"};
    Response response = await _utils.get("track/$id", headers: headers);
    if (response.statusCode == 200) {
      print("get track data sucsseful");

      orderStateModel = OrderStateModel.fromJson(response.data);
      orderState = orderStateModel.data.status;
      notifyListeners();
    } else {
      print("error get track data");
      orderStateModel = OrderStateModel.fromJson(response.data);
    }
  }
}
