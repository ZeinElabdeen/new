// To parse this JSON data, do
//
//     final editAccountModel = editAccountModelFromJson(jsonString);

import 'dart:convert';

EditAccountModel editAccountModelFromJson(String str) => EditAccountModel.fromJson(json.decode(str));

String editAccountModelToJson(EditAccountModel data) => json.encode(data.toJson());

class EditAccountModel {
    EditAccountModel({
        this.mainCode,
        this.code,
        this.data,
        this.error,
    });

    int mainCode;
    int code;
    Data data;
    List<Error> error;

    factory EditAccountModel.fromJson(Map<String, dynamic> json) => EditAccountModel(
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
        this.message,
        this.name,
        this.photo,
        this.email
    });

    String key;
    String message;
    String name;
    String photo;
    String email;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        key: json["key"] == null ? null : json["key"],
        message: json["message"] == null ? null : json["message"],
        name: json["name"] == null ? null : json["name"],
        photo: json["photo"] == null ? null : json["photo"],
        email: json["email"] == null ? null : json["email"],
    );

    Map<String, dynamic> toJson() => {
        "key": key == null ? null : key,
        "message": message == null ? null : message,
        "name": name == null ? null : name,
        "photo": photo == null ? null : photo,
        "email": email == null ? null : email,
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
