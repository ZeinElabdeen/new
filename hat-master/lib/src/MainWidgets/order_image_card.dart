import 'package:flutter/material.dart';

class OrderImageCard extends StatefulWidget {
  final String link;

  const OrderImageCard({Key key, this.link}) : super(key: key);

  @override
  _OrderImageCardState createState() => _OrderImageCardState();
}

class _OrderImageCardState extends State<OrderImageCard> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 10, top: 10, bottom: 10),
          child: Text(
            'صورة الطلب',
            style: TextStyle(color: Colors.black, fontSize: 16),
            textAlign: TextAlign.right,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 20, bottom: 10, left: 20),
          child: Image.network(widget.link),
        ),
        Divider(height: 1, color: Colors.grey),
      ],
    );
  }
}
