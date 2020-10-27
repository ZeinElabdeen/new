import 'AppModels/base_model.dart';


import 'AppModels/error_model.dart';

class UserModel extends BaseModel{
  UserModel({
    this.code,
    this.data,
    this.error,
  });

  int code;
  List<User> data;
  List<ApiError> error;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    code: json["code"] == null ? null : json["code"],
    data: json["data"] == null ? null : List<User>.from(json["data"].map((x) => User.fromJson(x))),
    error: json["error"] == null ? null : List<ApiError>.from(json["error"].map((x) => ApiError.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
    "error": error,
  };

  @override
  BaseModel fromJson(Map<String, dynamic> json) {
    return UserModel.fromJson(json);
  }
}

class User {
  User({
    this.id,
    this.name,
    this.email,
    this.phoneNumber,
    this.active,
    this.photo,
    this.apiToken,
    this.createdAt,
  });

  int id;
  String name;
  String email;
  String phoneNumber;
  int active;
  String photo;
  String apiToken;
  DateTime createdAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    email: json["email"] == null ? null : json["email"],
    phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
    active: json["active"] == null ? null : json["active"],
    photo: json["photo"] == null ? null : json["photo"],
    apiToken: json["api_token"] == null ? null : json["api_token"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "email": email,
    "phone_number": phoneNumber == null ? null : phoneNumber,
    "active": active == null ? null : active,
    "photo": photo,
    "api_token": apiToken == null ? null : apiToken,
    "created_at": createdAt == null ? null : "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
  };
}
