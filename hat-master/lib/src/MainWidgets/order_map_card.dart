import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OrderMapCard extends StatefulWidget {
  final double lat;
  final double long;

  const OrderMapCard({Key key, this.lat, this.long}) : super(key: key);

  @override
  _OrderMapCardState createState() => _OrderMapCardState();
}

class _OrderMapCardState extends State<OrderMapCard> {
  Set<Marker> _markers = Set();
  Marker _addressMarker;

  @override
  void initState() {
    super.initState();
    _addressMarker = Marker(
      markerId: MarkerId('address'),
      position: LatLng(widget.lat, widget.long),
      infoWindow: InfoWindow(title: 'موقع'),
      icon: BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueRed,
      ),
    );
    setState(() {
      _markers.add(_addressMarker);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        height: MediaQuery.of(context).size.height / 3,
        child: Center(
          child: Stack(
            children: <Widget>[
              GoogleMap(
                onMapCreated: (c) {},
                initialCameraPosition: CameraPosition(
                  target: LatLng(widget.lat, widget.long),
                  zoom: 14.0,
                ),
                mapToolbarEnabled: true,
                myLocationButtonEnabled: false,
                myLocationEnabled: true,
                zoomControlsEnabled: false,
                markers: _markers,
                gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
                  new Factory<OneSequenceGestureRecognizer>(
                    () => new EagerGestureRecognizer(),
                  ),
                ].toSet(),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(left:8.0,top: 10),
              //   child: Align(
              //     alignment: Alignment.topLeft,
              //     child: InkWell(
              //       child: Icon(Icons.location_on,size: 30,),
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
