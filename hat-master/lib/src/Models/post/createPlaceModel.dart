// To parse this JSON data, do
//
//     final createPlaceModel = createPlaceModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CreatePlaceModel createPlaceModelFromJson(String str) => CreatePlaceModel.fromJson(json.decode(str));

String createPlaceModelToJson(CreatePlaceModel data) => json.encode(data.toJson());

class CreatePlaceModel {
    CreatePlaceModel({
        @required this.mainCode,
        @required this.code,
        @required this.data,
        @required this.error,
    });

    int mainCode;
    int code;
    List<Datum> data;
    List<Error> error;

    factory CreatePlaceModel.fromJson(Map<String, dynamic> json) => CreatePlaceModel(
        mainCode: json["mainCode"] == null ? null : json["mainCode"],
        code: json["code"] == null ? null : json["code"],
        data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        error: json["error"] == null ? null : List<Error>.from(json["error"].map((x) => Error.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "mainCode": mainCode == null ? null : mainCode,
        "code": code == null ? null : code,
        "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
        "error": error == null ? null : List<dynamic>.from(error.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
        @required this.id,
        @required this.userId,
        @required this.placeName,
        @required this.placeDetails,
        @required this.latitude,
        @required this.longitude,
        @required this.createdAt,
    });

    int id;
    int userId;
    String placeName;
    String placeDetails;
    String latitude;
    String longitude;
    DateTime createdAt;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        placeName: json["place_name"] == null ? null : json["place_name"],
        placeDetails: json["place_details"] == null ? null : json["place_details"],
        latitude: json["latitude"] == null ? null : json["latitude"],
        longitude: json["longitude"] == null ? null : json["longitude"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "user_id": userId == null ? null : userId,
        "place_name": placeName == null ? null : placeName,
        "place_details": placeDetails == null ? null : placeDetails,
        "latitude": latitude == null ? null : latitude,
        "longitude": longitude == null ? null : longitude,
        "created_at": createdAt == null ? null : "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
    };
}

class Error {
    Error({
        @required this.key,
        @required this.value,
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
