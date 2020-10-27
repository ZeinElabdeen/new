import 'package:flutter/material.dart';

class AppLoader extends StatefulWidget {
   final String title;

  const AppLoader({Key key, this.title}) : super(key: key);
  @override
  _AppLoaderState createState() => _AppLoaderState();
}

class _AppLoaderState extends State<AppLoader> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Image.asset('assets/images/loading.gif'),
          // child: Text("تحميل..."),
        ),
          SizedBox(height: 20),
        Text(widget.title ?? '',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 17, color: Colors.grey))
      ],
    );
  }
}
