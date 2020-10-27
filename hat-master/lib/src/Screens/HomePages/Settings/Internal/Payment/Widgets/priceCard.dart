import 'package:flutter/material.dart';

class PriceCard extends StatelessWidget {
  final String title;
  final String price;

  const PriceCard({Key key, this.title, this.price}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width / 2.5,
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20))),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: Text(
                title,
                style: TextStyle(color: Colors.white),
              )),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 2.5,
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: Text("$price ريال")),
            ),
          ),
        ],
      ),
    );
  }
}
