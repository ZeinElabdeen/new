// To parse this JSON data, do
//
//     final postCartModel = postCartModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

PostCartModel postCartModelFromJson(String str) => PostCartModel.fromJson(json.decode(str));

String postCartModelToJson(PostCartModel data) => json.encode(data.toJson());

class PostCartModel {
    PostCartModel({
        @required this.mainCode,
        @required this.code,
        @required this.data,
        @required this.error,
    });

    int mainCode;
    int code;
    List<Datum> data;
    List<Error> error;

    factory PostCartModel.fromJson(Map<String, dynamic> json) => PostCartModel(
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
        @required this.latitude,
        @required this.longitude,
        @required this.type,
        @required this.status,
        @required this.cart,
        @required this.orderCart,
        @required this.code,
        @required this.createdAt,
    });

    int id;
    int userId;
    String user;
    String orderDetails;
    String addressDetails;
    String latitude;
    String longitude;
    int type;
    int status;
    int cart;
    List<OrderCart> orderCart;
    String code;
    DateTime createdAt;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        user: json["user"] == null ? null : json["user"],
        orderDetails: json["order_details"] == null ? null : json["order_details"],
        addressDetails: json["address_details"] == null ? null : json["address_details"],
        latitude: json["latitude"] == null ? null : json["latitude"],
        longitude: json["longitude"] == null ? null : json["longitude"],
        type: json["type"] == null ? null : json["type"],
        status: json["status"] == null ? null : json["status"],
        cart: json["cart"] == null ? null : json["cart"],
        orderCart: json["order_cart"] == null ? null : List<OrderCart>.from(json["order_cart"].map((x) => OrderCart.fromJson(x))),
        code: json["code"] == null ? null : json["code"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "user_id": userId == null ? null : userId,
        "user": user == null ? null : user,
        "order_details": orderDetails == null ? null : orderDetails,
        "address_details": addressDetails == null ? null : addressDetails,
        "latitude": latitude == null ? null : latitude,
        "longitude": longitude == null ? null : longitude,
        "type": type == null ? null : type,
        "status": status == null ? null : status,
        "cart": cart == null ? null : cart,
        "order_cart": orderCart == null ? null : List<dynamic>.from(orderCart.map((x) => x.toJson())),
        "code": code == null ? null : code,
        "created_at": createdAt == null ? null : "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
    };
}

class OrderCart {
    OrderCart({
        @required this.id,
        @required this.orderDetails,
        @required this.orderLongitude,
        @required this.orderLatitude,
        @required this.placeName,
        @required this.state,
        @required this.userId,
        @required this.providerId,
        @required this.orderId,
        @required this.photo,
        @required this.createdAt,
        @required this.updatedAt,
    });

    int id;
    String orderDetails;
    String orderLongitude;
    String orderLatitude;
    String placeName;
    String state;
    int userId;
    int providerId;
    int orderId;
    dynamic photo;
    DateTime createdAt;
    DateTime updatedAt;

    factory OrderCart.fromJson(Map<String, dynamic> json) => OrderCart(
        id: json["id"] == null ? null : json["id"],
        orderDetails: json["order_details"] == null ? null : json["order_details"],
        orderLongitude: json["order_longitude"] == null ? null : json["order_longitude"],
        orderLatitude: json["order_latitude"] == null ? null : json["order_latitude"],
        placeName: json["place_name"] == null ? null : json["place_name"],
        state: json["state"] == null ? null : json["state"],
        userId: json["user_id"] == null ? null : json["user_id"],
        providerId: json["provider_id"] == null ? null : json["provider_id"],
        orderId: json["order_id"] == null ? null : json["order_id"],
        photo: json["photo"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "order_details": orderDetails == null ? null : orderDetails,
        "order_longitude": orderLongitude == null ? null : orderLongitude,
        "order_latitude": orderLatitude == null ? null : orderLatitude,
        "place_name": placeName == null ? null : placeName,
        "state": state == null ? null : state,
        "user_id": userId == null ? null : userId,
        "provider_id": providerId == null ? null : providerId,
        "order_id": orderId == null ? null : orderId,
        "photo": photo,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
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
