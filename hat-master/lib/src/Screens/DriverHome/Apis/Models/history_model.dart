import 'dart:convert';

import 'package:haat/src/Screens/DriverHome/Apis/Models/AppModels/base_model.dart';

// import 'AppModels/base_model.dart';

HistoryModel historyModelFromJson(String str) => HistoryModel.fromJson(json.decode(str));

String historyModelToJson(HistoryModel data) => json.encode(data.toJson());

class HistoryModel extends BaseModel{
  HistoryModel({
    this.code,
    this.data,
  });

  int code;
  List<History> data;

  factory HistoryModel.fromJson(Map<String, dynamic> json) => HistoryModel(
    code: json["code"] == null ? null : json["code"],
    data: json["data"] == null ? null : List<History>.from(json["data"].map((x) => History.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
  };

  @override
  BaseModel fromJson(Map<String, dynamic> json) {
    return HistoryModel.fromJson(json);
  }
}

class History {
  History({
    this.id,
    this.userId,
    this.user,
    this.title,
    this.theAmount,
    this.createdAt,
  });

  int id;
  int userId;
  String user;
  String title;
  String theAmount;
  DateTime createdAt;

  factory History.fromJson(Map<String, dynamic> json) => History(
    id: json["id"] == null ? null : json["id"],
    userId: json["user_id"] == null ? null : json["user_id"],
    user: json["user"] == null ? null : json["user"],
    title: json["title"] == null ? null : json["title"],
    theAmount: json["the amount"] == null ? null : json["the amount"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "user_id": userId == null ? null : userId,
    "user": user == null ? null : user,
    "title": title == null ? null : title,
    "the amount": theAmount == null ? null : theAmount,
    "created_at": createdAt == null ? null : "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
  };
}
