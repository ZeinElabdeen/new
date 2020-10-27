// To parse this JSON data, do
//
//     final logOutModel = logOutModelFromJson(jsonString);

import 'dart:convert';

LogOutModel logOutModelFromJson(String str) => LogOutModel.fromJson(json.decode(str));

String logOutModelToJson(LogOutModel data) => json.encode(data.toJson());

class LogOutModel {
    LogOutModel({
        this.mainCode,
        this.code,
        this.data,
        this.error,
    });

    int mainCode;
    int code;
    String data;
    dynamic error;

    factory LogOutModel.fromJson(Map<String, dynamic> json) => LogOutModel(
        mainCode: json["mainCode"] == null ? null : json["mainCode"],
        code: json["code"] == null ? null : json["code"],
        data: json["data"] == null ? null : json["data"],
        error: json["error"],
    );

    Map<String, dynamic> toJson() => {
        "mainCode": mainCode == null ? null : mainCode,
        "code": code == null ? null : code,
        "data": data == null ? null : data,
        "error": error,
    };
}
