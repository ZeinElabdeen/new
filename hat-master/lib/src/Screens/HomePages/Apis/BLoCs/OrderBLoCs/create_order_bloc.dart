import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:haat/src/Screens/HomePages/Apis/App/app_event.dart';
import 'package:haat/src/Screens/HomePages/Apis/App/app_state.dart';
import 'package:haat/src/Screens/HomePages/Apis/Models/all_orders_model.dart';
import 'package:haat/src/Screens/HomePages/Apis/Repository/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class CreateOrderBloc extends Bloc<AppEvent, AppState> {
  final _api = ApiProvider();
  final _lat = BehaviorSubject<double>();
  final _long = BehaviorSubject<double>();
  final _myLat = BehaviorSubject<double>();
  final _myLong = BehaviorSubject<double>();
  final _placeName = BehaviorSubject<String>();
  final _orderDetails = BehaviorSubject<String>();
  final _addressDetails = BehaviorSubject<String>();
  final _flat = BehaviorSubject<String>();
  final _photo = BehaviorSubject<File>();
  final _providerID = BehaviorSubject<int>();
  final _key = BehaviorSubject<GlobalKey<ScaffoldState>>();

  Function(double) get updateLat => _lat.sink.add;

  Function(double) get updateLong => _long.sink.add;

  Function(double) get updateMyLat => _myLat.sink.add;

  Function(double) get updateMyLong => _myLong.sink.add;

  Function(String) get updatePlaceName => _placeName.sink.add;

  Function(String) get updateOrderDetails => _orderDetails.sink.add;

  Function(String) get updateAddress => _addressDetails.sink.add;

  Function(String) get updateFlat => _flat.sink.add;

  Function(File) get updatePhoto => _photo.sink.add;

  Function(int) get updateProviderID => _providerID.sink.add;

  Function(GlobalKey<ScaffoldState>) get updateKey => _key.sink.add;

  dispose() {
    _key.close();
    _lat.close();
    _long.close();
    _myLat.close();
    _providerID.close();
    _myLong.close();
    _placeName.close();
    _orderDetails.close();
    _addressDetails.close();
    _flat.close();
    _placeName.close();
    _flat.close();
    _photo.close();
  }

  clear() {
    _long.value = null;
    _lat.value = null;
    _photo.value = null;
    _addressDetails.value = null;
    _flat.value = null;
    _myLat.value = null;
    _myLong.value = null;
    _orderDetails.value = null;
    _providerID.value = null;
    _placeName.value = null;
  }

  @override
  AppState get initialState => Start();

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    yield Loading();
    if (event is CreateMapOrder) {
      if (_placeName.value == null) {
        yield PlaceError();
      } else if (_orderDetails.value == null) {
        yield OrderDetailsError();
      } else {
        AllOrdersModel _res = await _api
            .createMapOrder(
                long: _long.value,
                lat: _lat.value,
                flat: _flat.value,
                photo: _photo.value,
                address: _addressDetails.value,
                myLat: _myLat.value,
                myLong: _myLong.value,
                details: _orderDetails.value,
                name: _placeName.value)
            .catchError((e) {
          _key.value.currentState
              .showSnackBar(SnackBar(content: Text('تحقق من الإتصال')));
        });
        if (_res.code == 200) {
          yield Done(model: _res);
          clear();
        } else {
          _key.value.currentState
              .showSnackBar(SnackBar(content: Text(_res.error[0].value)));
          yield Start();
        }
      }
    }
    if (event is CreateDeliveryOrder) {
      if (_orderDetails.value == null) {
        yield OrderDetailsError();
      } else {
        AllOrdersModel _res = await _api
            .createDeliveryOrder(
                myLat: _myLat.value,
                flat: _flat.value,
                address: _addressDetails.value,
                myLong: _myLong.value,
                photo: _photo.value,
                providerID: _providerID.value,
                details: _orderDetails.value,
                name: _placeName.value)
            .catchError((e) {
          _key.value.currentState
              .showSnackBar(SnackBar(content: Text('تحقق من الإتصال')));
        });
        if (_res.code == 200) {
          yield Done(model: _res);
          clear();
        } else {
          _key.value.currentState
              .showSnackBar(SnackBar(content: Text(_res.error[0].value)));
          yield Start();
        }
      }
    }
  }
}

final createOrderBloc = CreateOrderBloc();
