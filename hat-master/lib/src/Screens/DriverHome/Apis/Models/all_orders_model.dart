import 'dart:convert';

import 'AppModels/base_model.dart';

AllOrdersModel allOrdersModelFromJson(String str) =>
    AllOrdersModel.fromJson(json.decode(str));

String allOrdersModelToJson(AllOrdersModel data) => json.encode(data.toJson());

class AllOrdersModel extends BaseModel {
  AllOrdersModel({
    this.code,
    this.data,
  });

  int code;
  List<Order> data;

  factory AllOrdersModel.fromJson(Map<String, dynamic> json) => AllOrdersModel(
        code: json["code"] == null ? null : json["code"],
        data: json["data"] == null
            ? null
            : List<Order>.from(json["data"].map((x) => Order.fromJson(x))),
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
  Order(
      {this.id,
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
      this.resturantPhone,
      this.provider,
      this.orderCart,
      this.createdAt,
      this.userPhoto,
      this.userRate,
      this.rateState

      
      });

  int id;
  int userId;
  String user;
  String userPhone;
  String userPhoto;
  String resturantPhone;
  int userRate;
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
  List<OrderCart> orderCart;
  DateTime createdAt;
  bool rateState;

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
        price: json["price"] == null ? null : json["price"],
        orderPrice: json["order_price"] == null ? null : json["order_price"],
        driverId: json["driver_id"] == null ? null : json["driver_id"],
        driver: json["driver"] == null ? null : json["driver"],
        driverPhone: json["driver_phone"] == null ? null : json["driver_phone"],
        type: json["type"] == null ? null : json["type"],
        status: json["status"] == null ? null : json["status"],
        providerId: json["provider_id"] == null ? null : json["provider_id"],
        provider: json["provider"] == null ? null : json["provider"],
        userPhoto: json["user_photo"] == null ? null : json["user_photo"],
        resturantPhone: json["resturant_phone"] == null ? null : json["resturant_phone"],
        userRate: json["user_rate"] == null ? "0" : json["user_rate"],
        rateState: json["rate_state"] == null ? false : json["rate_state"],
        orderCart: json["order_cart"] == null
            ? null
            : List<OrderCart>.from(
                json["order_cart"].map((x) => OrderCart.fromJson(x))),
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
        "order_cart": orderCart == null
            ? null
            : List<dynamic>.from(orderCart.map((x) => x.toJson())),
        "created_at": createdAt == null
            ? null
            : "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
      };
}

class OrderCart {
  OrderCart({
    this.id,
    this.orderDetails,
    this.orderLongitude,
    this.orderLatitude,
    this.placeName,
    this.state,
    this.userId,
    this.providerId,
    this.orderId,
    this.photo,
    this.createdAt,
    this.updatedAt,
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
  String photo;
  DateTime createdAt;
  DateTime updatedAt;

  factory OrderCart.fromJson(Map<String, dynamic> json) => OrderCart(
        id: json["id"] == null ? null : json["id"],
        orderDetails:
            json["order_details"] == null ? null : json["order_details"],
        orderLongitude:
            json["order_longitude"] == null ? null : json["order_longitude"],
        orderLatitude:
            json["order_latitude"] == null ? null : json["order_latitude"],
        placeName: json["place_name"] == null ? null : json["place_name"],
        state: json["state"] == null ? null : json["state"],
        userId: json["user_id"] == null ? null : json["user_id"],
        providerId: json["provider_id"] == null ? null : json["provider_id"],
        orderId: json["order_id"] == null ? null : json["order_id"],
        photo: json["photo"] == null ? null : json["photo"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
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
        "photo": photo == null ? null : photo,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
      };
}
