import 'package:bloc/bloc.dart';
import 'package:haat/src/Screens/DriverHome/Apis/App/app_event.dart';
import 'package:haat/src/Screens/DriverHome/Apis/App/app_state.dart';
import 'package:haat/src/Screens/DriverHome/Apis/Models/palance_model.dart';
import 'package:haat/src/Screens/DriverHome/Apis/Repository/api_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class BalanceBloc extends Bloc<AppEvent, AppState> {
  final _api = ApiProvider();
  final _key = BehaviorSubject<GlobalKey<ScaffoldState>>();

  Function(GlobalKey<ScaffoldState>) get updateKey => _key.sink.add;

  dispose() {
    _key.close();
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
      BalanceModel _res = await _api.getBalance().catchError((e) {
        _key.value.currentState
            .showSnackBar(SnackBar(content: Text('تحقق من الإتصال')));
      });
      if (_res.code == 200) {
        yield Done(model: _res);
      } else {
        yield Error();
      }
    }

    if (event is RequestBalance) {
      bool _res = await _api.requestBalance().catchError((e) {
        balanceBloc.add(Restart());
        _key.value.currentState
            .showSnackBar(SnackBar(content: Text('تحقق من الإتصال')));
      });
      if (_res) {
        yield RequestSent();
        balanceBloc.add(Click());
      } else {
        yield RequestError();
        balanceBloc.add(Click());
      }
    }
  }
}

final balanceBloc = BalanceBloc();
