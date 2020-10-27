// To parse this JSON data, do
//
//     final helpCenterModel = helpCenterModelFromJson(jsonString);

import 'dart:convert';

HelpCenterModel helpCenterModelFromJson(String str) => HelpCenterModel.fromJson(json.decode(str));

String helpCenterModelToJson(HelpCenterModel data) => json.encode(data.toJson());

class HelpCenterModel {
    HelpCenterModel({
        this.mainCode,
        this.code,
        this.data,
        this.error,
    });

    int mainCode;
    int code;
    Data data;
    List<Error> error;

    factory HelpCenterModel.fromJson(Map<String, dynamic> json) => HelpCenterModel(
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
        this.countryCode,
        this.phoneNumber,
    });

    int countryCode;
    int phoneNumber;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        countryCode: json["country_code"] == null ? null : json["country_code"],
        phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
    );

    Map<String, dynamic> toJson() => {
        "country_code": countryCode == null ? null : countryCode,
        "phone_number": phoneNumber == null ? null : phoneNumber,
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
