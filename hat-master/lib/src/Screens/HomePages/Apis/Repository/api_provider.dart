import 'dart:io';
import 'package:dio/dio.dart';
import 'package:haat/src/Screens/HomePages/Apis/Models/all_orders_model.dart';
import 'package:haat/src/Screens/HomePages/Apis/Models/categories_model.dart';
import 'package:haat/src/Screens/HomePages/Apis/Models/change_data_model.dart';
import 'package:haat/src/Screens/HomePages/Apis/Models/help_phone_model.dart';
import 'package:haat/src/Screens/HomePages/Apis/Models/history_model.dart';
import 'package:haat/src/Screens/HomePages/Apis/Models/my_chats_model.dart';
import 'package:haat/src/Screens/HomePages/Apis/Models/notification_model.dart';
import 'package:haat/src/Screens/HomePages/Apis/Models/ols_messages_model.dart';
import 'package:haat/src/Screens/HomePages/Apis/Models/palance_model.dart';
import 'package:haat/src/Screens/HomePages/Apis/Models/paument_models.dart';
import 'package:haat/src/Screens/HomePages/Apis/Models/photo_model.dart';
import 'package:haat/src/Screens/HomePages/Apis/Models/price_offers_model.dart';
import 'package:haat/src/Screens/HomePages/Apis/Models/providers_model.dart';
import 'package:haat/src/Screens/HomePages/Apis/Models/slider_model.dart';
import 'package:haat/src/Screens/HomePages/Apis/Models/terms_model.dart';
import 'package:haat/src/Screens/HomePages/Apis/Models/user_model.dart';

import 'network_utlis.dart';

class ApiProvider {
  NetworkUtil _utils = new NetworkUtil();

