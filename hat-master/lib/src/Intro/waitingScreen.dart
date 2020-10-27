import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:haat/src/MainWidgets/image_bg.dart';
import 'package:haat/src/Screens/Registeration/sign_in_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WaitingAccepting extends StatefulWidget {
  @override
  _WaitingAcceptingState createState() => _WaitingAcceptingState();
}

class _WaitingAcceptingState extends State<WaitingAccepting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: <Widget>[
          ImageBG(),
          Center(
            child: Text("تم ارسال البيانات وفي انتظار الرد عليها من الادارة"),
          ),
          Positioned(
            top: 40,
            left: 20,
            child: InkWell(
              onTap: () async{
                 var _instance = await SharedPreferences.getInstance();
                  _instance.clear();
                  Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignInScreen(),
                  ),
                  (Route<dynamic> route) => false,
                );
              },
              child: Row(
                children: <Widget>[
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: IconButton(
                      onPressed: () {
                        // FocusScope.of(context).requestFocus(FocusNode());
                        // Navigator.of(context).pop();
                      },
                      icon: Icon(
                        FontAwesomeIcons.signOutAlt,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  Text("تسجيل خروج"),

                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
