// To parse this JSON data, do
//
//     final regionsModel = regionsModelFromJson(jsonString);

import 'dart:convert';
import '../customError.dart';

RegionsModel regionsModelFromJson(String str) =>
    RegionsModel.fromJson(json.decode(str));

String regionsModelToJson(RegionsModel data) => json.encode(data.toJson());

class RegionsModel {
  RegionsModel({
    this.mainCode,
    this.code,
    this.data,
    this.error,
  });

  int mainCode;
  int code;
  List<Regions> data;
  List<Error> error;

  factory RegionsModel.fromJson(Map<String, dynamic> json) => RegionsModel(
        mainCode: json["mainCode"] == null ? null : json["mainCode"],
        code: json["code"] == null ? null : json["code"],
        data: json["data"] == null
            ? null
            : List<Regions>.from(json["data"].map((x) => Regions.fromJson(x))),
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

class Regions {
  Regions({
    this.id,
    this.name,
    this.createdAt,
  });

  int id;
  String name;
  DateTime createdAt;

  factory Regions.fromJson(Map<String, dynamic> json) => Regions(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "created_at": createdAt == null
            ? null
            : "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
      };
}
