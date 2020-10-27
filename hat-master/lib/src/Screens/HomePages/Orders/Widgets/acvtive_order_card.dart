import 'package:flutter/material.dart';
import 'package:haat/src/MainWidgets/custom_btn.dart';
import 'package:haat/src/Screens/HomePages/Apis/Helpers/text_helper.dart';
import 'package:haat/src/Screens/HomePages/Apis/Models/all_orders_model.dart';
import 'package:haat/src/Screens/HomePages/Orders/internal/order_details.dart';

class ActiveOrderCard extends StatefulWidget {
  final Order order;

  const ActiveOrderCard({Key key, this.order}) : super(key: key);

  @override
  _ActiveOrderCardState createState() => _ActiveOrderCardState();
}

class _ActiveOrderCardState extends State<ActiveOrderCard> {
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
                        Text(widget.order.id.toString() ?? "0",
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
                children: <Widget>[
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text('الطلب',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 13)),
                          Text(
                              widget.order.orderPrice == null
                                  ? "0"
                                  : widget.order.orderPrice.toString(),
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 20)),
                          Text('ريال',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 11)),
                        ],
                      ),
                      SizedBox(width: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text('التوصيل',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 13)),
                          Text(widget.order.price == null ? "0" : widget.order.price.toString(),
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 20)),
                          Text('ريال',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 11)),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10, left: 10),
                    child: Container(width: 1, color: Colors.grey, height: 50),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                              widget.order.placeName == null
                                  ? ""
                                  : widget.order.placeName.length > 20
                                      ? widget.order.placeName.substring(0, 10)
                                      : widget.order.placeName,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 13)),
                          SizedBox(width: 15),
                          Text(':اسم المكان',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 13))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(widget.order.driver ?? "",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 13)),
                          SizedBox(width: 10),
                          Text(':اسم السائق',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 13)),
                        ],
                      ),
                      SizedBox(height: 10),
                      Container(
                        height: 30,
                        child: CustomBtn(
                          color: Theme.of(context).primaryColor,
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OrderDetails(
                                      order: widget.order, state: 1))),
                          text: 'عرض',
                          txtColor: Colors.white,
                        ),
                      ),
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
