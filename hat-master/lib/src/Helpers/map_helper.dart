import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MapHelper with ChangeNotifier {
  Position position;
  SharedPreferences _preferences;
  MapType mapType = MapType.normal;
  Future<Position> getLocation() async {
    Geolocator _geoLocator = Geolocator();
    var currentLocation;
    try {
      _preferences = await SharedPreferences.getInstance();

      currentLocation = await _geoLocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);

      _preferences.setDouble("long", currentLocation.longitude);
      _preferences.setDouble("lat", currentLocation.latitude);
      print(currentLocation.toString());

      position = currentLocation;
      notifyListeners();
    } catch (e) {
      currentLocation = null;
    }
    return currentLocation;
  }

  changeMapType(MapType m) {
    mapType = m;
    notifyListeners();
  }
}
