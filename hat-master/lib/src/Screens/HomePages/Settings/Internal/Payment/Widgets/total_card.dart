import 'package:flutter/material.dart';

class TotalCard extends StatelessWidget {
  final int total;

  const TotalCard({Key key, this.total}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: EdgeInsets.only(top: 20, right: 20, left: 20),
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'الإجمالي',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(width: 20),
                Text(
                  total.toString(),
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(width: 10),
                Text(
                  'ريال',
                  style: TextStyle(
                      fontSize: 20, color: Theme.of(context).primaryColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
