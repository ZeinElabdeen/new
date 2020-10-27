import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:haat/src/Models/get/MyAddressModel.dart';
import 'package:haat/src/Repository/networkUtlisGenral.dart';

import '../../MainWidgets/labeled_bottom_sheet.dart';

class MyAddressProvider with ChangeNotifier {
  List<MyAddress> _address = [];

  List<MyAddress> get adress {
    return [..._address];
  }

  List<BottomSheetModel> _placesSheet = [];

  List<BottomSheetModel> get placesSheet {
    return [..._placesSheet];
  }

  NetworkUtil _utils = new NetworkUtil();
  MyAddressModel categoriesModel;
  Future<MyAddressModel> getPlaces(String token) async {
    final List<MyAddress> loadedCountries = [];
    final List<BottomSheetModel> loadedPlacesSheet = [];

    Map<String, String> headers = {"Authorization": "Bearer $token"};
    Response response = await _utils.get("get-places", headers: headers);
    if (response.statusCode == 200) {
      print("get get-places sucsseful");
      categoriesModel = MyAddressModel.fromJson(response.data);
      categoriesModel.data.forEach((e) {
        loadedPlacesSheet.add(BottomSheetModel(
            id: e.id,
            name: e.placeName,
            realID: e.id.toString(),
            lat: e.latitude,
            long: e.longitude));
      });
      _placesSheet = loadedPlacesSheet.reversed.toList();
      categoriesModel.data.forEach((e) {
        loadedCountries.add(MyAddress(
            createdAt: e.createdAt,
            id: e.id,
            latitude: e.latitude,
            longitude: e.longitude,
            placeDetails: e.placeDetails,
            placeName: e.placeName,
            userId: e.userId));
      });

      _address = loadedCountries.reversed.toList();
      notifyListeners();
      return MyAddressModel.fromJson(response.data);
    } else {
      print("error get-places data");
      categoriesModel = MyAddressModel.fromJson(response.data);
      _address = loadedCountries.reversed.toList();
      notifyListeners();
      return MyAddressModel.fromJson(response.data);
    }
  }
}

class MyAddress {
  MyAddress({
    @required this.id,
    @required this.userId,
    @required this.placeName,
    @required this.placeDetails,
    @required this.latitude,
    @required this.longitude,
    @required this.createdAt,
  });

  int id;
  int userId;
  String placeName;
  String placeDetails;
  String latitude;
  String longitude;
  DateTime createdAt;
}
