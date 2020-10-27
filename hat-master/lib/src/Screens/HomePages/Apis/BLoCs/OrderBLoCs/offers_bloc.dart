import 'package:bloc/bloc.dart';
import 'package:haat/src/Screens/HomePages/Apis/App/app_event.dart';
import 'package:haat/src/Screens/HomePages/Apis/App/app_state.dart';
import 'package:haat/src/Screens/HomePages/Apis/Models/price_offers_model.dart';
import 'package:haat/src/Screens/HomePages/Apis/Repository/api_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class OffersBloc extends Bloc<AppEvent, AppState> {
  final _api = ApiProvider();
  final _orderID = BehaviorSubject<int>();
  final _offerID = BehaviorSubject<int>();
  final _reason = BehaviorSubject<String>();
  final _key = BehaviorSubject<GlobalKey<ScaffoldState>>();

  Function(int) get updateOfferID => _offerID.sink.add;

  Function(String) get updateReason => _reason.sink.add;

  Function(int) get updateOrderID => _orderID.sink.add;

  Function(GlobalKey<ScaffoldState>) get updateKey => _key.sink.add;

  dispose() {
    _key.close();
    _orderID.close();
    _offerID.close();
    _reason.close();
  }

  @override
  AppState get initialState => Start();

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    yield Loading();
    if (event is Click) {
      PriceOffersModel _res =
          await _api.getOffers(orderID: _orderID.value).catchError((e) {
        _key.value.currentState
            .showSnackBar(SnackBar(content: Text('تحقق من الاتصال')));
      });
      if (_res.data == null) {
        yield Loading();
      } else {
        if (_res.data.length >= 1) {
          yield Done(model: _res);
        } else {
          yield Loading();
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
    if (event is AcceptOffer) {
      bool _res =
          await _api.acceptOffer(offerID: _offerID.value).catchError((e) {
        _key.value.currentState
            .showSnackBar(SnackBar(content: Text('تحقق من الاتصال')));
      });
      if (_res) {
        yield Accepted(orderID: _orderID.value);
      } else {
        _key.value.currentState
            .showSnackBar(SnackBar(content: Text('تحقق من الاتصال')));
      }
    }
  }
}

final offersBloc = OffersBloc();
