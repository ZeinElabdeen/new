import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:haat/src/MainWidgets/customBtn.dart';
import 'package:haat/src/Helpers/map_helper.dart';
import 'package:haat/src/Helpers/sharedPref_helper.dart';
import 'package:haat/src/provider/get/MyAddressProvider.dart';
import 'package:haat/src/provider/post/createPlaceProvider.dart';
import 'package:provider/provider.dart';

class PickPlace extends StatefulWidget {
  @override
  _PickPlaceState createState() => _PickPlaceState();
}

class _PickPlaceState extends State<PickPlace> {
  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 150), () {
      Provider.of<CreatePlaceProvider>(context, listen: false).setNull();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text(
              "اضافة عنوان",
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
      body: Provider.of<MapHelper>(context, listen: false).position == null
          ? Center(
              child: SpinKitThreeBounce(
                color: Theme.of(context).primaryColor,
                size: 25,
              ),
            )
          : Stack(
              children: <Widget>[
                GoogleMap(
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
                    Provider.of<CreatePlaceProvider>(context, listen: false)
                        .latitude = camera.target.latitude.toString();
                    Provider.of<CreatePlaceProvider>(context, listen: false)
                        .longitude = camera.target.longitude.toString();
                  },
                  gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
                    new Factory<OneSequenceGestureRecognizer>(
                      () => new EagerGestureRecognizer(),
                    ),
                  ].toSet(),
                ),
                Center(child: Image.asset('assets/images/loc.png', width: 40)),
                Positioned(
                  right: 15,
                  left: 15,
                  bottom: 15,
                  child: ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      Container(
                        color: Colors.white,
                        padding: EdgeInsets.all(10),
                        child: ListView(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Image.asset('assets/images/loc.png', width: 30),
                                SizedBox(width: 10),
                                Text('العنوان',
                                    style: TextStyle(color: Colors.grey))
                              ],
                            ),
                            TextField(
                              onChanged: (v) {
                                Provider.of<CreatePlaceProvider>(context,
                                        listen: false)
                                    .placeName = v;
                              },
                              textAlign: TextAlign.right,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  hintStyle:
                                      TextStyle(fontSize: 15, height: .8),
                                  hintText: "العنوان"),
                            ),
                            TextField(
                              onChanged: (v) {
                                Provider.of<CreatePlaceProvider>(context,
                                        listen: false)
                                    .placeDetails = v;
                              },
                              textAlign: TextAlign.right,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  hintStyle:
                                      TextStyle(fontSize: 15, height: .8),
                                  hintText: "تفاصيل المكان"),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      CustomBtn(
                        color: Theme.of(context).primaryColor,
                        onTap: () {
                          if (Provider.of<CreatePlaceProvider>(context,
                                      listen: false)
                                  .placeName ==
                              null) {
                            Fluttertoast.showToast(
                                msg: "يجب اضافة اسم المكان",
                                toastLength: Toast.LENGTH_LONG,
                                timeInSecForIosWeb: 1,
                                fontSize: 16.0);
                            return;
                          }
                          if (Provider.of<CreatePlaceProvider>(context,
                                      listen: false)
                                  .latitude ==
                              null) {
                            Fluttertoast.showToast(
                                msg: "يجب اضافة موقع المكان",
                                toastLength: Toast.LENGTH_LONG,
                                timeInSecForIosWeb: 1,
                                fontSize: 16.0);
                            return;
                          }
                          Provider.of<CreatePlaceProvider>(context,
                                  listen: false)
                              .createPlace(
                                  Provider.of<SharedPref>(context,
                                          listen: false)
                                      .token,
                                  context)
                              .then((v) {
                            if (v == true) {
                              Provider.of<MyAddressProvider>(context,
                                      listen: false)
                                  .getPlaces(Provider.of<SharedPref>(context,
                                          listen: false)
                                      .token);
                              Navigator.pop(context);
                            }
                          });
                        },
                        text: 'حفظ',
                        txtColor: Colors.white,
                      )
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
