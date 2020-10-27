// import 'dart:io';
// import 'package:dio/dio.dart';
// import 'package:haat/src/BloCModels/all_orders_model.dart';
// import 'package:haat/src/BloCModels/car_types_model.dart';
// import 'package:haat/src/BloCModels/cities_model.dart';
// import 'package:haat/src/BloCModels/identity_model.dart';
// import 'package:haat/src/BloCModels/nationalities_model.dart';
// import 'package:haat/src/BloCModels/regions_model.dart';
// import 'package:haat/src/BloCModels/terms_model.dart';
// import 'package:haat/src/BloCModels/user_model.dart';
// import 'package:haat/src/Repository/networkUtlis.dart';


// class ApiProvider {
//   NetworkUtil _utils = new NetworkUtil();

//   Future<bool> registerMobile({String phone}) async {
//     FormData formData = FormData.fromMap({"phone_number": phone});
//     Response response = await _utils
//         .post("driver_register_mobile", body: formData)
//         .catchError((e) {
//       throw e;
//     });
//     if (response.statusCode == 200) {
//       return true;
//     } else {
//       return false;
//     }
//   }

//   Future<bool> confirmCode({String phone, String code}) async {
//     FormData formData = FormData.fromMap({"phone_number": phone, "code": code});
//     Response response = await _utils
//         .post("driver_phone_verification/ar", body: formData)
//         .catchError((e) {
//       throw e;
//     });
//     if (response.statusCode == 200) {
//       return true;
//     } else {
//       return false;
//     }
//   }

//   Future<bool> resendCode({String phone}) async {
//     FormData formData = FormData.fromMap({"phone_number": phone});
//     Response response =
//         await _utils.post("driver_resend_code", body: formData).catchError((e) {
//       throw e;
//     });
//     if (response.statusCode == 200) {
//       return true;
//     } else {
//       return false;
//     }
//   }

//   Future<dynamic> register(
//       {String phone,
//       String name,
//       String email,
//       String password,
//       String confirm,
//       String fcm,
//       cityId,
//       carTypeID,
//       identityTypeID,
//       nationalityID,
//       idNumber,
//       birthDate,
//       jop,
//       File photo}) async {
//     FormData formData = FormData.fromMap({
//       "phone_number": phone,
//       "name": name,
//       "password": password,
//       "password_confirmation": confirm,
//       "device_token": fcm,
//       "email": email,
//       "city_id": cityId,
//       "carType_id": carTypeID,
//       "identityType_id": identityTypeID,
//       "nationality_id": nationalityID,
//       "idNumber": idNumber,
//       "birth_date": birthDate,
//       "job": jop,
//       "status": 0,
//       "photo": await MultipartFile.fromFile(photo.path),
//     });

//     return await _utils
//         .post("driver_register", body: formData, model: UserModel())
//         .catchError((e) {
//       throw e;
//     });
//   }

//   Future<dynamic> login({String phone, String password, String fcm}) async {
//     FormData formData = FormData.fromMap({
//       "phone_number": phone,
//       "password": password,
//       "device_token": fcm,
//     });

//     return await _utils
//         .post("driver_login", body: formData, model: UserModel())
//         .catchError((e) {
//       throw e;
//     });
//   }

//   Future<bool> forgetPassword({String phone}) async {
//     FormData formData = FormData.fromMap({"phone_number": phone});
//     Response response = await _utils
//         .post("driver_forget_password", body: formData)
//         .catchError((e) {
//       throw e;
//     });
//     if (response.statusCode == 200) {
//       return true;
//     } else {
//       return false;
//     }
//   }

//   Future<bool> confirmCodeReset({String phone, String code}) async {
//     FormData formData = FormData.fromMap({"phone_number": phone, "code": code});
//     Response response = await _utils
//         .post("driver_confirm_reset_code", body: formData)
//         .catchError((e) {
//       throw e;
//     });
//     if (response.statusCode == 200) {
//       return true;
//     } else {
//       return false;
//     }
//   }

//   Future<bool> resetPassword(
//       {String phone, String password, String passwordConfirmation}) async {
//     FormData formData = FormData.fromMap({
//       "phone_number": phone,
//       "password": password,
//       "password_confirmation": passwordConfirmation
//     });
//     Response response = await _utils
//         .post("driver_reset_password", body: formData)
//         .catchError((e) {
//       throw e;
//     });
//     if (response.statusCode == 200) {
//       return true;
//     } else {
//       return false;
//     }
//   }

