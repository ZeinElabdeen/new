// To parse this JSON data, do
//
//     final deleteNotificationModel = deleteNotificationModelFromJson(jsonString);

import 'dart:convert';

import 'base_model.dart';


DeleteNotificationModel deleteNotificationModelFromJson(String str) => DeleteNotificationModel.fromJson(json.decode(str));

String deleteNotificationModelToJson(DeleteNotificationModel data) => json.encode(data.toJson());

class DeleteNotificationModel extends BaseModel{
  int mainCode;
  int code;
  Data data;
  String error;

  DeleteNotificationModel({
    this.mainCode,
    this.code,
    this.data,
    this.error,
  });

  factory DeleteNotificationModel.fromJson(Map<String, dynamic> json) => DeleteNotificationModel(
    mainCode: json["mainCode"],
    code: json["code"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    error: json["error"],
  );

  Map<String, dynamic> toJson() => {
    "mainCode": mainCode,
    "code": code,
    "data": data,
    "error": error,
  };
}

class Data {
  String value;

  Data({
    this.value,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "value": value,
  };
}

