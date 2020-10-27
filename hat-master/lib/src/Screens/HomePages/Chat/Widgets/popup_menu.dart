import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:haat/src/MainWidgets/custom_alert.dart';
import 'package:haat/src/MainWidgets/custom_btn.dart';
import 'package:haat/src/Screens/HomePages/Apis/App/app_event.dart';
import 'package:haat/src/Screens/HomePages/Apis/App/app_state.dart';
import 'package:haat/src/Screens/HomePages/Apis/BLoCs/OrderBLoCs/orders_bloc.dart';
import 'package:haat/src/Screens/HomePages/Apis/BLoCs/chat_bloc.dart';
import 'package:haat/src/Screens/HomePages/Apis/Helpers/map_helper.dart';
import 'package:haat/src/Screens/HomePages/Orders/internal/orderState.dart';
import 'package:haat/src/Screens/HomePages/Orders/internal/rating.dart';
import 'package:haat/src/Screens/HomePages/Settings/Internal/help.dart';
import 'package:haat/src/provider/post/finishOrderProvider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../Helpers/sharedPref_helper.dart';
import '../../Settings/Internal/send_bill.dart';

class PopupWidget extends StatefulWidget {
  final String phone;
  final int orderID;
  final int driverID;

  const PopupWidget({Key key, this.phone, this.orderID, this.driverID})
      : super(key: key);

  @override
  _PopupWidgetState createState() => _PopupWidgetState();
}

class _PopupWidgetState extends State<PopupWidget> {
  Position _startPosition;

  @override
  void initState() {
    MapHelper().getLocation().then((value) {
      setState(() {
        _startPosition = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: Icon(
        Icons.more_vert,
        color: Colors.white,
      ),
      onSelected: (v) {
        // add this propertys
        switch (v) {
          case 0:
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HelpCenter()));
            break;
          case 1:
            launch("tel://${widget.phone}");
            break;
          case 2:
            // Navigator.pop(context);
            showBottomSheet(
                context: context,
                builder: (_) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height - 120,
                    child: ListView(
                      shrinkWrap: true,
                      children: <Widget>[
                        InkWell(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 60,
                            color: Theme.of(context).primaryColor,
                            padding: EdgeInsets.only(left: 10, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                InkWell(
                                    onTap: () => Navigator.pop(context),
                                    child: Icon(Icons.close,
                                        size: 28, color: Colors.white)),
                                Text('موقع الإستلام',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 17))
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height - 180,
                          width: MediaQuery.of(context).size.width,
                          child: _startPosition == null
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
                                        target: LatLng(_startPosition.latitude,
                                            _startPosition.longitude),
                                        zoom: 14.0,
                                      ),
                                      onCameraMove: (camera) {
                                        chatBloc.updateLat(
                                            camera.target.latitude.toString());
                                        chatBloc.updateLong(
                                            camera.target.longitude.toString());
                                      },
                                      gestureRecognizers: <
                                          Factory<
                                              OneSequenceGestureRecognizer>>[
                                        new Factory<
                                            OneSequenceGestureRecognizer>(
                                          () => new EagerGestureRecognizer(),
                                        ),
                                      ].toSet(),
                                    ),
                                    Center(
                                        child: Image.asset(
                                            'assets/images/loc.png',
                                            width: 40)),
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
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              children: <Widget>[
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    Image.asset(
                                                        'assets/images/loc.png',
                                                        width: 30),
                                                    SizedBox(width: 10),
                                                    Text('العنوان',
                                                        style: TextStyle(
                                                            color: Colors.grey))
                                                  ],
                                                ),
                                                TextField(
                                                  onChanged: chatBloc.updateMsg,
                                                  textAlign: TextAlign.right,
                                                  keyboardType:
                                                      TextInputType.text,
                                                  decoration: InputDecoration(
                                                      hintStyle: TextStyle(
                                                          fontSize: 15,
                                                          height: .8)),
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          CustomBtn(
                                            color:
                                                Theme.of(context).primaryColor,
                                            onTap: () {
                                              Navigator.pop(context);
                                              chatBloc.add(SendMsg());
                                            },
                                            text: 'إرسال',
                                            txtColor: Colors.white,
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                        ),
                      ],
                    ),
                  );
                });

            break;
          case 3:
            // ordersBloc.updateOrderID(widget.orderID);
            // ordersBloc.add(Finish());
            Provider.of<FinishOrderProvider>(context, listen: false)
                .finishOrder(
                    widget.driverID,
                    Provider.of<SharedPref>(context, listen: false).token,
                    widget.orderID,
                    context);
            break;
          case 4:
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => SendBill(orderID: widget.orderID)));
            break;
          case 5:
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => OrderState()));
            break;
          default:
        }
      },
      itemBuilder: (_) => [
        PopupMenuItem(
          enabled: true,
          value: 0,
          child: Text(
            'إرسال شكوى',
            style: TextStyle(color: Colors.black, fontSize: 13),
          ),
        ),
        Provider.of<SharedPref>(context, listen: false).type == 1
            ? PopupMenuItem(
                enabled: true,
                value: 1,
                child: Text(
                  'اتصال',
                  style: TextStyle(color: Colors.black, fontSize: 13),
                  textAlign: TextAlign.center,
                ),
              )
            : null,
        PopupMenuItem(
          enabled: true,
          value: 2,
          child: Text(
            'إرسال الموقع',
            style: TextStyle(color: Colors.black, fontSize: 13),
            textAlign: TextAlign.center,
          ),
        ),
        Provider.of<SharedPref>(context, listen: false).type == 1
            ? PopupMenuItem(
                enabled: true,
                value: 3,
                child: BlocListener<OrdersBloc, AppState>(
                  bloc: ordersBloc,
                  listener: (_, state) {
                    if (state is OrderFinished) {
                      CustomAlert().toast(
                          context: context,
                          title: 'تم إنهاء الطلب من فضلك قم بتقييم السائق');
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (_) => Rating(
                                    orderID: widget.orderID,
                                    driverID: widget.driverID,
                                  )));
                    }
                  },
                  child: Text(
                    'إنهاء الطلب',
                    style: TextStyle(color: Colors.black, fontSize: 13),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            : null,
        Provider.of<SharedPref>(context, listen: false).type == 2
            ? PopupMenuItem(
                enabled: true,
                value: 4,
                child: Text(
                  'إرسال الفاتورة',
                  style: TextStyle(color: Colors.black, fontSize: 13),
                  textAlign: TextAlign.center,
                ),
              )
            : null,
        PopupMenuItem(
          enabled: true,
          value: 5,
          child: Text(
            'تتبع الطلب',
            style: TextStyle(color: Colors.black, fontSize: 13),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}
