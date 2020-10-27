import 'dart:convert';

// import 'AppModels/base_model.dart';
// import 'package:haat/src/Screens/DriverHome/Apis/Models/AppModels/base_model.dart';

// import 'package:haat/src/Screens/DriverHome/Apis/Models/AppModels/base_model.dart';

import 'AppModels/base_model.dart';
import 'AppModels/error_model.dart';

PaymentModel paymentModelFromJson(String str) => PaymentModel.fromJson(json.decode(str));

String paymentModelToJson(PaymentModel data) => json.encode(data.toJson());

class PaymentModel extends BaseModel{
  PaymentModel({
    this.code,
    this.data,
    this.error,
  });

  int code;
  List<PaymentData> data;
  List<ApiError> error;

  factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
    code: json["code"] == null ? null : json["code"],
    data: json["data"] == null ? null : List<PaymentData>.from(json["data"].map((x) => PaymentData.fromJson(x))),
    error: json["error"] == null ? null : List<ApiError>.from(json["error"].map((x) => ApiError.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
    "error": error,
  };

  @override
  BaseModel fromJson(Map<String, dynamic> json) {
    return PaymentModel.fromJson(json);
  }
}

class PaymentData {
  PaymentData({
    this.key,
    this.paymentUrl,
  });

  String key;
  String paymentUrl;

  factory PaymentData.fromJson(Map<String, dynamic> json) => PaymentData(
    key: json["key"] == null ? null : json["key"],
    paymentUrl: json["payment_url"] == null ? null : json["payment_url"],
  );

  Map<String, dynamic> toJson() => {
    "key": key == null ? null : key,
    "payment_url": paymentUrl == null ? null : paymentUrl,
  };
}
