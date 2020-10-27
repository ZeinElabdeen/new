import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:haat/src/Models/get/restourantsModel.dart';
import 'package:haat/src/Repository/networkUtlisGenral.dart';

class RestourantsProvider with ChangeNotifier {
  List<Restourants> _restourants = [];

  List<Restourants> get restourants {
    return [..._restourants];
  }

  NetworkUtil _utils = new NetworkUtil();
  RestourantsModel restourant;
  Future<RestourantsModel> getRestourants(
      double lat, double long, int id, String search) async {
    final List<Restourants> loaded = [];
    Future.delayed(Duration(microseconds: 150), () {
      restourant = null;
      notifyListeners();
    });

    Map<String, String> headers = {};
    FormData formData = FormData.fromMap(
        {"longitude": lat, "latitude": long, "department_id": id});

    Response response =
        await _utils.post("providers", body: formData, headers: headers);

    if (response.statusCode == 200) {
      print("get departments sucsseful");

      restourant = RestourantsModel.fromJson(response.data);
      if (search != null)
        restourant.data.forEach((e) {
          if (e.name.contains(search)) {
            loaded.add(Restourants(
                id: e.id,
                name: e.name,
                photo: e.photo,
                department: e.department,
                departmentId: e.departmentId,
                distance: e.distance,
                latitude: e.latitude,
                longitude: e.longitude,
                photos: e.photos));
          }
        });
      else
        restourant.data.forEach((e) {
          loaded.add(Restourants(
              id: e.id,
              name: e.name,
              photo: e.photo,
              department: e.department,
              departmentId: e.departmentId,
              distance: e.distance,
              latitude: e.latitude,
              longitude: e.longitude,
              photos: e.photos));
        });
      _restourants = loaded.reversed.toList();
      notifyListeners();
      return RestourantsModel.fromJson(response.data);
    } else {
      restourant = RestourantsModel.fromJson(response.data);
      _restourants = loaded.reversed.toList();

      notifyListeners();

      print("error get departments data");
      return RestourantsModel.fromJson(response.data);
    }
  }
}

class Restourants {
  Restourants({
    @required this.id,
    @required this.name,
    @required this.longitude,
    @required this.latitude,
    @required this.departmentId,
    @required this.department,
    @required this.photo,
    @required this.photos,
    @required this.distance,
  });

  int id;
  String name;
  String longitude;
  String latitude;
  int departmentId;
  String department;
  String photo;
  List<Photo> photos;
  double distance;
}
