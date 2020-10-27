import 'dart:io';
import 'package:haat/src/Screens/DriverHome/Apis//Models/help_phone_model.dart';
import 'package:haat/src/Screens/DriverHome/Apis//Models/history_model.dart';
import 'package:haat/src/Screens/DriverHome/Apis//Models/my_chats_model.dart';
import 'package:haat/src/Screens/DriverHome/Apis//Models/nationalities_model.dart';
import 'package:haat/src/Screens/DriverHome/Apis//Models/notification_model.dart';
import 'package:haat/src/Screens/DriverHome/Apis//Models/old_messages_model.dart';
// import 'package:haat/src/Screens/DriverHome/Apis//Models/palance_model.dart';
// import 'package:haat/src/Screens/DriverHome/Apis//Models/paument_models.dart';
import 'package:haat/src/Screens/DriverHome/Apis//Models/photo_model.dart';
import 'package:dio/dio.dart';
import 'package:haat/src/Screens/DriverHome/Apis/Models/all_orders_model.dart';
import 'package:haat/src/Screens/DriverHome/Apis/Models/palance_model.dart';
import 'package:haat/src/Screens/DriverHome/Apis/Models/paument_models.dart';

import 'network_utlis.dart';

class ApiProvider {
  NetworkUtil _utils = new NetworkUtil();