//   Future<dynamic> getTerms() async {
//     return await _utils
//         .get("terms_and_conditions", model: TermsModel())
//         .catchError((e) {
//       throw e;
//     });
//   }

//   Future<dynamic> getAbout() async {
//     return await _utils.get("about_us", model: TermsModel()).catchError((e) {
//       throw e;
//     });
//   }

//   Future<bool> changePhone({String phone}) async {
//     FormData formData = FormData.fromMap({"phone_number": phone});

//     Response response = await _utils
//         .post("driver_change_phone_number", body: formData, withToken: true)
//         .catchError((e) {
//       throw e;
//     });
//     if (response.statusCode == 200) {
//       return true;
//     } else {
//       return false;
//     }
//   }

//   Future<bool> changePhoneCodeCheck({String phone, code}) async {
//     FormData formData = FormData.fromMap({"phone_number": phone, "code": code});

//     Response response = await _utils
//         .post("driver_check_code_change_phone_number",
//             body: formData, withToken: true)
//         .catchError((e) {
//       throw e;
//     });
//     if (response.statusCode == 200) {
//       return true;
//     } else {
//       return false;
//     }
//   }

//   Future<dynamic> changeData(
//       {String name,
//       String email,
//       File img,
//       cityId,
//       carTypeID,
//       identityTypeID,
//       nationalityID,
//       idNumber,
//       birthDate,
//       jop}) async {
//     print('IMG >>> ' + img.path ?? 'null');
//     FormData formData = FormData.fromMap({
//       "name": name,
//       "email": email,
//       img.path == null ? null : "photo": await MultipartFile.fromFile(img.path),
//       "city_id": cityId,
//       "carType_id": carTypeID,
//       "identityType_id": identityTypeID,
//       "nationality_id": nationalityID,
//       "idNumber": idNumber,
//       "birth_date": birthDate,
//       "job": jop,
//     });

//     return await _utils
//         .post("driver_edit_account",
//             body: formData, model: UserModel(), withToken: true)
//         .catchError((e) {
//       throw e;
//     });
//   }

//   Future<bool> changePassword(
//       {String old, String newPass, String confirmNew}) async {
//     FormData formData = FormData.fromMap({
//       "current_password": old,
//       "new_password": newPass,
//       "password_confirmation": confirmNew
//     });

//     Response response = await _utils
//         .post("driver_change_password", body: formData, withToken: true)
//         .catchError((e) {
//       throw e;
//     });
//     if (response.statusCode == 200) {
//       return true;
//     } else {
//       return false;
//     }
//   }

//   Future<dynamic> getRegions() async {
//     return await _utils
//         .get("get_regions/ar", model: RegionsModel())
//         .catchError((e) {
//       throw e;
//     });
//   }

//   Future<dynamic> getCities({String regionID}) async {
//     return await _utils
//         .get("get_cities/$regionID/ar", model: CitiesModel())
//         .catchError((e) {
//       throw e;
//     });
//   }

//   Future<dynamic> getNationalities() async {
//     return await _utils
//         .get("get_nationalities/ar", model: NationalitiesModel())
//         .catchError((e) {
//       throw e;
//     });
//   }

//   Future<dynamic> getCarTypes() async {
//     return await _utils
//         .get("get_car_types/ar", model: CarTypesModel())
//         .catchError((e) {
//       throw e;
//     });
//   }

//   Future<dynamic> getIdentity() async {
//     return await _utils
//         .get("get_identity_types/ar", model: IdentityModel())
//         .catchError((e) {
//       throw e;
//     });
//   }

//   Future<bool> changeAvailable({int available, double lat, double long}) async {
//     FormData formData = FormData.fromMap({
//       "driver_availability": available,
//       "latitude": lat,
//       "longitude": long,
//     });

//     Response response = await _utils
//         .post("driver_availability", body: formData, withToken: true)
//         .catchError((e) {
//       throw e;
//     });
//     if (response.statusCode == 200) {
//       return true;
//     } else {
//       return false;
//     }
//   }

//   Future<dynamic> getOrders({int orderType}) async {
//     FormData formData = FormData.fromMap({"order_type": orderType});

//     return await _utils
//         .post("driver_orders",
//             body: formData, withToken: true, model: AllOrdersModel())
//         .catchError((e) {
//       throw e;
//     });
//   }
// }
