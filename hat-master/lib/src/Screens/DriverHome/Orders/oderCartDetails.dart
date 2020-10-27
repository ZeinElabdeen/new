import 'package:flutter/material.dart';
import 'package:haat/src/MainWidgets/custom_app_bar.dart';
import 'package:haat/src/MainWidgets/details_card.dart';
import 'package:haat/src/MainWidgets/order_image_card.dart';
import 'package:haat/src/MainWidgets/order_map_card.dart';
import 'package:haat/src/Screens/DriverHome/Apis/Models/all_orders_model.dart';
import 'package:haat/src/Screens/HomePages/Chat/chats.dart';

class OrderCartDetails extends StatefulWidget {
  final OrderCart order;
  final int state;

  const OrderCartDetails({Key key, this.order, this.state}) : super(key: key);

  @override
  _OrderCartDetailsState createState() => _OrderCartDetailsState();
}

class _OrderCartDetailsState extends State<OrderCartDetails> {
  @override
  void initState() {
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
          SizedBox(height: 20),

          DetailsCard(
            label: 'تفاصيل الطلب',
            content: widget.order.orderDetails,
          ),
          Visibility(
            visible: widget.order.placeName != null,
            child: DetailsCard(
              label: 'اسم المكان',
              content: widget.order.placeName ?? "",
            ),
          ),
          widget.order.photo != null
              ? OrderImageCard(link: widget.order.photo)
              : Container(),
       
          SizedBox(
            height: 100,
          ),
          Visibility(
            visible: widget.order.orderLatitude != null &&
                widget.order.orderLatitude != null,
            child: OrderMapCard(
              lat: double.parse(widget.order.orderLatitude ?? "0.0"),
              long: double.parse(widget.order.orderLongitude ?? "1.0"),
            
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
