import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:haat/src/MainWidgets/labeled_bottom_sheet.dart';
import 'package:haat/src/Models/get/NationalitiesModel.dart';
import 'package:haat/src/Repository/appLocalization.dart';
import 'package:haat/src/Repository/networkUtlisGenral.dart';

class NationalitiesProvider with ChangeNotifier {
  List<Nationality> _nationalities = [];

  List<Nationality> get nationalities {
    return [..._nationalities];
  }

  List<BottomSheetModel> _bottomSheet = [];

  List<BottomSheetModel> get bottomSheet {
    return [..._bottomSheet];
  }

  NetworkUtil _utils = new NetworkUtil();
  NationalitiesModel nationalityModel;
  Future<NationalitiesModel> getNationalities() async {
    final List<Nationality> loaded = [];
    final List<BottomSheetModel> loadedSheetModel = [];

    Map<String, String> headers = {
      "X-localization": localization.currentLanguage.toString()
    };
    Response response = await _utils.get("nationalities", headers: headers);
    if (response.statusCode == 200) {
      print("get nationalities sucsseful");

      nationalityModel = NationalitiesModel.fromJson(response.data);

      nationalityModel.data.forEach((e) {
        loadedSheetModel.add(BottomSheetModel(
            id: e.id, name: e.name, realID: e.nationalityId.toString()));
      });
      _bottomSheet = loadedSheetModel.reversed.toList();

      nationalityModel.data.forEach((e) {
        loaded.add(Nationality(
            createdAt: e.createdAt,
            id: e.id,
            name: e.name,
            nationalityId: e.nationalityId));
      });
      _nationalities = loaded.reversed.toList();
      notifyListeners();
      return NationalitiesModel.fromJson(response.data);
    } else {
      print("error get nationalities data");
      return NationalitiesModel.fromJson(response.data);
    }
  }
}

class Nationality {
  Nationality({
    @required this.id,
    @required this.nationalityId,
    @required this.name,
    @required this.createdAt,
  });

  int id;
  String nationalityId;
  String name;
  DateTime createdAt;
}
