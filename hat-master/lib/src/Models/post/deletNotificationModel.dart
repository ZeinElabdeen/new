// To parse this JSON data, do
//
//     final deleteNotificationModel = deleteNotificationModelFromJson(jsonString);

import 'dart:convert';

DeleteNotificationModel deleteNotificationModelFromJson(String str) => DeleteNotificationModel.fromJson(json.decode(str));

String deleteNotificationModelToJson(DeleteNotificationModel data) => json.encode(data.toJson());

class DeleteNotificationModel {
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
        mainCode: json["mainCode"] == null ? null : json["mainCode"],
        code: json["code"] == null ? null : json["code"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        error: json["error"] == null ? null : json["error"],
    );

    Map<String, dynamic> toJson() => {
        "mainCode": mainCode == null ? null : mainCode,
        "code": code == null ? null : code,
        "data": data == null ? null : data.toJson(),
        "error": error == null ? null : error,
    };
}

class Data {
    String value;

    Data({
        this.value,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        value: json["value"] == null ? null : json["value"],
    );

    Map<String, dynamic> toJson() => {
        "value": value == null ? null : value,
    };
}
