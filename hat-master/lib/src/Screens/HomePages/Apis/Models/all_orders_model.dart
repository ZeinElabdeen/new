import 'dart:convert';

import 'AppModels/base_model.dart';
import 'AppModels/error_model.dart';

AllOrdersModel allOrdersModelFromJson(String str) =>
    AllOrdersModel.fromJson(json.decode(str));

String allOrdersModelToJson(AllOrdersModel data) => json.encode(data.toJson());

class AllOrdersModel extends BaseModel {
  AllOrdersModel({
    this.code,
    this.data,
    this.error,
  });

  int code;
  List<Order> data;
  List<ApiError> error;

  factory AllOrdersModel.fromJson(Map<String, dynamic> json) => AllOrdersModel(
        code: json["code"] == null ? null : json["code"],
        data: json["data"] == null
            ? null
            : List<Order>.from(json["data"].map((x) => Order.fromJson(x))),
        error: json["error"] == null
            ? null
            : List<ApiError>.from(
                json["error"].map((x) => ApiError.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
      };

  @override
  BaseModel fromJson(Map<String, dynamic> json) {
    return AllOrdersModel.fromJson(json);
  }
}

class Order {
  Order({
    this.id,
    this.userId,
    this.user,
    this.userPhone,
    this.placeName,
    this.orderDetails,
    this.addressDetails,
    this.photo,
    this.orderLatitude,
    this.orderLongitude,
    this.latitude,
    this.longitude,
    this.distance,
    this.price,
    this.orderPrice,
    this.driverId,
    this.driver,
    this.driverPhone,
    this.type,
    this.status,
    this.providerId,
    this.provider,
    this.createdAt,
  });

  int id;
  int userId;
  String user;
  String userPhone;
  String placeName;
  String orderDetails;
  String addressDetails;
  String photo;
  String orderLatitude;
  String orderLongitude;
  String latitude;
  String longitude;
  double distance;
  int price;
  int orderPrice;
  int driverId;
  String driver;
  String driverPhone;
  int type;
  int status;
  int providerId;
  String provider;
  DateTime createdAt;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        user: json["user"] == null ? null : json["user"],
        userPhone: json["user_phone"] == null ? null : json["user_phone"],
        placeName: json["place_name"] == null ? null : json["place_name"],
        orderDetails:
            json["order_details"] == null ? null : json["order_details"],
        addressDetails:
            json["address_details"] == null ? null : json["address_details"],
        photo: json["photo"] == null ? null : json["photo"],
        orderLatitude:
            json["order_latitude"] == null ? null : json["order_latitude"],
        orderLongitude:
            json["order_longitude"] == null ? null : json["order_longitude"],
        latitude: json["latitude"] == null ? null : json["latitude"],
        longitude: json["longitude"] == null ? null : json["longitude"],
        distance: json["distance"] == null ? null : json["distance"].toDouble(),
        price: json["price"] == null ? 0 : json["price"],
        orderPrice: json["order_price"] == null ? 0 : json["order_price"],
        driverId: json["driver_id"] == null ? null : json["driver_id"],
        driver: json["driver"] == null ? null : json["driver"],
        driverPhone: json["driver_phone"] == null ? null : json["driver_phone"],
        type: json["type"] == null ? null : json["type"],
        status: json["status"] == null ? null : json["status"],
        providerId: json["provider_id"] == null ? null : json["provider_id"],
        provider: json["provider"] == null ? null : json["provider"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "user_id": userId == null ? null : userId,
        "user": user == null ? null : user,
        "user_phone": userPhone == null ? null : userPhone,
        "place_name": placeName == null ? null : placeName,
        "order_details": orderDetails == null ? null : orderDetails,
        "address_details": addressDetails == null ? null : addressDetails,
        "photo": photo == null ? null : photo,
        "order_latitude": orderLatitude == null ? null : orderLatitude,
        "order_longitude": orderLongitude == null ? null : orderLongitude,
        "latitude": latitude == null ? null : latitude,
        "longitude": longitude == null ? null : longitude,
        "distance": distance == null ? null : distance,
        "price": price,
        "order_price": orderPrice,
        "driver_id": driverId,
        "driver": driver,
        "driver_phone": driverPhone,
        "type": type == null ? null : type,
        "status": status == null ? null : status,
        "provider_id": providerId,
        "provider": provider,
        "created_at": createdAt == null
            ? null
            : "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
      };
}
