// To parse this JSON data, do
//
//     final changeDriverDataModel = changeDriverDataModelFromJson(jsonString);

import 'dart:convert';

ChangeDriverDataModel changeDriverDataModelFromJson(String str) => ChangeDriverDataModel.fromJson(json.decode(str));

String changeDriverDataModelToJson(ChangeDriverDataModel data) => json.encode(data.toJson());

class ChangeDriverDataModel {
    ChangeDriverDataModel({
        this.mainCode,
        this.code,
        this.data,
        this.error,
    });

    int mainCode;
    int code;
    List<Datum> data;
    List<Error> error;

    factory ChangeDriverDataModel.fromJson(Map<String, dynamic> json) => ChangeDriverDataModel(
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
        this.email,
        this.phoneNumber,
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
        this.job,
        this.photo,
        this.apiToken,
        this.createdAt,
    });

    int id;
    String name;
    String email;
    String phoneNumber;
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
    String job;
    String photo;
    String apiToken;
    DateTime createdAt;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        email: json["email"] == null ? null : json["email"],
        phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
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
        job: json["job"] == null ? null : json["job"],
        photo: json["photo"] == null ? null : json["photo"],
        apiToken: json["api_token"] == null ? null : json["api_token"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "email": email == null ? null : email,
        "phone_number": phoneNumber == null ? null : phoneNumber,
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
        "job": job == null ? null : job,
        "photo": photo == null ? null : photo,
        "api_token": apiToken == null ? null : apiToken,
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
