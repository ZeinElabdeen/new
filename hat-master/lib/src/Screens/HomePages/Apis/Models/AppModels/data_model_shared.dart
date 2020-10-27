

import 'base_model.dart';

class DataModelShared extends BaseModel{
  String name;
  String email;
  String phone;
  String img;
  int id;

  DataModelShared({this.name, this.email, this.phone, this.img, this.id});

  @override
  BaseModel fromJson(Map<String, dynamic> json) {
    return null;
  }
}
