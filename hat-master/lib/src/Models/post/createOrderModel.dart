// To parse this JSON data, do
//
//     final createOrderModel = createOrderModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CreateOrderModel createOrderModelFromJson(String str) => CreateOrderModel.fromJson(json.decode(str));

String createOrderModelToJson(CreateOrderModel data) => json.encode(data.toJson());

class CreateOrderModel {
    CreateOrderModel({
        @required this.mainCode,
        @required this.code,
        @required this.data,
        @required this.error,
    });

    int mainCode;
    int code;
    List<Datum> data;
    List<Error> error;

    factory CreateOrderModel.fromJson(Map<String, dynamic> json) => CreateOrderModel(
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
        @required this.user,
        @required this.orderDetails,
        @required this.addressDetails,
        @required this.photo,
        @required this.orderLatitude,
        @required this.orderLongitude,
        @required this.latitude,
        @required this.longitude,
        @required this.price,
        @required this.placeName,
        @required this.driverId,
        @required this.driver,
        @required this.code,
        @required this.status,
        @required this.type,
        @required this.createdAt,
    });

    int id;
    int userId;
    String user;
    String orderDetails;
    String addressDetails;
    String photo;
    String orderLatitude;
    String orderLongitude;
    String latitude;
    String longitude;
    int price;
    String placeName;
    int driverId;
    String driver;
    String code;
    int status;
    int type;
    DateTime createdAt;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        user: json["user"] == null ? null : json["user"],
        orderDetails: json["order_details"] == null ? null : json["order_details"],
        addressDetails: json["address_details"] == null ? null : json["address_details"],
        photo: json["photo"] == null ? null : json["photo"],
        orderLatitude: json["order_latitude"] == null ? null : json["order_latitude"],
        orderLongitude: json["order_longitude"] == null ? null : json["order_longitude"],
        latitude: json["latitude"] == null ? null : json["latitude"],
        longitude: json["longitude"] == null ? null : json["longitude"],
        price: json["price"] == null ? null : json["price"],
        placeName: json["place_name"] == null ? null : json["place_name"],
        driverId: json["driver_id"] == null ? null : json["driver_id"],
        driver: json["driver"] == null ? null : json["driver"],
        code: json["code"] == null ? null : json["code"],
        status: json["status"] == null ? null : json["status"],
        type: json["type"] == null ? null : json["type"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "user_id": userId == null ? null : userId,
        "user": user == null ? null : user,
        "order_details": orderDetails == null ? null : orderDetails,
        "address_details": addressDetails == null ? null : addressDetails,
        "photo": photo == null ? null : photo,
        "order_latitude": orderLatitude == null ? null : orderLatitude,
        "order_longitude": orderLongitude == null ? null : orderLongitude,
        "latitude": latitude == null ? null : latitude,
        "longitude": longitude == null ? null : longitude,
        "price": price == null ? null : price,
        "place_name": placeName == null ? null : placeName,
        "driver_id": driverId == null ? null : driverId,
        "driver": driver == null ? null : driver,
        "code": code == null ? null : code,
        "status": status == null ? null : status,
        "type": type == null ? null : type,
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
