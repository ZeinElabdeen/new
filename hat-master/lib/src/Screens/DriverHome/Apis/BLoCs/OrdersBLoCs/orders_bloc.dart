import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haat/src/Screens/DriverHome/Apis/Models/all_orders_model.dart';
import 'package:rxdart/rxdart.dart';

import 'package:haat/src/Screens/DriverHome/Apis/App/app_event.dart';
import 'package:haat/src/Screens/DriverHome/Apis/App/app_state.dart';
import 'package:haat/src/Screens/DriverHome/Apis/Repository/api_provider.dart';

class OrdersBloc extends Bloc<AppEvent, AppState> {
  final _api = ApiProvider();
  final _orderType = BehaviorSubject<int>();
  final _key = BehaviorSubject<GlobalKey<ScaffoldState>>();

  final _orderID = BehaviorSubject<int>();
  final _reason = BehaviorSubject<String>();
  int _total = 0;

  int get total => _total;

  Function(int) get updateOrderType => _orderType.sink.add;

  Function(GlobalKey<ScaffoldState>) get updateKey => _key.sink.add;

  Function(String) get updateReason => _reason.sink.add;

  Function(int) get updateOrderID => _orderID.sink.add;

  dispose() {
    _key.close();
    _orderType.close();
    _orderID.close();
    _reason.close();
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
      _total = 0;
      print("res 1");

      AllOrdersModel _res =
          await _api.getOrders(orderType: _orderType.value).catchError((e) {
        print(e);

        _key.value.currentState
            .showSnackBar(SnackBar(content: Text('تحقق من الاتصال')));
      });
      print("res 3");
      if (_res.data == null) {
        yield Empty();
      } else {
        if (_res.data.length >= 1) {
          yield Done(model: _res);
          for (int i = 0; i < _res.data.length; i++) {
            _total += _res.data[i].price;
          }
        } else {
          yield Empty();
        }
      }
    }
    if (event is CancelOrder) {
      bool _res = await _api
          .cancelOrder(orderID: _orderID.value, reason: _reason.value)
          .catchError((e) {
        _key.value.currentState
            .showSnackBar(SnackBar(content: Text('تحقق من الاتصال')));
      });
      if (_res) {
        yield OrderCancelled();
      } else {
        _key.value.currentState
            .showSnackBar(SnackBar(content: Text('تحقق من الاتصال')));
      }
    }
  }
}

final ordersBloc = OrdersBloc();
