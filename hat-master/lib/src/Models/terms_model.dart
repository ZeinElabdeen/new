// To parse this JSON data, do
//
//     final termsModel = termsModelFromJson(jsonString);

import 'dart:convert';


import 'base_model.dart';

TermsModel termsModelFromJson(String str) => TermsModel.fromJson(json.decode(str));

String termsModelToJson(TermsModel data) => json.encode(data.toJson());

class TermsModel extends BaseModel {
  int mainCode;
  int code;
  Data data;

  TermsModel({
    this.mainCode,
    this.code,
    this.data,
  });

  factory TermsModel.fromJson(Map<String, dynamic> json) => TermsModel(
    mainCode: json["mainCode"],
    code: json["code"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "mainCode": mainCode,
    "code": code,
    "data": data.toJson(),
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
    title: json["title"],
    content: json["content"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "content": content,
  };
}
