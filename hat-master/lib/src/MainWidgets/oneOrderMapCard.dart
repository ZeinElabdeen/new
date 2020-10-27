import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:haat/src/provider/getMapImageProvider.dart';
import 'package:provider/provider.dart';

class OneOrderMapCard extends StatefulWidget {
  final double lat;
  final double long;
  final double orderLat;
  final double orderLong;

  const OneOrderMapCard({
    Key key,
    this.lat,
    this.long,
    this.orderLat,
    this.orderLong,
  }) : super(key: key);

  @override
  _OneOrderMapCardState createState() => _OneOrderMapCardState();
}

class _OneOrderMapCardState extends State<OneOrderMapCard> {
  Set<Marker> _markers = Set();
  Marker _addressMarker;
  Marker _orderAddressMarker;

  @override
  void initState() {
    super.initState();
    _addressMarker = Marker(
      markerId: MarkerId('address'),
      position: LatLng(widget.lat, widget.long),
      infoWindow: InfoWindow(title: 'موقع العميل', onTap: () {}),
      icon: Provider.of<GetMapImage>(context, listen: false).userLocationIcon,
    );
    _orderAddressMarker = Marker(
      markerId: MarkerId('address'),
      position: LatLng(widget.orderLat, widget.orderLong),
      infoWindow: InfoWindow(title: 'موقع المكان', onTap: () {}),
      icon: Provider.of<GetMapImage>(context, listen: false).driverLocationIcon,
    );
    setState(() {
      _markers.add(_addressMarker);
      _markers.add(_orderAddressMarker);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        height: MediaQuery.of(context).size.height / 2,
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
                zoomControlsEnabled: false,
                myLocationButtonEnabled: true,
                myLocationEnabled: true,
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
