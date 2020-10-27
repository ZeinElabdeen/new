// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
    LoginModel({
        @required this.mainCode,
        @required this.code,
        @required this.data,
        @required this.error,
    });

    int mainCode;
    int code;
    List<Datum> data;
    List<Error> error;

    factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
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
        this.name,
        this.phoneNumber,
        this.email,
        this.active,
        this.type,
        this.deliveryType,
        this.regionId,
        this.region,
        this.cityId,
        this.city,
        this.carTypeId,
        this.carType,
        this.identityTypeId,
        this.identityType,
        this.nationalityId,
        this.nationality,
        this.idNumber,
        this.birthDate,
        this.driverAvailability,
        this.job,
        this.photo,
        this.identity,
        this.license,
        this.carForm,
        this.transportationCard,
        this.insurance,
        this.apiToken,
        this.rate,
        this.charge,
        this.createdAt,
    });

    int id;
    String name;
    String phoneNumber;
    String email;
    int active;
    int type;
    int deliveryType;
    int regionId;
    String region;
    int cityId;
    String city;
    int carTypeId;
    String carType;
    int identityTypeId;
    String identityType;
    int nationalityId;
    String nationality;
    int idNumber;
    DateTime birthDate;
    int driverAvailability;
    String job;
    String photo;
    String identity;
    String license;
    String carForm;
    String transportationCard;
    String insurance;
    String apiToken;
    int rate;
    int charge;
    DateTime createdAt;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
        email: json["email"] == null ? null : json["email"],
        active: json["active"] == null ? null : json["active"],
        type: json["type"] == null ? null : json["type"],
        deliveryType: json["delivery_type"] == null ? null : json["delivery_type"],
        regionId: json["region_id"] == null ? null : json["region_id"],
        region: json["region"] == null ? null : json["region"],
        cityId: json["city_id"] == null ? null : json["city_id"],
        city: json["city"] == null ? null : json["city"],
        carTypeId: json["carType_id"] == null ? null : json["carType_id"],
        carType: json["carType"] == null ? null : json["carType"],
        identityTypeId: json["identityType_id"] == null ? null : json["identityType_id"],
        identityType: json["identityType"] == null ? null : json["identityType"],
        nationalityId: json["nationality_id"] == null ? null : json["nationality_id"],
        nationality: json["nationality"] == null ? null : json["nationality"],
        idNumber: json["idNumber"] == null ? null : json["idNumber"],
        birthDate: json["birth_date"] == null ? null : DateTime.parse(json["birth_date"]),
        driverAvailability: json["driver_availability"] == null ? null : json["driver_availability"],
        job: json["job"] == null ? null : json["job"],
        photo: json["photo"] == null ? null : json["photo"],
        identity: json["identity"] == null ? null : json["identity"],
        license: json["license"] == null ? null : json["license"],
        carForm: json["car_form"] == null ? null : json["car_form"],
        transportationCard: json["transportation_card"] == null ? null : json["transportation_card"],
        insurance: json["insurance"] == null ? null : json["insurance"],
        apiToken: json["api_token"] == null ? null : json["api_token"],
        rate: json["rate"] == null ? null : json["rate"],
        charge: json["charge"] == null ? null : json["charge"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "phone_number": phoneNumber == null ? null : phoneNumber,
        "email": email == null ? null : email,
        "active": active == null ? null : active,
        "type": type == null ? null : type,
        "delivery_type": deliveryType == null ? null : deliveryType,
        "region_id": regionId == null ? null : regionId,
        "region": region == null ? null : region,
        "city_id": cityId == null ? null : cityId,
        "city": city == null ? null : city,
        "carType_id": carTypeId == null ? null : carTypeId,
        "carType": carType == null ? null : carType,
        "identityType_id": identityTypeId == null ? null : identityTypeId,
        "identityType": identityType == null ? null : identityType,
        "nationality_id": nationalityId == null ? null : nationalityId,
        "nationality": nationality == null ? null : nationality,
        "idNumber": idNumber == null ? null : idNumber,
        "birth_date": birthDate == null ? null : "${birthDate.year.toString().padLeft(4, '0')}-${birthDate.month.toString().padLeft(2, '0')}-${birthDate.day.toString().padLeft(2, '0')}",
        "driver_availability": driverAvailability == null ? null : driverAvailability,
        "job": job == null ? null : job,
        "photo": photo == null ? null : photo,
        "identity": identity == null ? null : identity,
        "license": license == null ? null : license,
        "car_form": carForm == null ? null : carForm,
        "transportation_card": transportationCard == null ? null : transportationCard,
        "insurance": insurance == null ? null : insurance,
        "api_token": apiToken == null ? null : apiToken,
        "rate": rate == null ? null : rate,
        "charge": charge == null ? null : charge,
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
