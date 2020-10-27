import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:haat/src/MainWidgets/custom_app_bar.dart';
import 'package:haat/src/MainWidgets/custom_btn.dart';
import 'package:haat/src/MainWidgets/details_card.dart';
import 'package:haat/src/MainWidgets/oneOrderMapCard.dart';
import 'package:haat/src/MainWidgets/order_image_card.dart';
import 'package:haat/src/MainWidgets/order_map_card.dart';
import 'package:haat/src/Screens/DriverHome/Apis/Models/all_orders_model.dart';
import 'package:haat/src/Screens/DriverHome/Orders/send_offer.dart';
import 'package:haat/src/Screens/HomePages/Chat/chats.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../MainWidgets/custom_alert.dart';
import '../Apis/App/app_state.dart';
import '../Apis/BLoCs/OrdersBLoCs/orders_bloc.dart';
import '../mainPageDriver.dart';
import 'Widgets/cartCard.dart';
import 'Widgets/orderCancle.dart';

class OrderDetails extends StatefulWidget {
  final Order order;
  final int state;

  const OrderDetails({Key key, this.order, this.state}) : super(key: key);

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  @override
  void initState() {
    ordersBloc.updateOrderID(widget.order.id);
    print(widget.order.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomAppBar(
          onTap: () => Navigator.pop(context),
          label: 'تفاصيل الطلب',
          iconData: Icons.arrow_back_ios,
        ),
      ),
      floatingActionButton: widget.state == 2
          ? FloatingActionButton(
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (_) => Chats())),
              child: Icon(Icons.chat, color: Colors.white),
              backgroundColor: Theme.of(context).primaryColor,
            )
          : null,
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Card(
              color: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: ListView(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            // CircleAvatar(
                            //     radius: 20,
                            //     backgroundImage:
                            //         NetworkImage(widget.order.userPhoto ?? "")),
                            Container(
                              height: 70,
                              width: 70,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CachedNetworkImage(
                                  imageUrl: widget.order.userPhoto ?? "",
                                  errorWidget: (context, url, error) =>
                                      ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: Image.asset(
                                              'assets/images/avatar.jpeg',
                                              fit: BoxFit.cover)),
                                  fadeInDuration: Duration(seconds: 2),
                                  placeholder: (context, url) => ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: Image.asset(
                                          'assets/images/avatar.jpeg',
                                          fit: BoxFit.cover)),
                                  imageBuilder: (context, provider) {
                                    return ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: Image(
                                          image: provider,
                                          fit: BoxFit.cover,
                                        ));
                                  },
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Column(
                              children: [
                                Text(
                                  widget.order.user,
                                  style: TextStyle(fontSize: 16),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Center(
                                  child: RatingBar(
                                    initialRating:
                                        widget.order.userRate.toDouble(),
                                    itemSize: 15.0,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    itemPadding:
                                        EdgeInsets.symmetric(horizontal: 4.0),
                                    onRatingUpdate: null,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Divider(height: 1, color: Colors.grey),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[],
                    )
                  ],
                ),
              ),
            ),
          ),
          DetailsCard(
            label: 'تفاصيل الطلب',
            content: widget.order.orderDetails,
          ),
          Visibility(
            visible: widget.order.latitude != null,
            child: DetailsCard(
              label: 'اسم المكان',
              content: widget.order.placeName ?? "",
            ),
          ),
          Visibility(
            visible: widget.order.resturantPhone != null,
            child: DetailsCard(
              label: 'رقم المطعم',
              content: widget.order.resturantPhone ?? "",
            ),
          ),
          widget.order.photo != null
              ? OrderImageCard(link: widget.order.photo)
              : Container(),
          widget.order.addressDetails != null
              ? DetailsCard(
                  label: 'تفاصيل العنوان',
                  content: widget.order.addressDetails,
                )
              : Container(),
          widget.order.orderLongitude == null
              ? OrderMapCard(
                  lat: double.parse(widget.order.latitude),
                  long: double.parse(widget.order.longitude),
                )
              : OneOrderMapCard(
                  lat: double.parse(widget.order.latitude ?? "0.0"),
                  long: double.parse(widget.order.longitude ?? "1.0"),
                  orderLat: double.parse(widget.order.orderLatitude ?? "0.0"),
                  orderLong: double.parse(widget.order.orderLongitude ?? "1.0"),
                ),
          SizedBox(height: 20),
          widget.order.orderCart == null
              ? Container()
              : ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: widget.order.orderCart.length,
                  itemBuilder: (c, index) {
                    return CartCard(
                      order: widget.order.orderCart[index],
                      // state: 0,
                    );
                  }),
          widget.order.status == 1
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: CustomBtn(
                    color: Theme.of(context).primaryColor,
                    txtColor: Colors.white,
                    text: 'إتصال بالعميل',
                    onTap: () => launch("tel://${widget.order.userPhone}"),
                  ),
                )
              : Container(),
          widget.order.status == 1
              ? BlocListener<OrdersBloc, AppState>(
                  bloc: ordersBloc,
                  listener: (_, state) {
                    if (state is OrderCancelled) {
                      CustomAlert()
                          .toast(context: context, title: 'تم إنهاء الطلب');
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (_) => MainPageDriver()));
                    }
                  },
                  child: OrderCancelBtn(context: context),
                )
              : Container(),
          widget.state == 0
              ? Padding(
                  padding: EdgeInsets.all(50),
                  child: CustomBtn(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                SendOffer(orderID: widget.order.id))),
                    color: Theme.of(context).primaryColor,
                    text: 'تقدم بعرض سعر',
                    txtColor: Colors.white,
                  ),
                )
              : SizedBox(height: 50),
        ],
      ),
    );
  }
}
