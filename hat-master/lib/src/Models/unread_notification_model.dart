// To parse this JSON data, do
//
//     final unreadNotificationModel = unreadNotificationModelFromJson(jsonString);

import 'dart:convert';


import 'base_model.dart';

UnreadNotificationModel unreadNotificationModelFromJson(String str) => UnreadNotificationModel.fromJson(json.decode(str));

String unreadNotificationModelToJson(UnreadNotificationModel data) => json.encode(data.toJson());

class UnreadNotificationModel  extends BaseModel{
  int mainCode;
  int code;
  Data data;
  dynamic error;

  UnreadNotificationModel({
    this.mainCode,
    this.code,
    this.data,
    this.error,
  });

  factory UnreadNotificationModel.fromJson(Map<String, dynamic> json) => UnreadNotificationModel(
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
  int value;

  Data({
    this.key,
    this.value,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    key: json["key"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "key": key,
    "value": value,
  };
}

