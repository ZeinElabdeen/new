import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:haat/src/Models/get/departmentsModel.dart';
import 'package:haat/src/Repository/appLocalization.dart';
import 'package:haat/src/Repository/networkUtlisGenral.dart';

class DepartMentProvider with ChangeNotifier {
  List<Departments> _departments = [];

  List<Departments> get departments {
    return [..._departments];
  }

  NetworkUtil _utils = new NetworkUtil();
  DepartmentsModel departMenstModel;
  Future<DepartmentsModel> getDepartements() async {
    final List<Departments> loaded = [];
    Map<String, String> headers = {
      "X-localization": localization.currentLanguage.toString()
    };
    Response response = await _utils.get("departments", headers: headers);
    if (response.statusCode == 200) {
      print("get departments sucsseful");

      departMenstModel = DepartmentsModel.fromJson(response.data);
      // loaded.add(Departments(
      //     createdAt: DateTime.now(), id: 0, name: "الكل", photo: ""));
      departMenstModel.data.forEach((e) {
        loaded.add(Departments(
            createdAt: e.createdAt, id: e.id, name: e.name, photo: e.photo,
            selected: false));
      });
      _departments = loaded.reversed.toList();
      notifyListeners();
      return DepartmentsModel.fromJson(response.data);
    } else {
      print("error get departments data");
      return DepartmentsModel.fromJson(response.data);
    }
  }
}

class Departments {
  Departments({
    @required this.id,
    @required this.name,
    @required this.photo,
    @required this.createdAt,
    @required this.selected,
  });

  int id;
  String name;
  String photo;
  DateTime createdAt;
  bool selected;
}
