import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:haat/src/MainWidgets/customBtn.dart';
import 'package:haat/src/MainWidgets/custom_new_dialog.dart';
import 'package:haat/src/MainWidgets/mapFabs.dart';
import 'package:haat/src/Helpers/map_helper.dart';
import 'package:haat/src/Repository/appLocalization.dart';
import 'package:haat/src/provider/post/createOrderProvider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:location/location.dart' as locat;

import 'CreateOrder/mapOrder.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  SharedPreferences _pref;
  String searchAddr;
  Geolocator _geoLocator = Geolocator();
  GoogleMapController _mapController;
  Set<Marker> _markers = Set();
  Marker _shopMarker;
  int count = 0;
  int indss = 0;
  double lat;
  double long;
  CustomDialog dialog = CustomDialog();

  var location = locat.Location();
  Future _checkGps() async {
    if (!await location.serviceEnabled()) {
      location.requestService();
    } else {}
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(milliseconds: 150), () {
      Provider.of<CreateOrderProvider>(context, listen: false).setNull();
      Provider.of<CreateOrderProvider>(context, listen: false).orderLatitude =
          Provider.of<MapHelper>(context, listen: false)
              .position
              .latitude
              .toString();
      Provider.of<CreateOrderProvider>(context, listen: false).orderLongitude =
          Provider.of<MapHelper>(context, listen: false)
              .position
              .longitude
              .toString();
    });
    _checkGps();
  }

  BitmapDescriptor _pinLocationIcon;

  searchandNavigate() {
    Geolocator().placemarkFromAddress(searchAddr).catchError((e) {
      setState(() {});
      Fluttertoast.showToast(
          msg: localization.text("enter_correct_location"),
          toastLength: Toast.LENGTH_LONG,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
    });

    Geolocator().placemarkFromAddress(searchAddr).then((result) {
      setState(() {});

      _mapController.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
              target: LatLng(
                  result[0].position.latitude, result[0].position.longitude),
              zoom: 10.0)));
    });
  }

  MapType _currentMapType = MapType.normal;
  void _onToggleMapTypePressed() {
    final MapType nextType =
        MapType.values[(_currentMapType.index + 1) % MapType.values.length];

    setState(() => _currentMapType = nextType);
  }

  bool isMarked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text(
              " الخريطة",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Provider.of<MapHelper>(context, listen: false).position == null
              ? SpinKitThreeBounce(
                  color: Theme.of(context).primaryColor,
                  size: 25,
                )
              : Stack(
                  children: <Widget>[
                    GoogleMap(
                      onMapCreated: _onMapCreated,
                      myLocationButtonEnabled: false,
                      zoomControlsEnabled: false,
                      mapToolbarEnabled: false,
                      myLocationEnabled: false,
                      mapType: _currentMapType,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(
                            Provider.of<MapHelper>(context, listen: false)
                                .position
                                .latitude,
                            Provider.of<MapHelper>(context, listen: false)
                                .position
                                .longitude),
                        zoom: 14.0,
                      ),
                      onCameraMove: (camera) {
                        Provider.of<CreateOrderProvider>(context, listen: false)
                            .orderLatitude = camera.target.latitude.toString();
                        Provider.of<CreateOrderProvider>(context, listen: false)
                                .orderLongitude =
                            camera.target.longitude.toString();
                        lat = camera.target.latitude;
                        long = camera.target.longitude;
                      },
                      gestureRecognizers:
                          <Factory<OneSequenceGestureRecognizer>>[
                        new Factory<OneSequenceGestureRecognizer>(
                          () => new EagerGestureRecognizer(),
                        ),
                      ].toSet(),
                    ),
                    Center(
                        child: Image.asset('assets/images/loc.png', width: 40)),
                    Positioned(
                      right: 15,
                      left: 15,
                      bottom: 15,
                      child: ListView(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: <Widget>[
                          SizedBox(height: 10),
                          CustomBtn(
                            color: Theme.of(context).primaryColor,
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MapOrder())),
                            text: 'اطلب الان',
                            txtColor: Colors.white,
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MapFabs(
                        myLocationButtonEnabled: true,
                        layersButtonEnabled: true,
                        onToggleMapTypePressed: _onToggleMapTypePressed,
                        onMyLocationPressed: () {
                          _checkGps();
                          _getLocation();
                        },
                      ),
                    ),
                  ],
                ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 10, right: 10),
              child: Column(
                children: <Widget>[
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Row(
                        textDirection:
                            localization.currentLanguage.toString() == "en"
                                ? TextDirection.ltr
                                : TextDirection.rtl,
                        children: <Widget>[
                          Expanded(
                            child: TextFormField(
                              textDirection:
                                  localization.currentLanguage.toString() ==
                                          "en"
                                      ? TextDirection.ltr
                                      : TextDirection.rtl,
                              cursorColor: Colors.black,
                              keyboardType: TextInputType.text,
                              textAlign:
                                  localization.currentLanguage.toString() ==
                                          "en"
                                      ? TextAlign.left
                                      : TextAlign.right,
                              textInputAction: TextInputAction.search,
                              onFieldSubmitted: (v) {
                                searchandNavigate();
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 15),
                                hintText: localization.text("shearch"),
                              ),
                              onChanged: (v) {
                                setState(() {
                                  searchAddr = v;
                                });
                              },
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 8.0, left: 8.0),
                            child: InkWell(
                                onTap: () {
                                  if (searchAddr == null ||
                                      searchAddr.length == 0) {
                                    Fluttertoast.showToast(
                                        msg: localization
                                            .text("enter_correct_location"),
                                        toastLength: Toast.LENGTH_LONG,
                                        timeInSecForIosWeb: 1,
                                        fontSize: 16.0);
                                    return;
                                  }
                                  setState(() {});
                                  searchandNavigate();
                                },
                                child: Icon(Icons.search)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<Position> _getLocation() async {
    _pref = await SharedPreferences.getInstance();

    var currentLocation;
    try {
      currentLocation = await _geoLocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      print(currentLocation.toString());
      setState(() {
        _shopMarker = Marker(
          markerId: MarkerId('target'),
          position: LatLng(currentLocation.latitude, currentLocation.longitude),
          infoWindow: InfoWindow(title: 'موقع التوصيل'),
          icon: _pinLocationIcon,
        );

        setState(() {
          _pref.setDouble("startLat", _shopMarker.position.latitude);
          _pref.setDouble("startLong", _shopMarker.position.longitude);
          lat = _shopMarker.position.latitude;
          long = _shopMarker.position.longitude;
          _markers.add(_shopMarker);
        });

        _mapController.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(
                target: LatLng(_shopMarker.position.latitude,
                    _shopMarker.position.longitude),
                zoom: 14.0)));
      });
    } catch (e) {
      currentLocation = null;
    }
    return currentLocation;
  }

  _onMapCreated(GoogleMapController controller) {
    setState(() {
      _mapController = controller;
    });
  }
}
