import 'dart:convert';
import 'package:haat/src/Screens/DriverHome/Apis/Models/AppModels/base_model.dart';

NationalitiesModel nationalitiesModelFromJson(String str) =>
    NationalitiesModel.fromJson(json.decode(str));

String nationalitiesModelToJson(NationalitiesModel data) =>
    json.encode(data.toJson());

class NationalitiesModel extends BaseModel {
  NationalitiesModel({
    this.code,
    this.data,
  });

  int code;
  List<Nationality> data;

  factory NationalitiesModel.fromJson(Map<String, dynamic> json) =>
      NationalitiesModel(
        code: json["code"] == null ? null : json["code"],
        data: json["data"] == null
            ? null
            : List<Nationality>.from(json["data"].map((x) => Nationality.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
      };

  @override
  BaseModel fromJson(Map<String, dynamic> json) {
    return NationalitiesModel.fromJson(json);
  }
}

class Nationality {
  Nationality({
    this.id,
    this.nationalityId,
    this.name,
    this.createdAt,
  });

  int id;
  String nationalityId;
  String name;
  DateTime createdAt;

  factory Nationality.fromJson(Map<String, dynamic> json) => Nationality(
        id: json["id"] == null ? null : json["id"],
        nationalityId:
            json["nationality_id"] == null ? null : json["nationality_id"],
        name: json["name"] == null ? null : json["name"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "nationality_id": nationalityId == null ? null : nationalityId,
        "name": name == null ? null : name,
        "created_at": createdAt == null
            ? null
            : "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
      };
}
