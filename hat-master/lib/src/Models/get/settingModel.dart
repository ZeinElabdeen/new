// To parse this JSON data, do
//
//     final settingModel = settingModelFromJson(jsonString);

import 'dart:convert';

SettingModel settingModelFromJson(String str) => SettingModel.fromJson(json.decode(str));

String settingModelToJson(SettingModel data) => json.encode(data.toJson());

class SettingModel {
    SettingModel({
        this.mainCode,
        this.code,
        this.data,
        this.error,
    });

    int mainCode;
    int code;
    Data data;
    List<Error> error;

    factory SettingModel.fromJson(Map<String, dynamic> json) => SettingModel(
        mainCode: json["mainCode"] == null ? null : json["mainCode"],
        code: json["code"] == null ? null : json["code"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        error: json["error"] == null ? null : List<Error>.from(json["error"].map((x) => Error.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "mainCode": mainCode == null ? null : mainCode,
        "code": code == null ? null : code,
        "data": data == null ? null : data.toJson(),
        "error": error == null ? null : List<dynamic>.from(error.map((x) => x.toJson())),
    };
}

class Data {
    Data({
        this.phoneNumber,
        this.welcomeText,
        this.orderDuration,
        this.photo,
    });

    String phoneNumber;
    String welcomeText;
    int orderDuration;
    String photo;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
        welcomeText: json["welcome_text"] == null ? null : json["welcome_text"],
        orderDuration: json["order_duration"] == null ? null : json["order_duration"],
        photo: json["photo"] == null ? null : json["photo"],
    );

    Map<String, dynamic> toJson() => {
        "phone_number": phoneNumber == null ? null : phoneNumber,
        "welcome_text": welcomeText == null ? null : welcomeText,
        "order_duration": orderDuration == null ? null : orderDuration,
        "photo": photo == null ? null : photo,
    };
}

class Error {
    Error({
        this.key,
        this.value,
    });

    String key;
    String value;

    factory Error.fromJson(Map<String, dynamic> json) => Error(
        key: json["key"] == null ? null : json["key"],
        value: json["value"] == null ? null : json["value"],
    );

    Map<String, dynamic> toJson() => {
        "key": key == null ? null : key,
        "value": value == null ? null : value,
    };
}
