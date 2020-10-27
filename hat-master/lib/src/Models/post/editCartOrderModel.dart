// To parse this JSON data, do
//
//     final editCartOrderModel = editCartOrderModelFromJson(jsonString);

import 'dart:convert';

EditCartOrderModel editCartOrderModelFromJson(String str) => EditCartOrderModel.fromJson(json.decode(str));

String editCartOrderModelToJson(EditCartOrderModel data) => json.encode(data.toJson());

class EditCartOrderModel {
    EditCartOrderModel({
        this.mainCode,
        this.code,
        this.data,
        this.error,
    });

    int mainCode;
    int code;
    List<Datum> data;
    List<Error> error;

    factory EditCartOrderModel.fromJson(Map<String, dynamic> json) => EditCartOrderModel(
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
        this.id,
        this.userId,
        this.user,
        this.placeName,
        this.orderDetails,
        this.photo,
        this.orderLatitude,
        this.orderLongitude,
        this.state,
        this.providerId,
        this.provider,
        this.createdAt,
    });

    int id;
    int userId;
    String user;
    String placeName;
    String orderDetails;
    dynamic photo;
    String orderLatitude;
    String orderLongitude;
    int state;
    int providerId;
    String provider;
    DateTime createdAt;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        user: json["user"] == null ? null : json["user"],
        placeName: json["place_name"] == null ? null : json["place_name"],
        orderDetails: json["order_details"] == null ? null : json["order_details"],
        photo: json["photo"],
        orderLatitude: json["order_latitude"] == null ? null : json["order_latitude"],
        orderLongitude: json["order_longitude"] == null ? null : json["order_longitude"],
        state: json["state"] == null ? null : json["state"],
        providerId: json["provider_id"] == null ? null : json["provider_id"],
        provider: json["provider"] == null ? null : json["provider"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "user_id": userId == null ? null : userId,
        "user": user == null ? null : user,
        "place_name": placeName == null ? null : placeName,
        "order_details": orderDetails == null ? null : orderDetails,
        "photo": photo,
        "order_latitude": orderLatitude == null ? null : orderLatitude,
        "order_longitude": orderLongitude == null ? null : orderLongitude,
        "state": state == null ? null : state,
        "provider_id": providerId == null ? null : providerId,
        "provider": provider == null ? null : provider,
        "created_at": createdAt == null ? null : "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
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
