import 'package:flutter/material.dart';

import '../../Intro/splash_screen.dart';

class CheckConnectionScreen extends StatelessWidget {
  final bool state;

  const CheckConnectionScreen({Key key, this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Text(
                      state
                          ? "من فضلك قم بتشغيل خدمة تحديد الموقع"
                          : "من فضلك قم بتشغيل خدمة الانترنت",
                      style: TextStyle(color: Colors.black, fontSize: 16)),
                ),
                SizedBox(height: 20),
                FlatButton(
                  color: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  onPressed: () => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => Splash()),
                      (Route<dynamic> route) => false),
                  child: Text("اعد التشغيل",
                      style: TextStyle(color: Colors.white, fontSize: 14)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
