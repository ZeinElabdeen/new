import 'dart:convert';

import 'AppModels/base_model.dart';


HelpPhoneModel helpPhoneModelFromJson(String str) =>
    HelpPhoneModel.fromJson(json.decode(str));

String helpPhoneModelToJson(HelpPhoneModel data) => json.encode(data.toJson());

class HelpPhoneModel extends BaseModel {
  HelpPhoneModel({
    this.code,
    this.data,
  });

  int code;
  List<HelpPhoneData> data;

  factory HelpPhoneModel.fromJson(Map<String, dynamic> json) => HelpPhoneModel(
        code: json["code"] == null ? null : json["code"],
        data: json["data"] == null
            ? null
            : List<HelpPhoneData>.from(
                json["data"].map((x) => HelpPhoneData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
      };

  @override
  BaseModel fromJson(Map<String, dynamic> json) {
    return HelpPhoneModel.fromJson(json);
  }
}

class HelpPhoneData {
  HelpPhoneData({
    this.id,
    this.phone,
  });

  int id;
  String phone;

  factory HelpPhoneData.fromJson(Map<String, dynamic> json) => HelpPhoneData(
        id: json["id"] == null ? null : json["id"],
        phone: json["phone"] == null ? null : json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "phone": phone == null ? null : phone,
      };
}
