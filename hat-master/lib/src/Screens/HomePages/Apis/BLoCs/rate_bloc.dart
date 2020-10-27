import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haat/src/Screens/HomePages/Apis/App/app_event.dart';
import 'package:haat/src/Screens/HomePages/Apis/App/app_state.dart';
import 'package:haat/src/Screens/HomePages/Apis/Repository/api_provider.dart';
import 'package:rxdart/rxdart.dart';

class RateBloc extends Bloc<AppEvent, AppState> {
  final _api = ApiProvider();
  final _orderID = BehaviorSubject<int>();
  final _driverID = BehaviorSubject<int>();
  final _rate = BehaviorSubject<int>();
  final _rateText = BehaviorSubject<String>();
  final _key = BehaviorSubject<GlobalKey<ScaffoldState>>();

  Function(int) get updateOrderID => _orderID.sink.add;

  Function(int) get updateDriverID => _driverID.sink.add;

  Function(int) get updateRate => _rate.sink.add;

  Function(String) get updateRateText => _rateText.sink.add;

  Function(GlobalKey<ScaffoldState>) get updateKey => _key.sink.add;

  dispose() {
    _key.close();
    _orderID.close();
    _driverID.close();
    _rateText.close();
    _rate.close();
  }

  @override
  AppState get initialState => Start();

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    yield Loading();
    if (event is Click) {
      bool _res = await _api
          .rateDriver(
              driverID: _driverID.value,
              orderID: _orderID.value,
              rate: _rate.value,
              rateText: _rateText.value)
          .catchError((e) {
        _key.value.currentState
            .showSnackBar(SnackBar(content: Text('تحقق من الاتصال')));
      });
      if (_res) {
        yield Done();
      } else {
        _key.value.currentState
            .showSnackBar(SnackBar(content: Text('تحقق من الاتصال')));
        yield Error();
      }
    }
  }
}

final rateBloc = RateBloc();
