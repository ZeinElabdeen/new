// To parse this JSON data, do
//
//     final nationalitiesModel = nationalitiesModelFromJson(jsonString);

import 'dart:convert';
import '../customError.dart';

NationalitiesModel nationalitiesModelFromJson(String str) =>
    NationalitiesModel.fromJson(json.decode(str));

String nationalitiesModelToJson(NationalitiesModel data) =>
    json.encode(data.toJson());

class NationalitiesModel {
  NationalitiesModel({
    this.mainCode,
    this.code,
    this.data,
    this.error,
  });

  int mainCode;
  int code;
  List<Nationalities> data;
  List<Error> error;

  factory NationalitiesModel.fromJson(Map<String, dynamic> json) =>
      NationalitiesModel(
        mainCode: json["mainCode"] == null ? null : json["mainCode"],
        code: json["code"] == null ? null : json["code"],
        data: json["data"] == null
            ? null
            : List<Nationalities>.from(
                json["data"].map((x) => Nationalities.fromJson(x))),
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

class Nationalities {
  Nationalities({
    this.id,
    this.nationalityId,
    this.name,
    this.createdAt,
  });

  int id;
  String nationalityId;
  String name;
  DateTime createdAt;

  factory Nationalities.fromJson(Map<String, dynamic> json) => Nationalities(
        id: json["id"] == null ? null : json["id"],
        nationalityId:
            json["nationality_id"] == null ? null : json["nationality_id"],
        name: json["name"] == null ? null : json["name"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "nationality_id": nationalityId == null ? null : nationalityId,
        "name": name == null ? null : name,
        "created_at": createdAt == null
            ? null
            : "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
      };
}
