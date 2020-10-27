import 'dart:convert';
import 'AppModels/base_model.dart';


ProvidersModel providersModelFromJson(String str) =>
    ProvidersModel.fromJson(json.decode(str));

String providersModelToJson(ProvidersModel data) => json.encode(data.toJson());

class ProvidersModel extends BaseModel {
  ProvidersModel({
    this.code,
    this.data,
  });

  int code;
  List<Provider> data;

  factory ProvidersModel.fromJson(Map<String, dynamic> json) => ProvidersModel(
        code: json["code"] == null ? null : json["code"],
        data: json["data"] == null
            ? null
            : List<Provider>.from(json["data"].map((x) => Provider.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
      };

  @override
  BaseModel fromJson(Map<String, dynamic> json) {
    return ProvidersModel.fromJson(json);
  }
}

class Provider {
  Provider({
    this.id,
    this.name,
    this.photo,
    this.latitude,
    this.longitude,
    this.departmentId,
    this.department,
    this.cityId,
    this.city,
    this.distance,
    this.createdAt,
  });

  int id;
  String name;
  String photo;
  double latitude;
  double longitude;
  int departmentId;
  String department;
  int cityId;
  String city;
  double distance;
  DateTime createdAt;

  factory Provider.fromJson(Map<String, dynamic> json) => Provider(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        photo: json["photo"] == null ? null : json["photo"],
        latitude: json["latitude"] == null ? null : json["latitude"].toDouble(),
        longitude:
            json["longitude"] == null ? null : json["longitude"].toDouble(),
        departmentId:
            json["department_id"] == null ? null : json["department_id"],
        department: json["department"] == null ? null : json["department"],
        cityId: json["city_id"] == null ? null : json["city_id"],
        city: json["city"] == null ? null : json["city"],
        distance: json["distance"] == null ? null : json["distance"].toDouble(),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "photo": photo == null ? null : photo,
        "latitude": latitude == null ? null : latitude,
        "longitude": longitude == null ? null : longitude,
        "department_id": departmentId == null ? null : departmentId,
        "department": department == null ? null : department,
        "city_id": cityId == null ? null : cityId,
        "city": city == null ? null : city,
        "distance": distance == null ? null : distance,
        "created_at": createdAt == null
            ? null
            : "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
      };
}
