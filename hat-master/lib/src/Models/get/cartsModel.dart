// To parse this JSON data, do
//
//     final cartsModel = cartsModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CartsModel cartsModelFromJson(String str) => CartsModel.fromJson(json.decode(str));

String cartsModelToJson(CartsModel data) => json.encode(data.toJson());

class CartsModel {
    CartsModel({
        @required this.mainCode,
        @required this.code,
        @required this.data,
        @required this.error,
    });

    int mainCode;
    int code;
    List<Datum> data;
    List<Error> error;

    factory CartsModel.fromJson(Map<String, dynamic> json) => CartsModel(
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
        @required this.orderLatitude,
        @required this.orderLongitude,
        @required this.orderDetails,
        @required this.placeName,
        @required this.photo,
        @required this.state,
        @required this.userId,
        @required this.userName,
        @required this.providerId,
        @required this.providerName,
        @required this.providerPhoto,
        @required this.createdAt,
    });

    int id;
    String orderLatitude;
    String orderLongitude;
    String orderDetails;
    String placeName;
    String photo;
    int state;
    int userId;
    String userName;
    int providerId;
    String providerName;
    String providerPhoto;
    DateTime createdAt;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] == null ? null : json["id"],
        orderLatitude: json["order_latitude"] == null ? null : json["order_latitude"],
        orderLongitude: json["order_longitude"] == null ? null : json["order_longitude"],
        orderDetails: json["order_details"] == null ? null : json["order_details"],
        placeName: json["place_name"] == null ? null : json["place_name"],
        photo: json["photo"] == null ?  'https://cdn.al-ain.com/images/2019/5/05/153-012458-storage-vegetables-fruits_700x400.jpeg' : json["photo"],
        state: json["state"] == null ? null : json["state"],
        userId: json["user_id"] == null ? null : json["user_id"],
        userName: json["user_name"] == null ? null : json["user_name"],
        providerId: json["provider_id"] == null ? null : json["provider_id"],
        providerName: json["provider_name"] == null ? null : json["provider_name"],
        providerPhoto: json["provider_photo"] == null ? null : json["provider_photo"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "order_latitude": orderLatitude == null ? null : orderLatitude,
        "order_longitude": orderLongitude == null ? null : orderLongitude,
        "order_details": orderDetails == null ? null : orderDetails,
        "place_name": placeName == null ? null : placeName,
        "photo": photo == null ? null : photo,
        "state": state == null ? null : state,
        "user_id": userId == null ? null : userId,
        "user_name": userName == null ? null : userName,
        "provider_id": providerId == null ? null : providerId,
        "provider_name": providerName == null ? null : providerName,
        "provider_photo": providerPhoto == null ? null : providerPhoto,
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