  Future<bool> registerMobile({String phone, int type}) async {
    FormData formData = FormData.fromMap({"phone_number": phone});
    Response response = await _utils
        .post("driver_register_mobile/$type/ar", body: formData)
        .catchError((e) {
      throw e;
    });
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> confirmCode({String phone, String code, int type}) async {
    FormData formData = FormData.fromMap({"phone_number": phone, "code": code});
    Response response = await _utils
        .post("driver_phone_verification//$type/ar", body: formData)
        .catchError((e) {
      throw e;
    });
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> resendCode({String phone, int type}) async {
    FormData formData = FormData.fromMap({"phone_number": phone});
    Response response = await _utils
        .post("driver_resend_code/$type/ar", body: formData)
        .catchError((e) {
      throw e;
    });
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<dynamic> rateClient(
      {int orderID, driverID, rate, String rateText}) async {
    FormData formData = FormData.fromMap({
      "user_id": driverID,
      "order_id": orderID,
      "rate": rate,
    });

    if (rateText != null) {
      formData.fields.add(MapEntry("rate_service", rateText));
    }
    Response _res = await _utils
        .post("driver-rate", withToken: true, body: formData)
        .catchError((e) {
      throw e;
    });
    if (_res.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
  // Future<dynamic> register(
  //     {String phone,
  //     String name,
  //     String email,
  //     String password,
  //     String confirm,
  //     String fcm,
  //     cityId,
  //     carTypeID,
  //     identityTypeID,
  //     nationalityID,
  //     idNumber,
  //     birthDate,
  //     jop,
  //     File photo,
  //     int type}) async {
  //   FormData formData = FormData.fromMap({
  //     "phone_number": phone,
  //     "name": name,
  //     "password": password,
  //     "password_confirmation": confirm,
  //     "device_token": fcm,
  //     "email": email,
  //     "city_id": cityId,
  //     "carType_id": carTypeID,
  //     "identityType_id": identityTypeID,
  //     "nationality_id": nationalityID,
  //     "idNumber": idNumber,
  //     "birth_date": birthDate,
  //     "job": jop,
  //     "status": 0,
  //     "photo": await MultipartFile.fromFile(photo.path),
  //   });

  //   return await _utils
  //       .post("driver_register/$type/ar", body: formData, model: UserModel())
  //       .catchError((e) {
  //     throw e;
  //   });
  // }

  // Future<dynamic> login(
  //     {String phone, String password, String fcm, int type}) async {
  //   FormData formData = FormData.fromMap({
  //     "phone_number": phone,
  //     "password": password,
  //     "device_token": fcm,
  //   });

  //   return await _utils
  //       .post("driver_login/$type/ar", body: formData, model: UserModel())
  //       .catchError((e) {
  //     throw e;
  //   });
  // }

  Future<bool> forgetPassword({String phone, int type}) async {
    FormData formData = FormData.fromMap({"phone_number": phone});
    Response response = await _utils
        .post("driver_forget_password/$type/ar", body: formData)
        .catchError((e) {
      throw e;
    });
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> confirmCodeReset({String phone, String code, int type}) async {
    FormData formData = FormData.fromMap({"phone_number": phone, "code": code});
    Response response = await _utils
        .post("driver_confirm_reset_code/$type/ar", body: formData)
        .catchError((e) {
      throw e;
    });
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> resetPassword(
      {String phone,
      String password,
      String passwordConfirmation,
      int type}) async {
    FormData formData = FormData.fromMap({
      "phone_number": phone,
      "password": password,
      "password_confirmation": passwordConfirmation
    });
    Response response = await _utils
        .post("driver_reset_password/$type/ar", body: formData)
        .catchError((e) {
      throw e;
    });
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  // Future<dynamic> getTerms() async {
  //   return await _utils
  //       .get("terms_and_conditions/ar", model: TermsModel())
  //       .catchError((e) {
  //     throw e;
  //   });
  // }

  // Future<dynamic> getAbout() async {
  //   return await _utils.get("about_us/ar", model: TermsModel()).catchError((e) {
  //     throw e;
  //   });
  // }

  Future<bool> changePhone({String phone, int type}) async {
    FormData formData = FormData.fromMap({"phone_number": phone});

    Response response = await _utils
        .post("driver_change_phone_number/$type/ar",
            body: formData, withToken: true)
        .catchError((e) {
      throw e;
    });
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> changePhoneCodeCheck({String phone, code, int type}) async {
    FormData formData = FormData.fromMap({"phone_number": phone, "code": code});

    Response response = await _utils
        .post("driver_check_code_change_phone_number/$type/ar",
            body: formData, withToken: true)
        .catchError((e) {
      throw e;
    });
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  // Future<dynamic> changeData(
  //     {String name,
  //     String email,
  //     File img,
  //     cityId,
  //     carTypeID,
  //     identityTypeID,
  //     nationalityID,
  //     idNumber,
  //     birthDate,
  //     jop,
  //     int type}) async {
  //   FormData formData = FormData.fromMap({
  //     "name": name,
  //     "email": email,
  //     "city_id": cityId,
  //     "carType_id": carTypeID,
  //     "identityType_id": identityTypeID,
  //     "nationality_id": nationalityID,
  //     "idNumber": idNumber,
  //     "birth_date": birthDate,
  //     "job": jop,
  //   });

  //   if (img != null) {
  //     formData.files
  //         .add(MapEntry('photo', await MultipartFile.fromFile(img.path)));
  //   }

  //   return await _utils
  //       .post("driver_edit_account/$type/ar",
  //           body: formData, model: UserModel(), withToken: true)
  //       .catchError((e) {
  //     throw e;
  //   });
  // }

  Future<bool> changePassword(
      {String old, String newPass, String confirmNew, int type}) async {
    FormData formData = FormData.fromMap({
      "current_password": old,
      "new_password": newPass,
      "password_confirmation": confirmNew
    });

    Response response = await _utils
        .post("driver_change_password/$type/ar",
            body: formData, withToken: true)
        .catchError((e) {
      throw e;
    });
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  // Future<dynamic> getRegions() async {
  //   return await _utils
  //       .get("get_regions/ar", model: RegionsModel())
  //       .catchError((e) {
  //     throw e;
  //   });
  // }

  // Future<dynamic> getCities({String regionID}) async {
  //   return await _utils
  //       .get("get_cities/$regionID/ar", model: CitiesModel())
  //       .catchError((e) {
  //     throw e;
  //   });
  // }

  Future<dynamic> getNationalities() async {
    return await _utils
        .get("get_nationalities/ar", model: NationalitiesModel())
        .catchError((e) {
      throw e;
    });
  }

  // Future<dynamic> getCarTypes() async {
  //   return await _utils
  //       .get("get_car_types/ar", model: CarTypesModel())
  //       .catchError((e) {
  //     throw e;
  //   });
  // }

  // Future<dynamic> getIdentity() async {
  //   return await _utils
  //       .get("get_identity_types/ar", model: IdentityModel())
  //       .catchError((e) {
  //     throw e;
  //   });
  // }

  Future<bool> changeAvailable({int available, double lat, double long}) async {
    FormData formData = FormData.fromMap({
      "availability": available,
      "latitude": lat,
      "longitude": long,
    });

    Response response = await _utils
        .post("availability", body: formData, withToken: true)
        .catchError((e) {
      throw e;
    });
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  // Future<dynamic> getActive() async {
  //   return await _utils
  //       .post("driver_activity",
  //           model: DriverActiveModel(), withToken: true, body: FormData())
  //       .catchError((e) {
  //     throw e;
  //   });
  // }

  Future<dynamic> getOrders({int orderType}) async {
    FormData formData = FormData.fromMap({"order_type": orderType});
    print("data");
    return await _utils
        .post("driver-orders",
            body: formData, withToken: true, model: AllOrdersModel())
        .catchError((e) {
      throw e;
    });
  }

  Future<dynamic> cancelOrder({int orderID, String reason}) async {
    FormData formData = FormData.fromMap({"cancel_reason_driver": reason});

    Response _res = await _utils
        .post("driver-cancel-order/$orderID", body: formData, withToken: true)
        .catchError((e) {
      throw e;
    });
    if (_res.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> sendOffer({int price, String details, int orderID}) async {
    FormData formData = FormData.fromMap({
      "price": price,
    });

    if (details != null) {
      formData.fields.add(MapEntry('offer_details', details));
    }

    Response response = await _utils
        .post("offer-price/$orderID", body: formData, withToken: true)
        .catchError((e) {
      throw e;
    });
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<dynamic> helpCenter({String title, content}) async {
    FormData formData = FormData.fromMap({"title": title, "details": content});

    Response _res = await _utils
        .post("user_make_complaint", withToken: true, body: formData)
        .catchError((e) {
      throw e;
    });
    if (_res.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<dynamic> getNotification() async {
    return await _utils.get("list_notifications/ar",
        model: NotificationModel(), withToken: true);
  }

  Future<dynamic> deleteNotification({int notificationID}) async {
    Response _res = await _utils.post("delete_Notifications/$notificationID",
        withToken: true, body: FormData());
    if (_res.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<dynamic> paymentWallet({int cash}) async {
    FormData formData = FormData.fromMap({"cash": cash});

    return await _utils.post("charge-electronic-pocket",
        withToken: true, body: formData, model: PaymentModel());
  }

  Future<dynamic> uploadPhoto({File photo}) async {
    FormData formData =
        FormData.fromMap({"photo": await MultipartFile.fromFile(photo.path)});

    return await _utils.post("upload_photo",
        withToken: false, body: formData, model: PhotoModel());
  }

  Future<dynamic> getVoiceRing() async {
    return await _utils.get("get_chat_voice",
        withToken: false, model: PhotoModel());
  }

  Future<dynamic> getBalance() async {
    return await _utils.get("my-balance-in-wallet",
        withToken: true, model: BalanceModel());
  }

  Future<dynamic> getHistory() async {
    return await _utils.get("My_History",
        withToken: true, model: HistoryModel());
  }

  Future<dynamic> getMessages({int chatID}) async {
    return await _utils
        .get("get_chat_messages/$chatID",
            withToken: true, model: OldMessagesModel())
        .catchError((e) {
      throw e;
    });
  }

  Future<dynamic> getChats() async {
    return await _utils
        .get("my_chats/", withToken: true, model: MyChatsModel())
        .catchError((e) {
      throw e;
    });
  }

  Future<dynamic> getHelpPhone() async {
    return await _utils.get("get_help_center_phone",
        withToken: false, model: HelpPhoneModel());
  }

  Future<dynamic> sendBill({String price, File photo, int orderID}) async {
    FormData formData = FormData.fromMap({
      "bill_photo": await MultipartFile.fromFile(photo.path),
      "order_price": price
    });
    Response _res = await _utils
        .post("send-price-bill/$orderID",
            body: formData, withToken: true)
        .catchError((e) {
      throw e;
    });

    if (_res.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<dynamic> requestBalance() async {
    Response _res =
        await _utils.get("my-balance-withdrawal-request", withToken: true);

    if (_res.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
