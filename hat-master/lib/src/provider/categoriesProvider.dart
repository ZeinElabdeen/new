import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:haat/src/Models/countriesModel.dart';
import 'package:haat/src/Repository/appLocalization.dart';
import 'package:haat/src/Repository/networkUtlisGenral.dart';

class CategoriesProvider with ChangeNotifier {
  List<Categories> _categories = [];

  List<Categories> get categories {
    return [..._categories];
  }

  NetworkUtil _utils = new NetworkUtil();
  CountriesModel categoriesModel;
  Future<CountriesModel> getCategories() async {
    final List<Categories> loadedCountries = [];
    Map<String, String> headers = {
      "X-localization": localization.currentLanguage.toString()
    };
    Response response = await _utils.get("categories", headers: headers);
    if (response.statusCode == 200) {
      print("get categories sucsseful");

      categoriesModel = CountriesModel.fromJson(response.data);

      categoriesModel.data.forEach((element) {
        loadedCountries.add(Categories(
            dateTime: element.createdAt,
            id: element.id.toString(),
            name: element.name));
      });
      _categories = loadedCountries.reversed.toList();
      notifyListeners();
      return CountriesModel.fromJson(response.data);
    } else {
      print("error get categories data");
      return CountriesModel.fromJson(response.data);
    }
  }
}

class Categories {
  final String id;
  final String name;
  final DateTime dateTime;

  Categories({@required this.id, @required this.name, @required this.dateTime});
}
