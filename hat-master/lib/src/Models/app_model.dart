// To parse this JSON data, do
//
//     final appModel = appModelFromJson(jsonString);

import 'dart:convert';

import 'base_model.dart';


AppModel appModelFromJson(String str) => AppModel.fromJson(json.decode(str));

String appModelToJson(AppModel data) => json.encode(data.toJson());

class AppModel extends BaseModel {
  int mainCode;
  int code;
  Data data;
  dynamic error;

  AppModel({
    this.mainCode,
    this.code,
    this.data,
    this.error,
  });

  factory AppModel.fromJson(Map<String, dynamic> json) => AppModel(
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
  int id;
  String email;
  String phone;
  String distance;
  String bankName;
  String bankNumber;
  int pinnedTime;
  String faceUrl;
  String twiterUrl;
  String youtubeUrl;
  dynamic linkedinUrl;
  dynamic createdAt;
  DateTime updatedAt;

  Data({
    this.id,
    this.email,
    this.phone,
    this.distance,
    this.bankName,
    this.bankNumber,
    this.pinnedTime,
    this.faceUrl,
    this.twiterUrl,
    this.youtubeUrl,
    this.linkedinUrl,
    this.createdAt,
    this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    email: json["email"],
    phone: json["phone"],
    distance: json["distance"],
    bankName: json["bank_name"],
    bankNumber: json["bank_number"],
    pinnedTime: json["pinned_time"],
    faceUrl: json["face_url"],
    twiterUrl: json["twiter_url"],
    youtubeUrl: json["youtube_url"],
    linkedinUrl: json["linkedin_url"],
    createdAt: json["created_at"],
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "phone": phone,
    "distance": distance,
    "bank_name": bankName,
    "bank_number": bankNumber,
    "pinned_time": pinnedTime,
    "face_url": faceUrl,
    "twiter_url": twiterUrl,
    "youtube_url": youtubeUrl,
    "linkedin_url": linkedinUrl,
    "created_at": createdAt,
    "updated_at": updatedAt.toIso8601String(),
  };
}

