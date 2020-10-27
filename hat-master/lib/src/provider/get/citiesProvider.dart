import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:haat/src/MainWidgets/labeled_bottom_sheet.dart';
import 'package:haat/src/Models/get/citiesModel.dart';
import 'package:haat/src/Repository/appLocalization.dart';
import 'package:haat/src/Repository/networkUtlisGenral.dart';

class CitiesProvider with ChangeNotifier {
  // String id = "4";
  List<Cities> _cities = [];

  List<Cities> get coties {
    return [..._cities];
  }

  List<BottomSheetModel> _citiesSheet = [];

  List<BottomSheetModel> get cotiesSheet {
    return [..._citiesSheet];
  }

  NetworkUtil _utils = new NetworkUtil();
  CitiesModel categoriesModel;
  Future<CitiesModel> getCities(String id) async {
    final List<Cities> loadedCountries = [];
    final List<BottomSheetModel> loadedCountriesSheet = [];
    Map<String, String> headers = {
      "X-localization": localization.currentLanguage.toString()
    };
    Response response = await _utils.get("get-cities/$id", headers: headers);
    if (response.statusCode == 200) {
      print("get get-cities sucsseful");

      categoriesModel = CitiesModel.fromJson(response.data);

      categoriesModel.data.forEach((e) {
        loadedCountriesSheet.add(BottomSheetModel(
            id: e.id, name: e.name, realID: e.countryId.toString()));
      });
      _citiesSheet = loadedCountriesSheet.reversed.toList();
      categoriesModel.data.forEach((e) {
        loadedCountries.add(Cities(
            country: e.country,
            countryId: e.countryId,
            createdAt: e.createdAt,
            id: e.id,
            name: e.name,
            selected: false));
      });

      _cities = loadedCountries.reversed.toList();
      notifyListeners();
      return CitiesModel.fromJson(response.data);
    } else {
      print("error get get-cities data");
      return CitiesModel.fromJson(response.data);
    }
  }
}

class Cities {
  Cities(
      {@required this.id,
      @required this.name,
      @required this.countryId,
      @required this.country,
      @required this.createdAt,
      @required this.selected});

  int id;
  String name;
  int countryId;
  String country;
  bool selected;
  DateTime createdAt;
}
