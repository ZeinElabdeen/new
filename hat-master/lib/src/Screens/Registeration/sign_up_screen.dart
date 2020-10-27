import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:haat/src/Helpers/map_helper.dart';
import 'package:haat/src/MainWidgets/buttonSignIn.dart';
import 'package:haat/src/MainWidgets/image_bg.dart';
import 'package:haat/src/Helpers/sharedPref_helper.dart';
// import 'package:haat/src/Components/registerTextField.dart';
import 'package:haat/src/MainWidgets/custom_alert.dart';
import 'package:haat/src/MainWidgets/custom_avavtar.dart';
import 'package:haat/src/MainWidgets/register_secure_text_field.dart';
import 'package:haat/src/MainWidgets/register_text_field.dart';
import 'package:haat/src/MainWidgets/terms_dialog.dart';
import 'package:haat/src/provider/auth/loginProvider.dart';
import 'package:haat/src/provider/auth/signUpProvider.dart';
import 'package:haat/src/provider/get/CarTypeProvider.dart';
import 'package:haat/src/provider/get/IdentityTypeProvider.dart';
import 'package:haat/src/provider/get/NationalitiesProvider.dart';
import 'package:haat/src/provider/get/RegionsProvider.dart';
import 'package:haat/src/provider/get/departmentsProvider.dart';
import 'package:haat/src/provider/termsProvider.dart';
import 'package:provider/provider.dart';
import 'documents.dart';
import 'driverDaitels.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _accept = false;

  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  FirebaseMessaging _fcm = FirebaseMessaging();
  String _deviceToken;
  @override
  void initState() {
     Provider.of<MapHelper>(context, listen: false).getLocation();
    Provider.of<CarTypeProvider>(context, listen: false).getCarsType();
    Provider.of<DepartMentProvider>(context, listen: false).getDepartements();
    Provider.of<IdentituTypeProvider>(context, listen: false).getIdentities();
    Provider.of<NationalitiesProvider>(context, listen: false).getNationalities();
    Provider.of<TermsProvider>(context, listen: false).getTerms();
    Provider.of<RegionsProvider>(context, listen: false).getRegions();
    _fcm.getToken().then((response) {
      setState(() {
        _deviceToken = response;
      });

      print('The device Token is :' + _deviceToken);
    });
    super.initState();
  }

  final _form = GlobalKey<FormState>();
bool autoError = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        key: _globalKey,
        resizeToAvoidBottomInset: true,
        body: Form(
          key: _form,
          autovalidate: autoError,
          child: Stack(
            children: <Widget>[
              ImageBG(),
              SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 40,
                    ),
                    CustomAvatar(onGet: (v) {
                      Provider.of<SignUpProvider>(context, listen: false).photo = v;
                    }),
                    SizedBox(height: 20),
                    RegisterTextField(
                      icon: Icons.person,
                      onChange: (v) {
                        Provider.of<SignUpProvider>(context, listen: false)
                            .name = v;
                      },
                      label: 'الاسم',
                      type: TextInputType.text,
                    ),
                    SizedBox(height: 20),
                    RegisterTextField(
                      icon: Icons.mail,
                      onChange: (v) {
                        Provider.of<SignUpProvider>(context, listen: false)
                            .email = v;
                      },
                      label: 'الايميل',
                      type: TextInputType.text,
                    ),
                    SizedBox(height: 20),
                    RegisterSecureTextField(
                      onChange: (v) {
                        Provider.of<SignUpProvider>(context, listen: false)
                            .password = v;
                      },
                      label: "كلمة المرور",
                      icon: Icons.lock,
                    ),
                    SizedBox(height: 20),
                    RegisterSecureTextField(
                      onChange: (v) {
                        Provider.of<SignUpProvider>(context, listen: false)
                            .passwordConfirmation = v;
                      },
                      label: 'تأكيد كلمة المرور',
                      icon: Icons.lock,
                    ),
                    SizedBox(height: 20),
                    DriverDaitels(),
                    Documents(),
                    CheckboxListTile(
                      value: _accept,
                      onChanged: (value) {
                        setState(() {
                          _accept = !_accept;
                        });
                      },
                      activeColor: Theme.of(context).primaryColor,
                      checkColor: Colors.white,
                      dense: true,
                      title: InkWell(
                        onTap: () => TermsDialog().show(context: context),
                        child: Text(
                          'اوافق على الشروط والأحكام',
                          textAlign: TextAlign.right,
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
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
                          if (_accept == false) {
                            CustomAlert().toast(
                                context: context,
                                title: 'يجب الموافقة على الشروط والأحكام');
                          } else {
                             Provider.of<LoginProvider>(context, listen: false).type = 2;
                            Provider.of<SignUpProvider>(context, listen: false)
                                .signUp(_deviceToken, context).then((v) {
                                  if (v != null) {
                                    Provider.of<SharedPref>(context,
                                            listen: false)
                                        .getSharedHelper(v);
                                  }
                                });
                          }
                        },
                        btnWidth: MediaQuery.of(context).size.width,
                        btnHeight: MediaQuery.of(context).size.height * .07,
                        btnColor: Theme.of(context).primaryColor,
                        buttonText: 'تسجيل',
                      ),
                    ),
                    SizedBox(height: 50),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
