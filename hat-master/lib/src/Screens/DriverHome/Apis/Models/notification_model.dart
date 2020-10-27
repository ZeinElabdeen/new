import 'dart:convert';

import 'package:haat/src/Screens/DriverHome/Apis/Models/AppModels/base_model.dart';

// import 'AppModels/base_model.dart';

NotificationModel notificationModelFromJson(String str) =>
    NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) =>
    json.encode(data.toJson());

class NotificationModel extends BaseModel{
  int code;
  List<Notification> data;

  NotificationModel({
    this.code,
    this.data,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        code: json["code"] == null ? null : json["code"],
        data: json["data"] == null
            ? null
            : List<Notification>.from(
                json["data"].map((x) => Notification.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
      };

  @override
  BaseModel fromJson(Map<String, dynamic> json) {
    return NotificationModel.fromJson(json);
  }
}

class Notification {
  int id;
  String title;
  String message;
  DateTime createdAt;

  Notification({
    this.id,
    this.title,
    this.message,
    this.createdAt,
  });

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        id: json["id"] == null ? null : json["id"],
        title: json["title"] == null ? null : json["title"],
        message: json["message"] == null ? null : json["message"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "title": title == null ? null : title,
        "message": message == null ? null : message,
        "created_at": createdAt == null
            ? null
            : "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
      };
}
