// To parse this JSON data, do
//
//     final registerMobileModel = registerMobileModelFromJson(jsonString);

import 'dart:convert';

RegisterMobileModel registerMobileModelFromJson(String str) =>
    RegisterMobileModel.fromJson(json.decode(str));

String registerMobileModelToJson(RegisterMobileModel data) =>
    json.encode(data.toJson());

class RegisterMobileModel {
  RegisterMobileModel({
    this.mainCode,
    this.code,
    this.data,
    this.error,
  });

  int mainCode;
  int code;
  String data;
  List<Error> error;

  factory RegisterMobileModel.fromJson(Map<String, dynamic> json) =>
      RegisterMobileModel(
        mainCode: json["mainCode"] == null ? null : json["mainCode"],
        code: json["code"] == null ? null : json["code"],
        data: json["data"] == null ? null : json["data"],
        error: json["error"] == null
            ? null
            : List<Error>.from(json["error"].map((x) => Error.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "mainCode": mainCode == null ? null : mainCode,
        "code": code == null ? null : code,
        "data": data == null ? null : data,
        "error": error == null
            ? null
            : List<dynamic>.from(error.map((x) => x.toJson())),
      };
}

class Error {
  Error({
    this.key,
    this.value,
  });

  String key;
  String value;

  factory Error.fromJson(Map<String, dynamic> json) => Error(
        key: json["key"] == null ? null : json["key"],
        value: json["value"] == null ? null : json["value"],
      );

  Map<String, dynamic> toJson() => {
        "key": key == null ? null : key,
        "value": value == null ? null : value,
      };
}
