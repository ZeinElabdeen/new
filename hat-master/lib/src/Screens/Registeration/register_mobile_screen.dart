import 'package:flutter/material.dart';
import 'package:haat/src/MainWidgets/register_text_field.dart';
import 'package:provider/provider.dart';
import 'package:haat/src/MainWidgets/buttonSignIn.dart';
import 'package:haat/src/MainWidgets/image_bg.dart';
import 'package:haat/src/provider/auth/registerMobileProvider.dart';

class RegisterMobileScreen extends StatefulWidget {
  @override
  _RegisterMobileScreenState createState() => _RegisterMobileScreenState();
}

class _RegisterMobileScreenState extends State<RegisterMobileScreen> {
  final _form = GlobalKey<FormState>();
  bool autoError = false;
  @override
  Widget build(BuildContext context) {
    var register = Provider.of<RegisterMobileProvider>(context, listen: false);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Form(
        key: _form,
        autovalidate: autoError,
        child: Stack(
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Center(
                            child: Image.asset(
                          'assets/images/newLoga.png',
                          height: 100,
                          fit: BoxFit.cover,
                        )),
                        SizedBox(
                          height: 40,
                        ),
                        Center(
                            child: Text(
                          "تسجيل جديد",
                          style: TextStyle(color: Colors.black87, fontSize: 20),
                        )),
                        SizedBox(
                          height: 5,
                        ),
                        Center(
                            child: Text(
                          "فضلا قم بادخال رقم جوالك ليصلك كود التفعيل",
                          style: TextStyle(color: Colors.black87, fontSize: 13),
                          textAlign: TextAlign.center,
                        )),
                        SizedBox(
                          height:40,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        RegisterTextField(
                          hint: 'رقم الجوال',
                          icon: Icons.phone,
                          onChange: (v) {
                            register.phone = v;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SignInButton(
                            txtColor: Colors.white,
                            onPressSignIn: () {
                              setState(() {
                                autoError = true;
                              });
                              final isValid = _form.currentState.validate();
                              if (!isValid) {
                                return;
                              }
                              _form.currentState.save();

                              register.registerMobile(context);
                            },
                            btnWidth: MediaQuery.of(context).size.width,
                            btnHeight: 45,
                            btnColor: Theme.of(context).primaryColor,
                            buttonText: 'التالي',
                          ),
                        )
                      ],
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
      ),
    );
  }
}
