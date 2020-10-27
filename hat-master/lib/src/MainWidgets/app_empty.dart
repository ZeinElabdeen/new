import 'package:flutter/material.dart';

class AppEmpty extends StatefulWidget {
  final String text;

  const AppEmpty({Key key, this.text}) : super(key: key);

  @override
  _AppEmptyState createState() => _AppEmptyState();
}

class _AppEmptyState extends State<AppEmpty> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset('assets/images/empty.gif'),
        SizedBox(height: 20),
        Text(widget.text,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 17, color: Colors.grey))
      ],
    );
  }
}