  Future<dynamic> registerMobile({String phone}) async {
    FormData formData = FormData.fromMap({"phone_number": phone});
    Response response = await _utils
        .post("user_register_mobile", body: formData)
        .catchError((e) {
      throw e;
    });
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<dynamic> confirmCode({String phone, String code}) async {
    FormData formData = FormData.fromMap({"phone_number": phone, "code": code});
    Response response = await _utils
        .post("user_phone_verification/ar", body: formData)
        .catchError((e) {
      throw e;
    });
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<dynamic> resendCode({String phone}) async {
    FormData formData = FormData.fromMap({"phone_number": phone});
    Response response =
        await _utils.post("user_resend_code", body: formData).catchError((e) {
      throw e;
    });
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<dynamic> register(
      {String phone,
      String name,
      String email,
      String password,
      String confirm,
      String fcm}) async {
    FormData formData = FormData.fromMap({
      "phone_number": phone,
      "name": name,
      "password": password,
      "password_confirmation": confirm,
      "device_token": fcm,
      "email": email
    });

    return await _utils
        .post("user_register", body: formData, model: UserModel())
        .catchError((e) {
      throw e;
    });
  }

  Future<dynamic> login({String phone, String password, String fcm}) async {
    FormData formData = FormData.fromMap({
      "phone_number": phone,
      "password": password,
      "device_token": fcm,
    });

    return await _utils.post("user_login", body: formData, model: UserModel())
        .catchError((e) {
      throw e;
    });
  }

  Future<dynamic> forgetPassword({String phone}) async {
    FormData formData = FormData.fromMap({"phone_number": phone});
    Response response = await _utils
        .post("user_forget_password", body: formData)
        .catchError((e) {
      throw e;
    });
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<dynamic> confirmCodeReset({String phone, String code}) async {
    FormData formData = FormData.fromMap({"phone_number": phone, "code": code});
    Response response = await _utils
        .post("user_confirm_reset_code", body: formData)
        .catchError((e) {
      throw e;
    });
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<dynamic> resetPassword(
      {String phone, String password, String passwordConfirmation}) async {
    FormData formData = FormData.fromMap({
      "phone_number": phone,
      "password": password,
      "password_confirmation": passwordConfirmation
    });
    Response response = await _utils
        .post("user_reset_password", body: formData)
        .catchError((e) {
      throw e;
    });
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<dynamic> getTerms() async {
    return await _utils
        .get("terms_and_conditions", model: TermsModel())
        .catchError((e) {
      throw e;
    });
  }

  Future<dynamic> getAbout() async {
    return await _utils.get("about_us", model: TermsModel()).catchError((e) {
      throw e;
    });
  }

  Future<dynamic> changePhone({String phone}) async {
    FormData formData = FormData.fromMap({"phone_number": phone});

    Response response = await _utils
        .post("user_change_phone_number", body: formData, withToken: true)
        .catchError((e) {
      throw e;
    });
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<dynamic> changePhoneCodeCheck({String phone, code}) async {
    FormData formData = FormData.fromMap({"phone_number": phone, "code": code});

    Response response = await _utils
        .post("user_check_code_change_phone_number",
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

  Future<dynamic> changeData({String name, String email, File img}) async {
    FormData formData = FormData.fromMap({
      name == null ? null : "name": name,
      email == null ? null : "email": email,
    });

    if (img != null) {
      formData.files
          .add(MapEntry('photo', await MultipartFile.fromFile(img.path)));
    }
    return await _utils
        .post("user_edit_account",
            body: formData, model: ChangeDataModel(), withToken: true)
        .catchError((e) {
      throw e;
    });
  }

  Future<dynamic> changePassword(
      {String old, String newPass, String confirmNew}) async {
    FormData formData = FormData.fromMap({
      "current_password": old,
      "new_password": newPass,
      "password_confirmation": confirmNew
    });

    Response response = await _utils
        .post("user_change_password", body: formData, withToken: true)
        .catchError((e) {
      throw e;
    });
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<dynamic> getCategories() async {
    return await _utils
        .get("get_departments/ar", model: CategoriesModel())
        .catchError((e) {
      throw e;
    });
  }

  Future<dynamic> getSliders() async {
    return await _utils
        .get("get_splashes/ar", model: SliderModel())
        .catchError((e) {
      throw e;
    });
  }

  Future<dynamic> getProviders({int deptID, double lat, double long}) async {
    FormData formData = FormData.fromMap(
        {"department_id": deptID, "latitude": lat, "longitude": long});

    return await _utils
        .post("providers_filter/ar", model: ProvidersModel(), body: formData)
        .catchError((e) {
      throw e;
    });
  }

  Future<dynamic> createMapOrder(
      {double lat,
      long,
      myLat,
      myLong,
      String name,
      String details,
      address,
      flat,
      File photo}) async {
    FormData formData = FormData.fromMap({
      "order_latitude": lat,
      "order_longitude": long,
      "place_name": name,
      "order_details": details,
      "latitude": myLat,
      "longitude": myLong,
    });

    if (address != null) {
      if (flat != null) {
        formData.fields.add(MapEntry('address_details', address + ' ' + flat));
      } else {
        formData.fields.add(MapEntry('address_details', address));
      }
    } else {
      if (flat != null) {
        formData.fields.add(MapEntry('address_details', flat));
      }
    }

    if (photo != null) {
      formData.files
          .add(MapEntry("photo", await MultipartFile.fromFile(photo.path)));
    }

    return await _utils
        .post("create_order/0",
            body: formData, withToken: true, model: AllOrdersModel())
        .catchError((e) {
      throw e;
    });
  }

  Future<dynamic> createDeliveryOrder(
      {double myLat,
      myLong,
      String name,
      String details,
      int providerID,
      address,
      flat,
      File photo}) async {
    FormData formData = FormData.fromMap({
      "provider_id": providerID,
      "place_name": name,
      "order_details": details,
      "latitude": myLat,
      "longitude": myLong,
    });

    if (address != null) {
      if (flat != null) {
        formData.fields.add(MapEntry('address_details', address + ' ' + flat));
      } else {
        formData.fields.add(MapEntry('address_details', address));
      }
    } else {
      if (flat != null) {
        formData.fields.add(MapEntry('address_details', flat));
      }
    }

    if (photo != null) {
      formData.files
          .add(MapEntry("photo", await MultipartFile.fromFile(photo.path)));
    }

    return await _utils
        .post("create_order/2",
            body: formData, withToken: true, model: AllOrdersModel())
        .catchError((e) {
      throw e;
    });
  }

  Future<dynamic> getOrders({int orderType}) async {
    print("get orders hhhhh");
    FormData formData = FormData.fromMap({"order_type": orderType});

    return await _utils.post("client-orders",
            body: formData, withToken: true, model: AllOrdersModel())
        .catchError((e) {
      throw e;
    });
  }

  Future<dynamic> getOffers({int orderID}) async {
    return await _utils
        .get("offers/$orderID", withToken: true, model: PriceOffersModel())
        .catchError((e) {
      throw e;
    });
  }

  Future<dynamic> getOrder({int orderID}) async {
    return await _utils
        .get("get_order_by_id/$orderID",
            withToken: true, model: AllOrdersModel())
        .catchError((e) {
      throw e;
    });
  }

  Future<dynamic> acceptOffer({int offerID}) async {
    Response _res = await _utils
        .post("accept-offer/$offerID", withToken: true)
        .catchError((e) {
      throw e;
    });

    if (_res.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<dynamic> finishOrder({int orderID}) async {
    Response _res = await _utils
        .post("finish-order/$orderID", withToken: true)
        .catchError((e) {
      throw e;
    });
    if (_res.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<dynamic> cancelOrder({int orderID, String reason}) async {
    FormData formData = FormData.fromMap({"cancel_reason_client": reason});

    Response _res = await _utils
        .post("client-cancel-order/$orderID", body: formData, withToken: true)
        .catchError((e) {
      throw e;
    });
    if (_res.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<dynamic> rateDriver(
      {int orderID, driverID, rate, String rateText}) async {
    FormData formData = FormData.fromMap({
      "driver_id": driverID,
      "order_id": orderID,
      "rate": rate,
    });

    if (rateText != null) {
      formData.fields.add(MapEntry("rate_service", rateText));
    }
    Response _res = await _utils
        .post("client-rate", withToken: true, body: formData)
        .catchError((e) {
      throw e;
    });
    if (_res.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<dynamic> helpCenter({String title, content}) async {
    FormData formData = FormData.fromMap({"title": title, "details": content});

    Response _res = await _utils
        .post("complaint", withToken: true, body: formData)
        .catchError((e) {
      throw e;
    });
    if (_res.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<dynamic> getMessages({int chatID}) async {
    return await _utils
        .get("get-chats/$chatID",
            withToken: true, model: OldMessagesModel())
        .catchError((e) {
      throw e;
    });
  }

  Future<dynamic> getChats() async {
    return await _utils
        .get("get-all-chats", withToken: true, model: MyChatsModel())
        .catchError((e) {
      throw e;
    });
  }

  Future<dynamic> getNotification() async {
    return await _utils.get("list-notifications",
        model: NotificationModel(), withToken: true);
  }

  Future<dynamic> deleteNotification({int notificationID}) async {
    Response _res = await _utils.post("delete-notification/$notificationID",
        withToken: true, body: FormData());
    if (_res.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<dynamic> paymentWallet({String cash}) async {
    FormData formData = FormData.fromMap({"cash": cash});

    return await _utils.post("charge-electronic-pocket",
        withToken: true, body: formData, model: PaymentModel());
  }

  Future<dynamic> uploadPhoto({File photo}) async {
    FormData formData =
        FormData.fromMap({"photo": await MultipartFile.fromFile(photo.path)});

    return await _utils.post("upload-photo",
        withToken: false, body: formData, model: PhotoModel());
  }

  Future<dynamic> getVoiceRing() async {
    return await _utils.get("get-chat-voice",
        withToken: false, model: PhotoModel());
  }

  Future<dynamic> getHelpPhone() async {
    return await _utils.get("get_help_center_phone",
        withToken: false, model: HelpPhoneModel());
  }

  Future<dynamic> getBalance() async {
    return await _utils.get("my-balance-in-wallet",
        withToken: true, model: BalanceModel());
  }

  Future<dynamic> getHistory() async {
    return await _utils.get("my-history",
        withToken: true, model: HistoryModel());
  }
}
