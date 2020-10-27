import 'package:bloc/bloc.dart';

import 'package:haat/src/Screens/HomePages/Apis/App/app_event.dart';
import 'package:haat/src/Screens/HomePages/Apis/App/app_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haat/src/Screens/HomePages/Apis/Models/history_model.dart';
import 'package:haat/src/Screens/HomePages/Apis/Repository/api_provider.dart';
import 'package:rxdart/rxdart.dart';

class HistoryBloc extends Bloc<AppEvent, AppState> {
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
    if (event is Click) {
      HistoryModel _res = await _api.getHistory().catchError((e) {
        _key.value.currentState
            .showSnackBar(SnackBar(content: Text('تحقق من الإتصال')));
      });
      if (_res.code == 200) {
        yield Done(model: _res);
      } else {
        yield Error();
      }
    }
  }
}

final historyBloc = HistoryBloc();
