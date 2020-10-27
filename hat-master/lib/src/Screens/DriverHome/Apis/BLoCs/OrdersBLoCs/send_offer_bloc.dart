import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:haat/src/Screens/DriverHome/Apis/App/app_event.dart';
import 'package:haat/src/Screens/DriverHome/Apis/App/app_state.dart';
import 'package:haat/src/Screens/DriverHome/Apis/BLoCs/chat_bloc.dart';
import 'package:haat/src/Screens/DriverHome/Apis/Repository/api_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class SendOfferBloc extends Bloc<AppEvent, AppState> {
  final _api = ApiProvider();
  final _orderID = BehaviorSubject<int>();
  final _price = BehaviorSubject<int>();
  final _details = BehaviorSubject<String>();
  final _bill = BehaviorSubject<String>();
  final _billImg = BehaviorSubject<File>();
  final _key = BehaviorSubject<GlobalKey<ScaffoldState>>();

  Function(int) get updateOrderID => _orderID.sink.add;

  Function(int) get updatePrice => _price.sink.add;

  Function(String) get updateDetails => _details.sink.add;

  Function(String) get updateBill => _bill.sink.add;

  Function(File) get updateBillImg => _billImg.sink.add;

  Function(GlobalKey<ScaffoldState>) get updateKey => _key.sink.add;

  dispose() {
    _key.close();
    _price.close();
    _details.close();
    _orderID.close();
    _bill.close();
    _billImg.close();
  }

  _clear() {
    _key.value = null;
    _price.value = null;
    _details.value = null;
    _orderID.value = null;
    _bill.value = null;
    _billImg.value = null;
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
      if (_price.value == null) {
        yield PriceError();
      } else {
        bool _res = await _api
            .sendOffer(
                orderID: _orderID.value,
                details: _details.value,
                price: _price.value)
            .catchError((e) {
          sendOfferBloc.add(Restart());
          _key.value.currentState
              .showSnackBar(SnackBar(content: Text('تحقق من الاتصال')));
        });
        if (_res) {
          yield Done();
          _clear();
        } else {
          yield Error();
          _key.value.currentState
              .showSnackBar(SnackBar(content: Text('تحقق من الاتصال')));
        }
      }
    }
    if (event is Bill) {
      if (_bill.value == null) {
        yield BillError();
      } else if (_billImg.value == null) {
        yield BillImgError();
      } else {
        bool _res = await _api
            .sendBill(
                orderID: _orderID.value,
                photo: _billImg.value,
                price: _bill.value)
            .catchError((e) {
          sendOfferBloc.add(Restart());
          _key.value.currentState
              .showSnackBar(SnackBar(content: Text('تحقق من الاتصال')));
        });
        if (_res) {
          yield BillSent();
          chatBloc.updatePhoto(_billImg.value);
          chatBloc.add(UploadPhoto());
          chatBloc.updateMsg(_bill.value);
          Timer(Duration(seconds: 2), () => chatBloc.add(SendMsg()));
          _clear();
        } else {
          yield Error();
          _key.value.currentState
              .showSnackBar(SnackBar(content: Text('تحقق من الاتصال')));
        }
      }
    }
  }
}

final sendOfferBloc = SendOfferBloc();
