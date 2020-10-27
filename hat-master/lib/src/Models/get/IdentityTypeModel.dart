// To parse this JSON data, do
//
//     final identityTypeModel = identityTypeModelFromJson(jsonString);

import 'dart:convert';
import '../customError.dart';

IdentityTypeModel identityTypeModelFromJson(String str) =>
    IdentityTypeModel.fromJson(json.decode(str));

String identityTypeModelToJson(IdentityTypeModel data) =>
    json.encode(data.toJson());

class IdentityTypeModel {
  IdentityTypeModel({
    this.mainCode,
    this.data,
    this.error,
  });

  int mainCode;
  List<Datum> data;
  List<Error> error;

  factory IdentityTypeModel.fromJson(Map<String, dynamic> json) =>
      IdentityTypeModel(
        mainCode: json["mainCode"] == null ? null : json["mainCode"],
        data: json["data"] == null
            ? null
            : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        error: json["error"] == null
            ? null
            : List<Error>.from(json["error"].map((x) => Error.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "mainCode": mainCode == null ? null : mainCode,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
        "error": error == null
            ? null
            : List<dynamic>.from(error.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.id,
    this.identityTypeId,
    this.name,
    this.createdAt,
  });

  int id;
  String identityTypeId;
  String name;
  DateTime createdAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] == null ? null : json["id"],
        identityTypeId:
            json["identityType_id"] == null ? null : json["identityType_id"],
        name: json["name"] == null ? null : json["name"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "identityType_id": identityTypeId == null ? null : identityTypeId,
        "name": name == null ? null : name,
        "created_at": createdAt == null
            ? null
            : "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
      };
}
