import 'package:flutter/cupertino.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;

class GetMapImage with ChangeNotifier {
  BitmapDescriptor driverLocationIcon;
  BitmapDescriptor userLocationIcon;

  Future<Uint8List> _getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        .buffer
        .asUint8List();
  }

  setCustomMapPin() async {
    final Uint8List _icon =
        // await _getBytesFromAsset('assets/images/loc.png', 90);
        await _getBytesFromAsset('assets/images/resAddress.png', 90);

         final Uint8List _icon2 =
        await _getBytesFromAsset('assets/images/homeAdress.png', 90);
    driverLocationIcon = BitmapDescriptor.fromBytes(_icon);
    userLocationIcon = BitmapDescriptor.fromBytes(_icon2);
    print("get Map Image");
    notifyListeners();
  }
}
