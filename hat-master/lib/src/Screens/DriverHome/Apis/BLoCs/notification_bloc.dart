import 'package:bloc/bloc.dart';

import 'package:haat/src/Screens/DriverHome/Apis/App/app_event.dart';
import 'package:haat/src/Screens/DriverHome/Apis/App/app_state.dart';
import 'package:haat/src/Screens/DriverHome/Apis/Models/notification_model.dart';
import 'package:haat/src/Screens/DriverHome/Apis/Repository/api_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class NotificationsBloc extends Bloc<AppEvent, AppState> {
  final _api = ApiProvider();
  final _notificationID = BehaviorSubject<int>();
  final _key = BehaviorSubject<GlobalKey<ScaffoldState>>();

  Function(int) get updateNotificationID => _notificationID.sink.add;

  Function(GlobalKey<ScaffoldState>) get updateKey => _key.sink.add;

  dispose() {
    _key.close();
    _notificationID.close();
  }

  @override
  AppState get initialState => Start();

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    yield Loading();
    if (event is Restart) {
      yield Start();
    }
    if (event is Click) {
      NotificationModel _res = await _api.getNotification().catchError((e) {
        _key.value.currentState
            .showSnackBar(SnackBar(content: Text('تحقق من الاتصال')));
      });
      if (_res.data == null) {
        yield Empty();
      } else {
        yield Done(model: _res);
      }
    }
    if (event is Delete) {
      bool _res = await _api
          .deleteNotification(notificationID: _notificationID.value)
          .catchError((e) {
        _key.value.currentState
            .showSnackBar(SnackBar(content: Text('تحقق من الاتصال')));
      });
      if (_res) {
        _key.value.currentState
            .showSnackBar(SnackBar(content: Text('تم حذف الإشعار')));
        notificationsBloc.add(Click());
      } else {
        _key.value.currentState
            .showSnackBar(SnackBar(content: Text('تحقق من الاتصال')));
      }
    }
  }
}

final notificationsBloc = NotificationsBloc();
