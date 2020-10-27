import 'package:flutter/material.dart';

class ChatPriceCard extends StatefulWidget {
  final int deliveryPrice;
  final int orderPrice;

  const ChatPriceCard({Key key, this.deliveryPrice, this.orderPrice}) : super(key: key);
  @override
  _ChatPriceCardState createState() => _ChatPriceCardState();
}

class _ChatPriceCardState extends State<ChatPriceCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                "سعر الطلب",
                style: TextStyle(
                    fontSize: 13,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 5),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 20, left: 20, top: 5, bottom: 5),
                  child: Text(widget.orderPrice.toString()),
                ),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Text(
                "سعر التوصيل",
                style: TextStyle(
                    fontSize: 13,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 5),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 20, left: 20, top: 5, bottom: 5),
                  child: Text(widget.deliveryPrice.toString()),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
