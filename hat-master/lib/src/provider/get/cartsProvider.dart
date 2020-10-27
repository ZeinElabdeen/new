import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:haat/src/Models/get/cartsModel.dart';
import 'package:haat/src/Repository/networkUtlisGenral.dart';

class CartsProvider with ChangeNotifier {
  List<Orders> _carts = [];

  List<Orders> get carts {
    return [..._carts];
  }

  NetworkUtil _utils = new NetworkUtil();
  CartsModel cartsModel;
  Future<CartsModel> getCarsType(String token) async {
    final List<Orders> loadedCountries = [];

    Map<String, String> headers = {
      "Authorization":"Bearer $token"
    };
    Response response = await _utils.get("get-cart", headers: headers);
    if (response.statusCode == 200) {
      print("get get-cart sucsseful");

      cartsModel = CartsModel.fromJson(response.data);
      cartsModel.data.forEach((e) {
        loadedCountries.add(Orders(
            id: e.id,
            createdAt: e.createdAt,
            orderDetails: e.orderDetails,
            orderLatitude: e.orderLatitude,
            orderLongitude: e.orderLongitude,
            photo: e.photo,
            placeName: e.placeName,
            providerId: e.providerId,
            providerName: e.providerName,
            providerPhoto: e.providerPhoto,
            state: e.state,
            userId: e.userId,
            userName: e.userName));
      });
      _carts = loadedCountries.reversed.toList();
      notifyListeners();
      return CartsModel.fromJson(response.data);
    } else {
      print("error get get-cart data");
      cartsModel = CartsModel.fromJson(response.data);

      _carts = loadedCountries.reversed.toList();
      notifyListeners();
      return CartsModel.fromJson(response.data);
    }
  }
}

class Orders {
  Orders({
    @required this.id,
    @required this.orderLatitude,
    @required this.orderLongitude,
    @required this.orderDetails,
    @required this.placeName,
    @required this.photo,
    @required this.state,
    @required this.userId,
    @required this.userName,
    @required this.providerId,
    @required this.providerName,
    @required this.providerPhoto,
    @required this.createdAt,
  });

  int id;
  String orderLatitude;
  String orderLongitude;
  String orderDetails;
  String placeName;
  String photo;
  int state;
  int userId;
  String userName;
  int providerId;
  String providerName;
  String providerPhoto;
  DateTime createdAt;
}
