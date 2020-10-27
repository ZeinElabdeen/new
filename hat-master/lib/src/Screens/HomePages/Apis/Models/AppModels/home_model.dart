

import '../slider_model.dart';
import 'app_categories_model.dart';
import 'base_model.dart';

class HomeModel extends BaseModel {
  SliderModel sliders;
  List<AppCategoriesModel> categories;

  HomeModel({this.sliders, this.categories});

  @override
  BaseModel fromJson(Map<String, dynamic> json) {
    return null;
  }
}
