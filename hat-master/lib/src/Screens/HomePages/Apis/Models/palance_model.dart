import 'dart:convert';
import 'AppModels/base_model.dart';


BalanceModel balanceModelFromJson(String str) => BalanceModel.fromJson(json.decode(str));

String balanceModelToJson(BalanceModel data) => json.encode(data.toJson());

class BalanceModel extends BaseModel{
  BalanceModel({
    this.code,
    this.data,
  });

  int code;
  List<Balance> data;

  factory BalanceModel.fromJson(Map<String, dynamic> json) => BalanceModel(
    code: json["code"] == null ? null : json["code"],
    data: json["data"] == null ? null : List<Balance>.from(json["data"].map((x) => Balance.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
  };

  @override
  BaseModel fromJson(Map<String, dynamic> json) {
    return BalanceModel.fromJson(json);
  }
}

class Balance {
  Balance({
    this.key,
    this.value,
  });

  String key;
  int value;

  factory Balance.fromJson(Map<String, dynamic> json) => Balance(
    key: json["key"] == null ? null : json["key"],
    value: json["value"] == null ? null : json["value"],
  );

  Map<String, dynamic> toJson() => {
    "key": key == null ? null : key,
    "value": value == null ? null : value,
  };
}
