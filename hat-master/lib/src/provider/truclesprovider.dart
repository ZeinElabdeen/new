import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:haat/src/Models/countriesModel.dart';
import 'package:haat/src/Repository/appLocalization.dart';
import 'package:haat/src/Repository/networkUtlisGenral.dart';

class TruclesProvider with ChangeNotifier {
  List<Trucles> _trucles = [];

  List<Trucles> get trucles {
    return [..._trucles];
  }

  NetworkUtil _utils = new NetworkUtil();
  CountriesModel categoriesModel;
  Future<CountriesModel> getTrucles() async {
    final List<Trucles> loadedCountries = [];
    Map<String, String> headers = {
      "X-localization": localization.currentLanguage.toString()
    };
    Response response = await _utils.get("truckles", headers: headers);
    if (response.statusCode == 200) {
      print("get truckles sucsseful");

      categoriesModel = CountriesModel.fromJson(response.data);

      categoriesModel.data.forEach((element) {
        loadedCountries.add(Trucles(
            dateTime: element.createdAt,
            id: element.id.toString(),
            name: element.name));
      });
      _trucles = loadedCountries.reversed.toList();
      notifyListeners();
      return CountriesModel.fromJson(response.data);
    } else {
      print("error get truckles data");
      return CountriesModel.fromJson(response.data);
    }
  }
}

class Trucles {
  final String id;
  final String name;
  final DateTime dateTime;

  Trucles({@required this.id, @required this.name, @required this.dateTime});
}
