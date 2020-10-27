// To parse this JSON data, do
//
//     final availableModel = availableModelFromJson(jsonString);

import 'dart:convert';

AvailableModel availableModelFromJson(String str) => AvailableModel.fromJson(json.decode(str));

String availableModelToJson(AvailableModel data) => json.encode(data.toJson());

class AvailableModel {
    AvailableModel({
        this.mainCode,
        this.code,
        this.data,
        this.error,
    });

    int mainCode;
    int code;
    Data data;
    List<Error> error;

    factory AvailableModel.fromJson(Map<String, dynamic> json) => AvailableModel(
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
        this.availability,
        this.latitude,
        this.longitude,
    });

    String availability;
    String latitude;
    String longitude;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        availability: json["availability"] == null ? null : json["availability"],
        latitude: json["latitude"] == null ? null : json["latitude"],
        longitude: json["longitude"] == null ? null : json["longitude"],
    );

    Map<String, dynamic> toJson() => {
        "availability": availability == null ? null : availability,
        "latitude": latitude == null ? null : latitude,
        "longitude": longitude == null ? null : longitude,
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
