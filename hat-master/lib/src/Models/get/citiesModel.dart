// To parse this JSON data, do
//
//     final citiesModel = citiesModelFromJson(jsonString);

import 'dart:convert';
import '../customError.dart';

CitiesModel citiesModelFromJson(String str) =>
    CitiesModel.fromJson(json.decode(str));

String citiesModelToJson(CitiesModel data) => json.encode(data.toJson());

class CitiesModel {
  CitiesModel({
    this.mainCode,
    this.code,
    this.data,
    this.error,
  });

  int mainCode;
  int code;
  List<Cities> data;
  List<Error> error;

  factory CitiesModel.fromJson(Map<String, dynamic> json) => CitiesModel(
        mainCode: json["mainCode"] == null ? null : json["mainCode"],
        code: json["code"] == null ? null : json["code"],
        data: json["data"] == null
            ? null
            : List<Cities>.from(json["data"].map((x) => Cities.fromJson(x))),
        error: json["error"] == null
            ? null
            : List<Error>.from(json["error"].map((x) => Error.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "mainCode": mainCode == null ? null : mainCode,
        "code": code == null ? null : code,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
        "error": error == null
            ? null
            : List<dynamic>.from(error.map((x) => x.toJson())),
      };
}

class Cities {
  Cities({
    this.id,
    this.name,
    this.countryId,
    this.country,
    this.createdAt,
  });

  int id;
  String name;
  int countryId;
  String country;
  DateTime createdAt;

  factory Cities.fromJson(Map<String, dynamic> json) => Cities(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        countryId: json["region_id"] == null ? null : json["region_id"],
        country: json["region"] == null ? null : json["region"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "country_id": countryId == null ? null : countryId,
        "country": country == null ? null : country,
        "created_at": createdAt == null
            ? null
            : "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
      };
}

// class Error {
//   Error({
//     this.key,
//     this.value,
//   });

//   String key;
//   String value;

//   factory Error.fromJson(Map<String, dynamic> json) => Error(
//         key: json["key"] == null ? null : json["key"],
//         value: json["value"] == null ? null : json["value"],
//       );

//   Map<String, dynamic> toJson() => {
//         "key": key == null ? null : key,
//         "value": value == null ? null : value,
//       };
// }
