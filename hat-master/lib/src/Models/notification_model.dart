// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

import 'base_model.dart';



NotificationModel notificationModelFromJson(String str) => NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) => json.encode(data.toJson());

class NotificationModel extends BaseModel {
  int mainCode;
  int code;
  List<Datum> data;
  String error;

  NotificationModel({
    this.mainCode,
    this.code,
    this.data,
    this.error,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
    mainCode: json["mainCode"],
    code: json["code"],
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    error: json["error"],
  );

  Map<String, dynamic> toJson() => {
    "mainCode": mainCode,
    "code": code,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "error": error,
  };
}

class Error {
  String key;
  String value;

  Error({
    this.key,
    this.value,
  });

  factory Error.fromJson(Map<String, dynamic> json) => Error(
    key: json["key"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "key": key,
    "value": value,
  };
}

class Datum {
  int id;
  int type;
  String title;
  String message;
  int userId;
  int read;
  DateTime createdAt;

  Datum({
    this.id,
    this.type,
    this.title,
    this.message,
    this.userId,
    this.read,
    this.createdAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    type: json["type"],
    title: json["title"],
    message: json["message"],
    userId: json["user_id"],
    read: json["read"],
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "title": title,
    "message": message,
    "user_id": userId,
    "read": read,
    "created_at": "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
  };
}





