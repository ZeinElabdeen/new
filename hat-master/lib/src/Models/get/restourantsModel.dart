// To parse this JSON data, do
//
//     final restourantsModel = restourantsModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

RestourantsModel restourantsModelFromJson(String str) => RestourantsModel.fromJson(json.decode(str));

String restourantsModelToJson(RestourantsModel data) => json.encode(data.toJson());

class RestourantsModel {
    RestourantsModel({
        @required this.mainCode,
        @required this.code,
        @required this.data,
        @required this.error,
    });

    int mainCode;
    int code;
    List<Datum> data;
    List<Error> error;

    factory RestourantsModel.fromJson(Map<String, dynamic> json) => RestourantsModel(
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
        @required this.name,
        @required this.longitude,
        @required this.latitude,
        @required this.departmentId,
        @required this.department,
        @required this.photo,
        @required this.photos,
        @required this.distance,
    });

    int id;
    String name;
    String longitude;
    String latitude;
    int departmentId;
    String department;
    String photo;
    List<Photo> photos;
    double distance;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        longitude: json["longitude"] == null ? null : json["longitude"],
        latitude: json["latitude"] == null ? null : json["latitude"],
        departmentId: json["department_id"] == null ? null : json["department_id"],
        department: json["department"] == null ? null : json["department"],
        photo: json["photo"] == null ? null : json["photo"],
        photos: json["photos"] == null ? null : List<Photo>.from(json["photos"].map((x) => Photo.fromJson(x))),
        distance: json["distance"] == null ? null : json["distance"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "longitude": longitude == null ? null : longitude,
        "latitude": latitude == null ? null : latitude,
        "department_id": departmentId == null ? null : departmentId,
        "department": department == null ? null : department,
        "photo": photo == null ? null : photo,
        "photos": photos == null ? null : List<dynamic>.from(photos.map((x) => x.toJson())),
        "distance": distance == null ? null : distance,
    };
}

class Photo {
    Photo({
        @required this.id,
        @required this.photo,
    });

    int id;
    String photo;

    factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        id: json["id"] == null ? null : json["id"],
        photo: json["photo"] == null ? null : json["photo"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "photo": photo == null ? null : photo,
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
