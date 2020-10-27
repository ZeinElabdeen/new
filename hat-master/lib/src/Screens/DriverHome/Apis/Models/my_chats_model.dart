import 'dart:convert';

import 'package:haat/src/Screens/DriverHome/Apis/Models/AppModels/base_model.dart';

// import 'AppModels/base_model.dart';


MyChatsModel myChatsModelFromJson(String str) =>
    MyChatsModel.fromJson(json.decode(str));

String myChatsModelToJson(MyChatsModel data) => json.encode(data.toJson());

class MyChatsModel extends BaseModel {
  MyChatsModel({
    this.code,
    this.data,
  });

  int code;
  List<Chat> data;

  factory MyChatsModel.fromJson(Map<String, dynamic> json) => MyChatsModel(
        code: json["code"] == null ? null : json["code"],
        data: json["data"] == null
            ? null
            : List<Chat>.from(json["data"].map((x) => Chat.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
      };

  @override
  BaseModel fromJson(Map<String, dynamic> json) {
    return MyChatsModel.fromJson(json);
  }
}

class Chat {
  Chat({
    this.id,
    this.userId,
    this.user,
    this.phone,
    this.secondUserId,
    this.secondUser,
    this.message,
    this.photo,
    this.orderId,
    this.lastMessage,
    this.lastMessageDate,
    this.createdAt,
  });

  int id;
  int userId;
  String user;
  int secondUserId;
  String secondUser;
  String photo;
  String phone;
  String message;
  int orderId;
  String lastMessage;
  DateTime lastMessageDate;
  DateTime createdAt;

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        user: json["user"] == null ? null : json["user"],
        phone: json["phone"] == null ? null : json["phone"],
        secondUserId:
            json["second_user_id"] == null ? null : json["second_user_id"],
        secondUser: json["second_user"] == null ? null : json["second_user"],
        message: json["message"] == null ? null : json["message"],
        photo: json["photo"] == null ? null : json["photo"],
        orderId: json["order_id"] == null ? null : json["order_id"],
        lastMessage: json["last_message"] == null ? null : json["last_message"],
        lastMessageDate: json["last_message_date"] == null
            ? null
            : DateTime.parse(json["last_message_date"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "user_id": userId == null ? null : userId,
        "user": user == null ? null : user,
        "second_user_id": secondUserId == null ? null : secondUserId,
        "second_user": secondUser == null ? null : secondUser,
        "message": message,
        "photo": photo == null ? null : photo,
        "order_id": orderId == null ? null : orderId,
        "last_message": lastMessage,
        "last_message_date":
            lastMessageDate == null ? null : lastMessageDate.toIso8601String(),
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
      };
}
