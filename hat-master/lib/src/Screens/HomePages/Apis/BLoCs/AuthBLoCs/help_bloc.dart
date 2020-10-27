import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haat/src/Screens/HomePages/Apis/App/app_event.dart';
import 'package:haat/src/Screens/HomePages/Apis/App/app_state.dart';
import 'package:haat/src/Screens/HomePages/Apis/Repository/api_provider.dart';
import 'package:rxdart/rxdart.dart';

class HelpBloc extends Bloc<AppEvent, AppState> {
  final _api = ApiProvider();
  final _title = BehaviorSubject<String>();
  final _content = BehaviorSubject<String>();
  final _key = BehaviorSubject<GlobalKey<ScaffoldState>>();

  Function(String) get updateTitle => _title.sink.add;

  Function(GlobalKey<ScaffoldState>) get updateKey => _key.sink.add;

  Function(String) get updateContent => _content.sink.add;

  dispose() {
    _title.close();
    _key.close();
    _content.close();
  }

  clear() {
    _title.value = null;
    _content.value = null;
  }

  @override
  AppState get initialState => Start();

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    yield Loading();
    if (_title.value == null) {
      yield TitleError();
    } else if (_content.value == null) {
      yield ContentError();
    } else {
      if (event is Click) {
        bool _model = await _api
            .helpCenter(title: _title.value, content: _content.value)
            .catchError((e) {
          _key.value.currentState
              .showSnackBar(SnackBar(content: Text('تحقق من الاتصال')));
        });
        if (_model) {
          yield Done();
          clear();
        } else {
          _key.value.currentState
              .showSnackBar(SnackBar(content: Text('تحقق من الإتصال')));
        }
      }
    }
  }
}

final helpBloc = HelpBloc();
