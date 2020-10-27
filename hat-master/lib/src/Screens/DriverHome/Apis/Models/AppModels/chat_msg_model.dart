import 'dart:convert';

import 'msg_model.dart';

ChatMsgModel messageModelFromJson(String str) =>
    ChatMsgModel.fromJson(json.decode(str));

String messageModelToJson(ChatMsgModel data) => json.encode(data.toJson());

class ChatMsgModel {
  String channel;
  MsgModel data;

  ChatMsgModel({
    this.channel,
    this.data,
  });

  factory ChatMsgModel.fromJson(Map<String, dynamic> json) => ChatMsgModel(
        channel: json["channel"],
        data: MsgModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "channel": channel,
        "data": data.toJson(),
      };
}
