import 'package:flutter/material.dart';
import 'package:haat/src/MainWidgets/register_text_field.dart';
import 'package:provider/provider.dart';
import 'package:haat/src/MainWidgets/buttonSignIn.dart';
import 'package:haat/src/MainWidgets/image_bg.dart';
import 'package:haat/src/provider/auth/forgetPasswordProvider.dart';

class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  @override
  void initState() {
    super.initState();
  }

  final _form = GlobalKey<FormState>();
bool autoError = false;
  @override
  Widget build(BuildContext context) {
    var forgetPassword =
        Provider.of<ForgetPasswordProvider>(context, listen: false);
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
                    height: MediaQuery.of(context).size.height,
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
                          height: 10,
                        ),
                        Center(
                            child: Text(
                          "فضلا ادخل رقم الجوال",
                          style: TextStyle(color: Colors.black87, fontSize: 20),
                        )),
                        SizedBox(
                          height: 5,
                        ),
                        Center(
                            child: Text(
                          "لاستعادة كلمة المرور",
                          style: TextStyle(color: Colors.black87, fontSize: 15),
                        )),
                        SizedBox(
                          height: 50,
                        ),
                        RegisterTextField(
                          hint: 'رقم الجوال',
                          icon: Icons.phone,
                          onChange: (v) {
                            forgetPassword.phone = v;
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
                              forgetPassword.forgetPassword(context);
                            },
                            btnWidth: MediaQuery.of(context).size.width,
                            btnHeight: 45,
                            btnColor: Theme.of(context).primaryColor,
                            buttonText: 'ارسال',
                          ),
                        ),
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
