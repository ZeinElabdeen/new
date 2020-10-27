import 'package:flutter/material.dart';

class ChoseLangeProvider with ChangeNotifier {
  bool selectLang = false;
  String lang ;
  void changeLang(String language) {
    selectLang = true;
    lang = language;
    notifyListeners();
  }
}
