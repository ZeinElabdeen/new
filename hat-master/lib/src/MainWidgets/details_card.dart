import 'package:flutter/material.dart';

class DetailsCard extends StatefulWidget {
  final String label;
  final String content;

  const DetailsCard({Key key, this.label, this.content}) : super(key: key);

  @override
  _DetailsCardState createState() => _DetailsCardState();
}

class _DetailsCardState extends State<DetailsCard> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 10, top: 10),
          child: Text(
            widget.label,
            style: TextStyle(color: Colors.black, fontSize: 16),
            textAlign: TextAlign.right,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 20, bottom: 10),
          child: Text(
            widget.content,
            style: TextStyle(color: Colors.grey, fontSize: 16),
            textAlign: TextAlign.right,
          ),
        ),
        Divider(height: 1, color: Colors.grey),
      ],
    );
  }
}
