import 'package:flutter/material.dart';
import 'package:haat/src/MainWidgets/register_secure_text_field.dart';
import 'package:provider/provider.dart';
import 'package:haat/src/MainWidgets/buttonSignIn.dart';
import 'package:haat/src/MainWidgets/image_bg.dart';
import 'package:haat/src/provider/auth/resetPasswordProvider.dart';

class ResetPasswordScreen extends StatefulWidget {
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _form = GlobalKey<FormState>();
bool autoError = false;
  @override
  Widget build(BuildContext context) {
    var confirmRessetCode =
        Provider.of<ResetPasswordProvider>(context, listen: false);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Form(
        autovalidate: autoError,
        key: _form,
        child: Stack(
          children: <Widget>[
            ImageBG(),
            Center(
              child: Container(
                child: ListView(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  children: <Widget>[
                    Center(
                        child: Image.asset(
                      'assets/images/newLoga.png',
                      height: 100,
                      fit: BoxFit.cover,
                    )),
                    SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'تغير كلمة المرور',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: 'cairo'),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RegisterSecureTextField(
                      icon: Icons.lock,
                      label: "كلمة المرور",
                      onChange: (v) {
                        confirmRessetCode.password = v;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RegisterSecureTextField(
                      icon: Icons.lock,
                      label: "كلمة المرور",
                      onChange: (v) {
                        confirmRessetCode.passwordConfirmation = v;
                      },
                    ),
                    SizedBox(
                      height: 20,
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
                            confirmRessetCode.resetPassword(context);
                          },
                          btnWidth: MediaQuery.of(context).size.width,
                          btnHeight: MediaQuery.of(context).size.height * .07,
                          btnColor: Theme.of(context).primaryColor,
                          buttonText: 'تأكيد',
                        )),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
