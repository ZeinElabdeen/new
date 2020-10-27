import 'dart:convert';



import 'AppModels/base_model.dart';

ChangeDataModel changeDataModelFromJson(String str) =>
    ChangeDataModel.fromJson(json.decode(str));

String changeDataModelToJson(ChangeDataModel data) =>
    json.encode(data.toJson());

class ChangeDataModel extends BaseModel {
  ChangeDataModel({
    this.code,
    this.data,
  });

  int code;
  DataChanged data;

  factory ChangeDataModel.fromJson(Map<String, dynamic> json) =>
      ChangeDataModel(
        code: json["code"] == null ? null : json["code"],
        data: json["data"] == null ? null : DataChanged.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "data": data == null ? null : data.toJson(),
      };

  @override
  BaseModel fromJson(Map<String, dynamic> json) {
    return ChangeDataModel.fromJson(json);
  }
}

class DataChanged {
  DataChanged({
    this.name,
    this.email,
    this.photo,
  });

  String name;
  dynamic email;
  String photo;

  factory DataChanged.fromJson(Map<String, dynamic> json) => DataChanged(
        name: json["name"] == null ? null : json["name"],
        email: json["email"],
        photo: json["photo"] == null ? null : json["photo"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "email": email,
        "photo": photo == null ? null : photo,
      };
}
