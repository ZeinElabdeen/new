import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:haat/src/Models/get/notification.dart';
import 'package:haat/src/Repository/appLocalization.dart';
import 'package:haat/src/Repository/networkUtlisGenral.dart';

// import 'package:haat/src/Repository/networkUtlis.dart';

class NotoficationProvider with ChangeNotifier {
  List<Notification> _notifications = [];

  List<Notification> get notfications {
    return [..._notifications];
  }

  NetworkUtil _utils = new NetworkUtil();
  NotificationModel notificationModel;
  bool error = false;
  void removeItem(int productId) {
    _notifications.removeAt(productId);
    print(_notifications.length);
    notifyListeners();
  }

  Future<NotificationModel> getNotification(String token) async {
    final List<Notification> loadedNotifications = [];
    Map<String, String> headers = {
      "X-localization": localization.currentLanguage.toString(),
      "Authorization": "Bearer $token"
    };
    Response response =
        await _utils.get("list_notifications", headers: headers);
    if (response.statusCode == 200) {
      print("get notification data sucsseful");
      notificationModel = NotificationModel.fromJson(response.data);
      notificationModel.data.forEach((element) {
        loadedNotifications.add(Notification(
            id: element.id,
            arMessage: element.arMessage,
            arTitle: element.arTitle,
            createdAt: element.createdAt,
            type: element.type,
            userId: element.userId));
      });
      _notifications = loadedNotifications.reversed.toList();
      error = false;
      notifyListeners();
      return NotificationModel.fromJson(response.data);
    } else {
      print("error get notification data");
      return NotificationModel.fromJson(response.data);
    }
  }
}

class Notification {
  Notification({
    @required this.id,
    @required this.type,
    @required this.arTitle,
    @required this.arMessage,
    @required this.userId,
    @required this.createdAt,
  });

  int id;
  int type;
  String arTitle;
  String arMessage;
  int userId;
  DateTime createdAt;
}
