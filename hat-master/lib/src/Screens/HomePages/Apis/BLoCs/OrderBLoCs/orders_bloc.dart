import 'package:bloc/bloc.dart';
import 'package:haat/src/Screens/HomePages/Apis/App/app_event.dart';
import 'package:haat/src/Screens/HomePages/Apis/App/app_state.dart';
import 'package:haat/src/Screens/HomePages/Apis/Models/all_orders_model.dart';
import 'package:haat/src/Screens/HomePages/Apis/Repository/api_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class OrdersBloc extends Bloc<AppEvent, AppState> {
  final _api = ApiProvider();
  final _orderType = BehaviorSubject<int>();
  final _orderID = BehaviorSubject<int>();
  final _key = BehaviorSubject<GlobalKey<ScaffoldState>>();
  int _total = 0;

  int get total => _total;

  Function(int) get updateOrderType => _orderType.sink.add;

  Function(int) get updateOrderID => _orderID.sink.add;

  Function(GlobalKey<ScaffoldState>) get updateKey => _key.sink.add;

  dispose() {
    _key.close();
    _orderType.close();
    _orderID.close();
  }

  @override
  AppState get initialState => Start();

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    yield Loading();
    if (event is Click) {
      _total = 0;
      AllOrdersModel _res =
          await _api.getOrders(orderType: _orderType.value).catchError((e) {
        print("error $e");

        _key.value.currentState
            .showSnackBar(SnackBar(content: Text('تحقق من الاتصال')));
      });
      if (_res.data == null) {
        yield Empty();
      } else {
        if (_res.data.length >= 1) {
          yield Done(model: _res);
          for (int i = 0; i < _res.data.length; i++) {
            _total += _res.data[i].price + _res.data[i].orderPrice;
          }
        } else {
          yield Empty();
        }
      }
    }

    if (event is GetOrder) {
      AllOrdersModel _res =
          await _api.getOrder(orderID: _orderID.value).catchError((e) {
        print("error $e");

        _key.value.currentState
            .showSnackBar(SnackBar(content: Text('تحقق من الاتصال')));
      });
      if (_res.data == null) {
        yield Empty();
      } else {
        if (_res.data.length >= 1) {
          yield Done(model: _res);
          for (int i = 0; i < _res.data.length; i++) {
            _total += _res.data[i].price + _res.data[i].orderPrice;
          }
        } else {
          yield Empty();
        }
      }
    }

    if (event is Finish) {
      var _res =
          await _api.finishOrder(orderID: _orderID.value).catchError((e) {
        print("error $e");
        _key.value.currentState
            .showSnackBar(SnackBar(content: Text('تحقق من الاتصال')));
      });
      if (_res) {
        yield OrderFinished();
      } else {
        _key.value.currentState
            .showSnackBar(SnackBar(content: Text('تحقق من الاتصال')));
      }
    }
  }
}

final ordersBloc = OrdersBloc();
