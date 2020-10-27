import 'base_model.dart';

class DataModelShared extends BaseModel {
  String name;
  String email;
  String phone;
  String img;
  String city;
  String car;
  String nationality;
  String identity;
  String idNumber;
  String birth;
  String jop;
  String region;
  int id;

  DataModelShared(
      {this.name,
      this.id,
      this.email,
      this.phone,
      this.img,
      this.region,
      this.city,
      this.car,
      this.nationality,
      this.identity,
      this.idNumber,
      this.birth,
      this.jop});

  @override
  BaseModel fromJson(Map<String, dynamic> json) {
    return null;
  }
}
