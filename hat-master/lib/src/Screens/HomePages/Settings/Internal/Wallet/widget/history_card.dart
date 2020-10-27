
import 'package:flutter/material.dart';
import 'package:haat/src/Screens/HomePages/Apis/Helpers/text_helper.dart';
import 'package:haat/src/Screens/HomePages/Apis/Models/history_model.dart';

class HistoryCard extends StatefulWidget {
  final History history;

  const HistoryCard({Key key, this.history}) : super(key: key);

  @override
  _HistoryCardState createState() => _HistoryCardState();
}

class _HistoryCardState extends State<HistoryCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Card(
        color: Colors.white,
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: EdgeInsets.all(7),
          child: ListView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(widget.history.title.length > 35 ? widget.history.title.substring(0,35):widget.history.title,
                        style: TextStyle(fontSize: 12, color: Colors.grey)),
                    Text(
                        TextHelper().formatDate(date: widget.history.createdAt),
                        style: TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5, bottom: 5),
                child: Divider(color: Colors.grey, height: 1),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('قيمة العملية',
                      style: TextStyle(fontSize: 12, color: Colors.grey)),
                  Row(
                    children: <Widget>[
                      Text(widget.history.theAmount.toString(),
                          style: TextStyle(fontSize: 12, color: Colors.grey)),
                      SizedBox(width: 10),
                      Text('ريال',
                          style: TextStyle(fontSize: 12, color: Colors.grey)),
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
