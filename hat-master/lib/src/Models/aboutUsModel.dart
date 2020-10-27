// To parse this JSON data, do
//
//     final aboutUsModel = aboutUsModelFromJson(jsonString);

import 'dart:convert';

AboutUsModel aboutUsModelFromJson(String str) => AboutUsModel.fromJson(json.decode(str));

String aboutUsModelToJson(AboutUsModel data) => json.encode(data.toJson());

class AboutUsModel {
    int mainCode;
    int code;
    Data data;
    dynamic error;

    AboutUsModel({
        this.mainCode,
        this.code,
        this.data,
        this.error,
    });

    factory AboutUsModel.fromJson(Map<String, dynamic> json) => AboutUsModel(
        mainCode: json["mainCode"] == null ? null : json["mainCode"],
        code: json["code"] == null ? null : json["code"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        error: json["error"],
    );

    Map<String, dynamic> toJson() => {
        "mainCode": mainCode == null ? null : mainCode,
        "code": code == null ? null : code,
        "data": data == null ? null : data.toJson(),
        "error": error,
    };
}

class Data {
    String title;
    String content;

    Data({
        this.title,
        this.content,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        title: json["title"] == null ? null : json["title"],
        content: json["content"] == null ? null : json["content"],
    );

    Map<String, dynamic> toJson() => {
        "title": title == null ? null : title,
        "content": content == null ? null : content,
    };
}
