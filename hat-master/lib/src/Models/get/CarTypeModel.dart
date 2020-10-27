// To parse this JSON data, do
//
//     final carTypeModel = carTypeModelFromJson(jsonString);

import 'dart:convert';
import '../customError.dart';


CarTypeModel carTypeModelFromJson(String str) => CarTypeModel.fromJson(json.decode(str));

String carTypeModelToJson(CarTypeModel data) => json.encode(data.toJson());

class CarTypeModel {
    CarTypeModel({
        this.mainCode,
        this.code,
        this.data,
        this.error,
    });

    int mainCode;
    int code;
    List<Cars> data;
    List<Error> error;

    factory CarTypeModel.fromJson(Map<String, dynamic> json) => CarTypeModel(
        mainCode: json["mainCode"] == null ? null : json["mainCode"],
        code: json["code"] == null ? null : json["code"],
        data: json["data"] == null ? null : List<Cars>.from(json["data"].map((x) => Cars.fromJson(x))),
         error: json["error"] == null
            ? null
            : List<Error>.from(json["error"].map((x) => Error.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "mainCode": mainCode == null ? null : mainCode,
        "code": code == null ? null : code,
        "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
         "error": error == null
            ? null
            : List<dynamic>.from(error.map((x) => x.toJson())),
    };
}

class Cars {
    Cars({
        this.id,
        this.carTypeId,
        this.name,
        this.createdAt,
    });

    int id;
    String carTypeId;
    String name;
    DateTime createdAt;

    factory Cars.fromJson(Map<String, dynamic> json) => Cars(
        id: json["id"] == null ? null : json["id"],
        carTypeId: json["carType_id"] == null ? null : json["carType_id"],
        name: json["name"] == null ? null : json["name"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "carType_id": carTypeId == null ? null : carTypeId,
        "name": name == null ? null : name,
        "created_at": createdAt == null ? null : "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
    };
}
