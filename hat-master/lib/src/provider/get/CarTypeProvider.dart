import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:haat/src/MainWidgets/labeled_bottom_sheet.dart';
import 'package:haat/src/Models/get/CarTypeModel.dart';
import 'package:haat/src/Repository/appLocalization.dart';
import 'package:haat/src/Repository/networkUtlisGenral.dart';

class CarTypeProvider with ChangeNotifier {
  List<Cars> _cars = [];

  List<Cars> get cars {
    return [..._cars];
  }

  List<BottomSheetModel> _bottomSheet = [];

  List<BottomSheetModel> get bottomSheet {
    return [..._bottomSheet];
  }

  NetworkUtil _utils = new NetworkUtil();
  CarTypeModel carsModel;
  Future<CarTypeModel> getCarsType() async {
    final List<Cars> loadedCountries = [];
    final List<BottomSheetModel> loadedSheetModel = [];

    Map<String, String> headers = {
      "X-localization": localization.currentLanguage.toString()
    };
    Response response = await _utils.get("car-types", headers: headers);
    if (response.statusCode == 200) {
      print("get car-types sucsseful");

      carsModel = CarTypeModel.fromJson(response.data);
      carsModel.data.forEach((e) {
        loadedSheetModel.add(BottomSheetModel(
            id: e.id, name: e.name, realID: e.carTypeId.toString()));
      });
      carsModel.data.forEach((e) {
        loadedCountries.add(Cars(
            carId: e.carTypeId,
            createdAt: e.createdAt,
            id: e.id,
            name: e.name,
            selected: false));
      });
      _bottomSheet = loadedSheetModel.reversed.toList();
      _cars = loadedCountries.reversed.toList();
      notifyListeners();
      return CarTypeModel.fromJson(response.data);
    } else {
      print("error get car-types data");
      return CarTypeModel.fromJson(response.data);
    }
  }
}

class Cars {
  Cars(
      {@required this.id,
      @required this.name,
      @required this.carId,
      @required this.createdAt,
      @required this.selected});

  int id;
  String name;
  String carId;
  bool selected;
  DateTime createdAt;
}
