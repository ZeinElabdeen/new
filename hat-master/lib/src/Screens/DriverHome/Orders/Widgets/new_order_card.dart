
import 'package:flutter/material.dart';
import 'package:haat/src/MainWidgets/custom_btn.dart';
import 'package:haat/src/Screens/DriverHome/Apis/Helpers/text_helper.dart';
import 'package:haat/src/Screens/DriverHome/Apis/Models/all_orders_model.dart';
import '../order_details.dart';

class NewOrderCard extends StatefulWidget {
  final Order order;
  final int state;

  const NewOrderCard({Key key, this.order, this.state}) : super(key: key);

  @override
  _NewOrderCardState createState() => _NewOrderCardState();
}

class _NewOrderCardState extends State<NewOrderCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10, top: 2),
      child: Card(
        color: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: EdgeInsets.all(7),
          child: ListView(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 5, bottom: 3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(TextHelper().formatDate(date: widget.order.createdAt),
                        style: TextStyle(color: Colors.grey, fontSize: 11)),
                    Row(
                      children: <Widget>[
                        Text(widget.order.id.toString(),
                            style:
                                TextStyle(color: Colors.black, fontSize: 11)),
                        SizedBox(width: 5),
                        Text(':رقم الطلب',
                            style: TextStyle(color: Colors.grey, fontSize: 11))
                      ],
                    )
                  ],
                ),
              ),
              Divider(height: 1, color: Colors.grey),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 30,
                    child: CustomBtn(
                      color: Theme.of(context).primaryColor,
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OrderDetails(
                                  order: widget.order, state: widget.state))),
                      text: 'عرض',
                      txtColor: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10, left: 10),
                    child: Container(width: 1, color: Colors.grey, height: 50),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(widget.order.placeName== null ? "":widget.order.placeName.length > 10 ?widget.order.placeName.substring(0,10) :widget.order.placeName,
                              style: TextStyle(color: Colors.black, fontSize: 13)),
                          SizedBox(width: 15),
                          Text(':اسم المكان',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 13))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(widget.order.user,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 13)),
                          SizedBox(width: 10),
                          Text(':اسم العميل',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 13)),
                        ],
                      ),
                      SizedBox(height: 10)
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
