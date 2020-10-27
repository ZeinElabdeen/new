import 'dart:convert';

import 'package:haat/src/Screens/DriverHome/Apis/Models/AppModels/base_model.dart';

// import 'AppModels/base_model.dart';

PhotoModel photoModelFromJson(String str) => PhotoModel.fromJson(json.decode(str));

String photoModelToJson(PhotoModel data) => json.encode(data.toJson());

class PhotoModel extends BaseModel{
  PhotoModel({
    this.code,
    this.data,
  });

  int code;
  List<Photo> data;

  factory PhotoModel.fromJson(Map<String, dynamic> json) => PhotoModel(
    code: json["code"] == null ? null : json["code"],
    data: json["data"] == null ? null : List<Photo>.from(json["data"].map((x) => Photo.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
  };

  @override
  BaseModel fromJson(Map<String, dynamic> json) {
    return PhotoModel.fromJson(json);
  }
}

class Photo {
  Photo({
    this.key,
    this.value,
  });

  String key;
  String value;

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
    key: json["key"] == null ? null : json["key"],
    value: json["value"] == null ? null : json["value"],
  );

  Map<String, dynamic> toJson() => {
    "key": key == null ? null : key,
    "value": value == null ? null : value,
  };
}
