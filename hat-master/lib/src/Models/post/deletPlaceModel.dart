// To parse this JSON data, do
//
//     final deletePlaceDataModel = deletePlaceDataModelFromJson(jsonString);

import 'dart:convert';

DeletePlaceDataModel deletePlaceDataModelFromJson(String str) => DeletePlaceDataModel.fromJson(json.decode(str));

String deletePlaceDataModelToJson(DeletePlaceDataModel data) => json.encode(data.toJson());

class DeletePlaceDataModel {
    DeletePlaceDataModel({
        this.mainCode,
        this.code,
        this.data,
        this.error,
    });

    int mainCode;
    int code;
    Data data;
    List<Data> error;

    factory DeletePlaceDataModel.fromJson(Map<String, dynamic> json) => DeletePlaceDataModel(
        mainCode: json["mainCode"] == null ? null : json["mainCode"],
        code: json["code"] == null ? null : json["code"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        error: json["error"] == null ? null : List<Data>.from(json["error"].map((x) => Data.fromJson(x))),
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
        this.key,
        this.value,
    });

    String key;
    String value;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        key: json["key"] == null ? null : json["key"],
        value: json["value"] == null ? null : json["value"],
    );

    Map<String, dynamic> toJson() => {
        "key": key == null ? null : key,
        "value": value == null ? null : value,
    };
}
