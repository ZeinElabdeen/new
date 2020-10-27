import 'package:flutter/material.dart';
import 'package:haat/src/MainWidgets/buttonSignIn.dart';
import 'package:haat/src/MainWidgets/image_bg.dart';

import 'SignUpUsers.dart';
import 'sign_up_screen.dart';

class UserType extends StatefulWidget {
  @override
  _UserTypeState createState() => _UserTypeState();
}

class _UserTypeState extends State<UserType> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: <Widget>[
          ImageBG(),
          ListView(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            children: <Widget>[
              Center(
                child: Container(
                  height: MediaQuery.of(context).size.height * .9,
                  alignment: Alignment.center,
                  child: Form(
                    autovalidate: true,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Center(
                            child: Image.asset(
                          'assets/images/newLoga.png',
                          height: 150,
                          fit: BoxFit.cover,
                        )),
                        SizedBox(
                          height: 50,
                        ),
                        Center(
                            child: Text(
                          "فضلا",
                          style: TextStyle(color: Colors.black87, fontSize: 20),
                        )),
                        SizedBox(
                          height: 5,
                        ),
                        Center(
                            child: Text(
                          "اختر نوع الحساب",
                          style: TextStyle(color: Colors.black87, fontSize: 13),
                          textAlign: TextAlign.center,
                        )),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .15,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SignInButton(
                            txtColor: Colors.white,
                            onPressSignIn: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => SignUpUsers()));
                            },
                            btnWidth: MediaQuery.of(context).size.width,
                            btnHeight: MediaQuery.of(context).size.height * .07,
                            btnColor: Theme.of(context).primaryColor,
                            buttonText: 'حساب مستخدم',
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SignInButton(
                            txtColor: Colors.white,
                            onPressSignIn: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => SignUpScreen( )));
                            },
                            btnWidth: MediaQuery.of(context).size.width,
                            btnHeight: MediaQuery.of(context).size.height * .07,
                            btnColor: Theme.of(context).primaryColor,
                            buttonText: 'حساب كابتن',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 40,
            left: 20,
            child: IconButton(
              onPressed: () {
                FocusScope.of(context).requestFocus(FocusNode());
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black87,
              ),
            ),
          )
        ],
      ),
    );
  }
}
