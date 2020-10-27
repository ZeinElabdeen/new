// To parse this JSON data, do
//
//     final finishOrderModel = finishOrderModelFromJson(jsonString);

import 'dart:convert';

FinishOrderModel finishOrderModelFromJson(String str) => FinishOrderModel.fromJson(json.decode(str));

String finishOrderModelToJson(FinishOrderModel data) => json.encode(data.toJson());

class FinishOrderModel {
    FinishOrderModel({
        this.mainCode,
        this.code,
        this.data,
        this.error,
    });

    int mainCode;
    int code;
    Data data;
    List<Error> error;

    factory FinishOrderModel.fromJson(Map<String, dynamic> json) => FinishOrderModel(
        mainCode: json["mainCode"] == null ? null : json["mainCode"],
        code: json["code"] == null ? null : json["code"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        error: json["error"] == null ? null : List<Error>.from(json["error"].map((x) => Error.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "mainCode": mainCode == null ? null : mainCode,
        "code": code == null ? null : code,
        "data": data == null ? null : data.toJson(),
        "error": error == null ? null : List<dynamic>.from(error.map((x) => x.toJson())),
    };
}

class Data {
    Data({
        this.key,
        this.paymentUrl,
        this.value,
    });

    String key;
    String paymentUrl;
    String value;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        key: json["key"] == null ? null : json["key"],
        paymentUrl: json["payment_url"] == null ? null : json["payment_url"],
        value: json["value"] == null ? null : json["value"],
    );

    Map<String, dynamic> toJson() => {
        "key": key == null ? null : key,
        "payment_url": paymentUrl == null ? null : paymentUrl,
        "value": value == null ? null : value,
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
