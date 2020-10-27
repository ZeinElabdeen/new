import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref with ChangeNotifier {
  String token;
  int id;
  String photo;
  String phone;
  int type;
  String name;
  String email;
  double lat;
  double long;
  bool avalable;
  int cityId;
  String city;
  int carTypeId;
  String carType;
  int rate;
  int identityTypeId;
  String identityType;
  int nationalityId;
  String nationality;
  String identity;
  String license;
  String carForm;
  String transportationCard;
  String insurance;

  var idNumber;
  String job;
  String barithDay;

  getSharedHelper(SharedPreferences pref) {
    token = pref.get("token");
    id = pref.get("id");
    photo = pref.get("photo");
    phone = pref.get("phone");
    type = pref.get("type");
    name = pref.get("name");
    email = pref.get("email");
    lat = pref.get("lat");
    long = pref.get("long");
    avalable = pref.get("avalable") ?? false;
    cityId = pref.get("cityId");
    city = pref.get("city");
    carTypeId = pref.get("carTypeId");
    carType = pref.get("carType");
    identityTypeId = pref.get("identityTypeId");
    identityType = pref.get("identityType");
    nationalityId = pref.get("nationalityId");
    nationality = pref.get("nationality");
    idNumber = pref.get("idNumber");
    job = pref.get("jop");
    rate = pref.get("rate") ?? 0;
    identity = pref.get('identity');
    license = pref.get('license');
    carForm = pref.get('carForm');
    transportationCard = pref.get('transportationCard');
    insurance = pref.get('insurance');
    barithDay = pref.get('barthDay');

    print(token);
    print(phone);
    print(name);
    print(photo);
    print(lat);
    print(long);
    print(avalable);
    print(cityId);
    print(city);
    print(carTypeId);
    print(identityTypeId);
    print(identityType);
    print(nationalityId);
    print(nationality);
    print(idNumber);
    print(job);
    print(identity);
    print(license);
    print(carForm);
    print(transportationCard);
    print(insurance);
    print("shared lat $lat");
    print("shared lat $long");

    print("i get shared");
    notifyListeners();
  }

  clearPre() {}
}
