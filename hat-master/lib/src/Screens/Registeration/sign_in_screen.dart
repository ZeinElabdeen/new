import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:haat/src/Helpers/map_helper.dart';
import 'package:haat/src/Helpers/sharedPref_helper.dart';
import 'package:haat/src/MainWidgets/register_secure_text_field.dart';
import 'package:haat/src/MainWidgets/register_text_field.dart';
import 'package:haat/src/MainWidgets/buttonSignIn.dart';
import 'package:haat/src/MainWidgets/customBtn.dart';
import 'package:haat/src/MainWidgets/image_bg.dart';
import 'package:haat/src/Screens/Registeration/forgetPassword.dart';
import 'package:haat/src/provider/auth/loginProvider.dart';
import 'package:provider/provider.dart';
import '../../provider/auth/loginProvider.dart';
import 'register_mobile_screen.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  FirebaseMessaging _fcm = FirebaseMessaging();
  String _deviceToken;
  final _form = GlobalKey<FormState>();
  bool autoError = false;
  @override
  void initState() {
     Provider.of<MapHelper>(context, listen: false).getLocation();
    _fcm.getToken().then((response) {
      setState(() {
        _deviceToken = response;
      });
      print('The device Token is :' + _deviceToken);
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var loginProvider = Provider.of<LoginProvider>(context, listen: false);

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
                      height: MediaQuery.of(context).size.height * .95,
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
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
                            height: MediaQuery.of(context).size.height * .1,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 4.0),
                                child: Text(
                                  "تسجيل الدخول",
                                  style: TextStyle(
                                      color: Colors.black87, fontSize: 20),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          RegisterTextField(
                            hint: 'رقم الجوال',
                            icon: Icons.phone,
                            onChange: (v) {
                              loginProvider.phone = v;
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          RegisterSecureTextField(
                            icon: Icons.lock,
                            label: "كلمة المرور",
                            onChange: (v) {
                              loginProvider.password = v;
                            },
                          ),
                          Center(
                            child: FlatButton(
                              child: Text('نسيت كلمة المرور ',
                                  style: TextStyle(color: Colors.black)),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => ForgetPassword()));
                              },
                            ),
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
                                loginProvider
                                    .login(_deviceToken, context)
                                    .then((v) {
                                  if (v != null) {
                                    Provider.of<SharedPref>(context,
                                            listen: false)
                                        .getSharedHelper(v);
                                  }
                                });
                              },
                              btnWidth: MediaQuery.of(context).size.width,
                              btnHeight: 45,
                              btnColor: Theme.of(context).primaryColor,
                              buttonText: 'دخول',
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomBtn(
                              txtColor: Colors.white,
                              heigh: 45,
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => RegisterMobileScreen()));
                              },
                              color: Colors.grey[600],
                              text: 'تسجيل جديد',
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
