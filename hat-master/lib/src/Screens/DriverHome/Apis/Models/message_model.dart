// To parse this JSON data, do
//
//     final messageModel = messageModelFromJson(jsonString);

import 'dart:convert';

MessageModel messageModelFromJson(String str) =>
    MessageModel.fromJson(json.decode(str));

String messageModelToJson(MessageModel data) => json.encode(data.toJson());

class MessageModel {
  String channel;
  Data data;

  MessageModel({
    this.channel,
    this.data,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        channel: json["channel"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "channel": channel,
        "data": data.toJson(),
      };
}

class Data {
  int uniqueId;
  int userId;
  String userName;
  int providerId;
  String userPhoto;
  String voice;
  String message;
  String price;
  String endAt;
  double latitude;
  double longitude;
  bool status;

  Data(
      {this.uniqueId,
      this.userId,
      this.userName,
      this.providerId,
      this.userPhoto,
      this.voice,
      this.message,
      this.price,
      this.endAt,
      this.latitude,
      this.longitude,
      this.status});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        uniqueId: json["unique_id"],
        userId: json["user_id"],
        userName: json["user_name"],
        providerId: json["provider_id"],
        userPhoto: json["user_photo"],
        voice: json["voice"],
        message: json["message"],
        price: json["price"],
        endAt: json["end_at"],
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "unique_id": uniqueId,
        "user_id": userId,
        "user_name": userName,
        "provider_id": providerId,
        "user_photo": userPhoto,
        "voice": voice,
        "message": message,
        "price": price,
        "end_at": endAt,
        "latitude": latitude,
        "longitude": longitude,
        "status": status
      };
}
