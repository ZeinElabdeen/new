import 'package:bloc/bloc.dart';

import 'package:haat/src/Screens/HomePages/Apis/App/app_event.dart';
import 'package:haat/src/Screens/HomePages/Apis/App/app_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haat/src/Screens/HomePages/Apis/Models/AppModels/app_categories_model.dart';
import 'package:haat/src/Screens/HomePages/Apis/Models/AppModels/home_model.dart';
import 'package:haat/src/Screens/HomePages/Apis/Models/categories_model.dart';
import 'package:haat/src/Screens/HomePages/Apis/Models/slider_model.dart';
import 'package:haat/src/Screens/HomePages/Apis/Repository/api_provider.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc extends Bloc<AppEvent, AppState> {
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
      SliderModel _sliders = await _api.getSliders().catchError((e) {
        _key.value.currentState
            .showSnackBar(SnackBar(content: Text('تحقق من الإتصال')));
      });
      CategoriesModel _categories = await _api.getCategories().catchError((e) {
        _key.value.currentState
            .showSnackBar(SnackBar(content: Text('تحقق من الإتصال')));
      });

      List<AppCategoriesModel> _categoriesList = [];
      _categoriesList
          .add(AppCategoriesModel(name: "الكل", image: "assets/all.png", id: 0));

      if (_sliders.code == 200 && _categories.code == 200) {
        for (int i = 0; i < _categories.data.length; i++) {
          _categoriesList.add(AppCategoriesModel(
              id: _categories.data[i].id,
              name: _categories.data[i].name,
              image: _categories.data[i].photo));
        }
        yield Done(
            model: HomeModel(categories: _categoriesList, sliders: _sliders));
      } else {
        yield Error(msg: 'تحقق من الإتصال');
      }
    }
  }
}

final homeBloc = HomeBloc();
