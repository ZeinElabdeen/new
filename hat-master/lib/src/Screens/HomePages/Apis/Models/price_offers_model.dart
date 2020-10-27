import 'dart:convert';
import 'AppModels/base_model.dart';


PriceOffersModel priceOffersModelFromJson(String str) =>
    PriceOffersModel.fromJson(json.decode(str));

String priceOffersModelToJson(PriceOffersModel data) =>
    json.encode(data.toJson());

class PriceOffersModel extends BaseModel {
  PriceOffersModel({
    this.code,
    this.data,
  });

  int code;
  List<Offer> data;

  factory PriceOffersModel.fromJson(Map<String, dynamic> json) =>
      PriceOffersModel(
        code: json["code"] == null ? null : json["code"],
        data: json["data"] == null
            ? null
            : List<Offer>.from(json["data"].map((x) => Offer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
      };

  @override
  BaseModel fromJson(Map<String, dynamic> json) {
    return PriceOffersModel.fromJson(json);
  }
}

class Offer {
  Offer({
    this.id,
    this.userId,
    this.user,
    this.driverId,
    this.driver,
    this.orderId,
    this.order,
    this.driverPhoto,
    this.driverRate,
    this.price,
    this.offerDetails,
    this.createdAt,
  });

  int id;
  int userId;
  String user;
  int driverId;
  String driverPhoto;
  int driverRate;
  String driver;
  int orderId;
  String order;
  int price;
  String offerDetails;
  DateTime createdAt;

  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        user: json["user"] == null ? null : json["user"],
        driverId: json["driver_id"] == null ? null : json["driver_id"],
        driver: json["driver"] == null ? null : json["driver"],
        driverPhoto: json["driver_photo"] == null ? null : json["driver_photo"],
        driverRate: json["driver_rate"] == null ? 0 : json["driver_rate"],
        orderId: json["order_id"] == null ? null : json["order_id"],
        order: json["order"] == null ? null : json["order"],
        price: json["price"] == null ? null : json["price"],
        offerDetails:
            json["offer_details"] == null ? null : json["offer_details"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "user_id": userId == null ? null : userId,
        "user": user == null ? null : user,
        "driver_id": driverId == null ? null : driverId,
        "driver": driver == null ? null : driver,
        "order_id": orderId == null ? null : orderId,
        "order": order == null ? null : order,
        "price": price == null ? null : price,
        "offer_details": offerDetails == null ? null : offerDetails,
        "created_at": createdAt == null
            ? null
            : "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
      };
}
