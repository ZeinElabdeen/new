import 'dart:convert';

import 'AppModels/base_model.dart';

TermsModel termsModelFromJson(String str) =>
    TermsModel.fromJson(json.decode(str));

String termsModelToJson(TermsModel data) => json.encode(data.toJson());

class TermsModel extends BaseModel {
  int code;
  Terms data;

  TermsModel({
    this.code,
    this.data,
  });

  factory TermsModel.fromJson(Map<String, dynamic> json) => TermsModel(
        code: json["code"],
        data: json["data"] == null ? null : Terms.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "data": data.toJson(),
      };

  @override
  BaseModel fromJson(Map<String, dynamic> json) {
    return TermsModel.fromJson(json);
  }
}

class Terms {
  String title;
  String content;

  Terms({
    this.title,
    this.content,
  });

  factory Terms.fromJson(Map<String, dynamic> json) => Terms(
        title: json["title"],
        content: json["content"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "content": content,
      };
}
