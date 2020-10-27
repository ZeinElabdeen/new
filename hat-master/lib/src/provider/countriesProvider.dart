import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:haat/src/Models/countriesModel.dart';
import 'package:haat/src/Repository/appLocalization.dart';
import 'package:haat/src/Repository/networkUtlisGenral.dart';

class CountriesProvider with ChangeNotifier {
  List<Countries> _countries = [];

  List<Countries> get getcountries {
    return [..._countries];
  }

  NetworkUtil _utils = new NetworkUtil();
  CountriesModel countries;
  Future<CountriesModel> getCountries() async {
    final List<Countries> loadedCountries = [];
    Map<String, String> headers = {
      "X-localization": localization.currentLanguage.toString()
    };
    Response response = await _utils.get("countries", headers: headers);
    if (response.statusCode == 200) {
      print("get countries sucsseful");

      countries = CountriesModel.fromJson(response.data);

      countries.data.forEach((element) {
        loadedCountries.add(Countries(
            dateTime: element.createdAt,
            id: element.id.toString(),
            name: element.name));
      });
      _countries = loadedCountries.reversed.toList();
      notifyListeners();
      return CountriesModel.fromJson(response.data);
    } else {
      print("error get countries data");
      return CountriesModel.fromJson(response.data);
    }
  }
}

class Countries {
  final String id;
  final String name;
  final DateTime dateTime;

  Countries({@required this.id, @required this.name, @required this.dateTime});
}
