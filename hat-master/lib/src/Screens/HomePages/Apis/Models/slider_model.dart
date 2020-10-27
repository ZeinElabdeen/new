import 'dart:convert';
import 'AppModels/base_model.dart';


SliderModel sliderModelFromJson(String str) =>
    SliderModel.fromJson(json.decode(str));

String sliderModelToJson(SliderModel data) => json.encode(data.toJson());

class SliderModel extends BaseModel {
  SliderModel({
    this.code,
    this.data,
  });

  int code;
  List<Slider> data;

  factory SliderModel.fromJson(Map<String, dynamic> json) => SliderModel(
        code: json["code"] == null ? null : json["code"],
        data: json["data"] == null
            ? null
            : List<Slider>.from(json["data"].map((x) => Slider.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
      };

  @override
  BaseModel fromJson(Map<String, dynamic> json) {
    return SliderModel.fromJson(json);
  }
}

class Slider {
  Slider({
    this.id,
    this.photo,
    this.departmentId,
    this.department,
    this.url,
    this.createdAt,
  });

  int id;
  String photo;
  int departmentId;
  String department;
  String url;
  DateTime createdAt;

  factory Slider.fromJson(Map<String, dynamic> json) => Slider(
        id: json["id"] == null ? null : json["id"],
        photo: json["photo"] == null ? null : json["photo"],
        departmentId:
            json["department_id"] == null ? null : json["department_id"],
        department: json["department"] == null ? null : json["department"],
        url: json["url"] == null ? null : json["url"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "photo": photo == null ? null : photo,
        "department_id": departmentId == null ? null : departmentId,
        "department": department == null ? null : department,
        "url": url == null ? null : url,
        "created_at": createdAt == null
            ? null
            : "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
      };
}
