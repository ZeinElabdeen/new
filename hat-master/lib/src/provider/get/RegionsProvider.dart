import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:haat/src/MainWidgets/labeled_bottom_sheet.dart';
import 'package:haat/src/Models/get/RegionsModel.dart';
import 'package:haat/src/Repository/appLocalization.dart';
import 'package:haat/src/Repository/networkUtlisGenral.dart';

class RegionsProvider with ChangeNotifier {
  List<Nationality> _regions = [];

  List<Nationality> get regions {
    return [..._regions];
  }

  List<BottomSheetModel> _bottomSheet = [];

  List<BottomSheetModel> get bottomSheet {
    return [..._bottomSheet];
  }

  NetworkUtil _utils = new NetworkUtil();
  RegionsModel regionModel;
  Future<RegionsModel> getRegions() async {
    final List<Nationality> loaded = [];
    final List<BottomSheetModel> loadedSheetModel = [];

    Map<String, String> headers = {
      "X-localization": localization.currentLanguage.toString()
    };
    Response response = await _utils.get("regions", headers: headers);
    if (response.statusCode == 200) {
      print("get regions sucsseful");

      regionModel = RegionsModel.fromJson(response.data);
      regionModel.data.forEach((e) {
        loadedSheetModel.add(
            BottomSheetModel(id: e.id, name: e.name, realID: e.id.toString()));
      });
      _bottomSheet = loadedSheetModel.reversed.toList();

      regionModel.data.forEach((e) {
        loaded.add(Nationality(
          createdAt: e.createdAt,
          id: e.id,
          name: e.name,
        ));
      });
      _regions = loaded.reversed.toList();
      notifyListeners();
      return RegionsModel.fromJson(response.data);
    } else {
      print("error get regions data");
      return RegionsModel.fromJson(response.data);
    }
  }
}

class Nationality {
  Nationality({
    @required this.id,
    @required this.name,
    @required this.createdAt,
  });

  int id;
  String name;
  DateTime createdAt;
}
