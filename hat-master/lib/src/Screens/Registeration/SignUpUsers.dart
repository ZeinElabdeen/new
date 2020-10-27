import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:haat/src/Helpers/map_helper.dart';
import 'package:haat/src/MainWidgets/buttonSignIn.dart';
import 'package:haat/src/MainWidgets/image_bg.dart';
import 'package:haat/src/Helpers/sharedPref_helper.dart';
import 'package:haat/src/MainWidgets/custom_alert.dart';
import 'package:haat/src/MainWidgets/labeled_bottom_sheet.dart';
import 'package:haat/src/MainWidgets/register_secure_text_field.dart';
import 'package:haat/src/MainWidgets/register_text_field.dart';
import 'package:haat/src/MainWidgets/terms_dialog.dart';
import 'package:haat/src/Screens/HomePages/Apis/App/app_event.dart';
import 'package:haat/src/Screens/HomePages/Apis/BLoCs/AuthBLoCs/terms_bloc.dart';
import 'package:haat/src/provider/auth/UserSignProvider.dart';
import 'package:haat/src/provider/auth/loginProvider.dart';
import 'package:haat/src/provider/get/RegionsProvider.dart';
import 'package:haat/src/provider/get/citiesProvider.dart';
import 'package:haat/src/provider/termsProvider.dart';
import 'package:provider/provider.dart';

class SignUpUsers extends StatefulWidget {
  @override
  _SignUpUsersState createState() => _SignUpUsersState();
}

class _SignUpUsersState extends State<SignUpUsers> {
  bool _accept = false;
  FirebaseMessaging _fcm = FirebaseMessaging();
  String _deviceToken;
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    Provider.of<MapHelper>(context, listen: false).getLocation();
    Provider.of<TermsProvider>(context, listen: false).getTerms();
    _fcm.getToken().then((response) {
      setState(() {
        _deviceToken = response;
      });
      print('The device Token is :' + _deviceToken);
    });
    super.initState();
    Provider.of<RegionsProvider>(context, listen: false).getRegions();
    termsBloc.add(GetTerms());
  }

  bool city = false;
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
            ListView(
              children: <Widget>[
                SizedBox(
                  height: 40,
                ),
                Center(
                    child: Image.asset(
                  'assets/images/newLoga.png',
                  height: 100,
                  fit: BoxFit.cover,
                )),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .1,
                ),
                SizedBox(height: 20),
                RegisterTextField(
                  icon: Icons.person,
                  onChange: (v) {
                    Provider.of<SignUpUserProvider>(context, listen: false)
                        .name = v;
                  },
                  label: 'الاسم',
                  type: TextInputType.text,
                ),
                SizedBox(height: 20),
                RegisterTextField(
                  icon: Icons.mail,
                  onChange: (v) {
                    Provider.of<SignUpUserProvider>(context, listen: false)
                        .email = v;
                  },
                  label: 'الايميل',
                  type: TextInputType.text,
                ),
                SizedBox(height: 20),
                RegisterSecureTextField(
                  onChange: (v) {
                    Provider.of<SignUpUserProvider>(context, listen: false)
                        .password = v;
                  },
                  label: "كلمة المرور",
                  icon: Icons.lock,
                ),
                SizedBox(height: 20),
                RegisterSecureTextField(
                  onChange: (v) {
                    Provider.of<SignUpUserProvider>(context, listen: false)
                        .passwordConfirmation = v;
                  },
                  icon: Icons.lock,
                  label: 'تأكيد كلمة المرور',
                ),
                LabeledBottomSheet(
                  label: '-- إختر المنطقة --',
                  onChange: (v) {
                    Provider.of<CitiesProvider>(context, listen: false)
                        .getCities(v.id.toString());
                    setState(() {
                      city = true;
                    });
                  },
                  data: Provider.of<RegionsProvider>(context, listen: true)
                      .bottomSheet,
                ),
                LabeledBottomSheet(
                  label: '-- إختر المدينة --',
                  onChange: (v) {
                    Provider.of<SignUpUserProvider>(context, listen: false)
                        .cityId = v.id.toString();
                    setState(() {
                      city = true;
                    });
                  },
                  ontap: city,
                  data: Provider.of<CitiesProvider>(context, listen: true)
                      .cotiesSheet,
                ),
                SizedBox(height: 20),
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
                      style: TextStyle(color: Theme.of(context).primaryColor),
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
                        Provider.of<LoginProvider>(context, listen: false)
                            .type = 1;
                        Provider.of<SignUpUserProvider>(context, listen: false)
                            .signUp(_deviceToken, context)
                            .then((v) {
                          if (v != null) {
                            Provider.of<SharedPref>(context, listen: false)
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
          ],
        ),
      ),
    );
  }
}
