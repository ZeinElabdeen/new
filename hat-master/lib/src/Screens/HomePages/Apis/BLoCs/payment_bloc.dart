import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:haat/src/Screens/HomePages/Apis/App/app_event.dart';
import 'package:haat/src/Screens/HomePages/Apis/App/app_state.dart';
import 'package:haat/src/Screens/HomePages/Apis/Models/paument_models.dart';
import 'package:haat/src/Screens/HomePages/Apis/Repository/api_provider.dart';
import 'package:rxdart/rxdart.dart';

class PaymentBloc extends Bloc<AppEvent, AppState> {
  final _api = ApiProvider();
  final _cash = BehaviorSubject<String>();
  final _key = BehaviorSubject<GlobalKey<ScaffoldState>>();

  Function(String) get updateCash => _cash.sink.add;

  Function(GlobalKey<ScaffoldState>) get updateKey => _key.sink.add;

  dispose() {
    _key.close();
    _cash.close();
  }

  @override
  AppState get initialState => Start();

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    yield Loading();
    if (event is Click) {
      if (_cash.value == null || _cash.value == '0') {
        _key.value.currentState.showSnackBar(
            SnackBar(content: Text('من فضلك ادخل قيمة بشكل سليم')));
      } else {
        PaymentModel _model =
            await _api.paymentWallet(cash: _cash.value).catchError((e) {
          _key.value.currentState
              .showSnackBar(SnackBar(content: Text('تحقق من الإتصال')));
        });
        if (_model.code == 200) {
          yield Done(model: _model);
        } else {
          yield Error(msg: _model.error[0].value);
        }
      }
    }
  }
}

final paymentBloc = PaymentBloc();
