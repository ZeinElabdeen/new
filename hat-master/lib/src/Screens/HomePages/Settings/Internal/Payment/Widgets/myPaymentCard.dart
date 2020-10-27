import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyPaymentCard extends StatefulWidget {
  final int type ;

  const MyPaymentCard({Key key, this.type}) : super(key: key);
  @override
  _MyPaymentCardState createState() => _MyPaymentCardState();
}

class _MyPaymentCardState extends State<MyPaymentCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, right: 8, left: 8),
      child: InkWell(
        onTap: () {},
        child: Column(
          children: <Widget>[
               Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20)),
                color: Colors.grey[300],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text("رقم الطالب :686868"),
                  Text(""),
                    Text("12/05/2020"),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 9,
              decoration: BoxDecoration(
                 //border: Border.all(color: Colors.black),
                //  borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          "السعر",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "250",
                          style: TextStyle(
                              fontSize: 30,
                              color: Theme.of(context).primaryColor),
                        ),
                        Text(
                          "ريال سعودي",
                          style: TextStyle(
                              fontSize: 10,
                              color: Theme.of(context).primaryColor),
                        ),
                      ],
                    ),
                  ),
                  Text(""),
                  // Container(
                  //   width: 1,
                  //   height: MediaQuery.of(context).size.height / 7,
                  //   color: Colors.grey,
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Text("عنوان الطلب واسمه"),
                        ),
                        Text(
                          "اسم مزود الخدمة",
                          style:
                              TextStyle(fontSize: 10, color: Colors.grey),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Visibility(
              visible: widget.type != 1,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 1,
                color: Colors.grey[200],
              ),
            ),
            Visibility(
              visible: widget.type == 1,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20)),
                  color: Colors.grey[300],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text("250 ريال سعودي"),
                    Text("العمولة المستخدمة"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
