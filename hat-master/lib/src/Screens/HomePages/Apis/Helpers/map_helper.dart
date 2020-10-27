import 'package:geolocator/geolocator.dart';

class MapHelper {
  Future<Position> getLocation() async {
    Geolocator _geoLocator = Geolocator();
    var currentLocation;
    try {
      currentLocation = await _geoLocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      print(currentLocation.toString());
    } catch (e) {
      currentLocation = null;
    }
    return currentLocation;
  }
}
