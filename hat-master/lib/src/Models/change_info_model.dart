// To parse this JSON data, do
//
//     final changeInfoModel = changeInfoModelFromJson(jsonString);

import 'dart:convert';

import 'base_model.dart';


ChangeInfoModel changeInfoModelFromJson(String str) => ChangeInfoModel.fromJson(json.decode(str));

String changeInfoModelToJson(ChangeInfoModel data) => json.encode(data.toJson());

class ChangeInfoModel extends BaseModel {
  int mainCode;
  int code;
  Data data;
  dynamic error;

  ChangeInfoModel({
    this.mainCode,
    this.code,
    this.data,
    this.error,
  });

  factory ChangeInfoModel.fromJson(Map<String, dynamic> json) => ChangeInfoModel(
    mainCode: json["mainCode"],
    code: json["code"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    error: json["error"],
  );

  Map<String, dynamic> toJson() => {
    "mainCode": mainCode,
    "code": code,
    "data": data.toJson(),
    "error": error,
  };
}

class Data {
  String key;
  String message;
  String name;
  String email;
  String photo;

  Data({
    this.key,
    this.message,
    this.name,
    this.email,
    this.photo,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    key: json["key"],
    message: json["message"],
    name: json["name"],
    email: json["email"],
    photo: json["photo"],
  );

  Map<String, dynamic> toJson() => {
    "key": key,
    "message": message,
    "name": name,
    "email": email,
    "photo": photo,
  };
}


