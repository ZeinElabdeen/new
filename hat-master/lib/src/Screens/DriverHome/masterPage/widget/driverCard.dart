import 'package:flutter/material.dart';

class DriverCard extends StatefulWidget {
  final int index ;
  final Function ontap;

  const DriverCard({Key key, this.index, this.ontap}) : super(key: key);
  @override
  _DriverCardState createState() => _DriverCardState();
}

class _DriverCardState extends State<DriverCard> {
  @override
  Widget build(BuildContext context) {
    return  Center(
           child: InkWell(
             onTap: widget.ontap,
             child: Container(
                  width: MediaQuery.of(context).size.width/3,
                  height: MediaQuery.of(context).size.width/3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Theme.of(context).primaryColor
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(icons[widget.index],size: 50,color: Colors.white,),
                      SizedBox(
                        height: 5,
                      ),
                      Text(title[widget.index],style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)
                    ],
                  ),
                ),
           ),
         );
  }
  List<String> title = [
    "طلباتي",
    "عمولاتي",
    "محفظتي",
    "المحادثات",
  ];
  List<IconData> icons = [
    Icons.folder,

    Icons.attach_money,
    Icons.attachment,
    Icons.chat
  ];
}