import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:haat/src/MainWidgets/labeled_bottom_sheet.dart';
import 'package:haat/src/Models/get/IdentityTypeModel.dart';
import 'package:haat/src/Repository/appLocalization.dart';
import 'package:haat/src/Repository/networkUtlisGenral.dart';

class IdentituTypeProvider with ChangeNotifier {
  List<Identity> _identities = [];

  List<Identity> get identities {
    return [..._identities];
  }

  List<BottomSheetModel> _bottomSheet = [];

  List<BottomSheetModel> get bottomSheet {
    return [..._bottomSheet];
  }

  NetworkUtil _utils = new NetworkUtil();
  IdentityTypeModel identityModel;
  Future<IdentityTypeModel> getIdentities() async {
    final List<BottomSheetModel> loadedSheetModel = [];

    final List<Identity> loaded = [];
    Map<String, String> headers = {
      "X-localization": localization.currentLanguage.toString()
    };
    Response response = await _utils.get("identity-types", headers: headers);
    if (response.statusCode == 200) {
      print("get identity-types sucsseful");

      identityModel = IdentityTypeModel.fromJson(response.data);
      identityModel.data.forEach((e) {
        loadedSheetModel.add(BottomSheetModel(
            id: e.id, name: e.name, realID: e.identityTypeId.toString()));
      });
       _bottomSheet = loadedSheetModel.reversed.toList();

      identityModel.data.forEach((e) {
        loaded.add(Identity(
            createdAt: e.createdAt,
            id: e.id,
            identityTypeId: e.identityTypeId,
            name: e.name));
      });
      _identities = loaded.reversed.toList();
      notifyListeners();
      return IdentityTypeModel.fromJson(response.data);
    } else {
      print("error get identity-types data");
      return IdentityTypeModel.fromJson(response.data);
    }
  }
}

class Identity {
  Identity({
    @required this.id,
    @required this.identityTypeId,
    @required this.name,
    @required this.createdAt,
  });

  int id;
  String identityTypeId;
  String name;
  DateTime createdAt;
}
