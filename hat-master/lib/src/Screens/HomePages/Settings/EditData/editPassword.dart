import 'package:flutter/material.dart';
import 'package:haat/src/MainWidgets/register_secure_text_field.dart';
import 'package:provider/provider.dart';
import 'package:haat/src/MainWidgets/buttonSignIn.dart';
import 'package:haat/src/provider/changeData/changePasswordProvider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditPassword extends StatefulWidget {
  @override
  _EditPasswordState createState() => _EditPasswordState();
}

class _EditPasswordState extends State<EditPassword> {
  SharedPreferences _preferences;
  _getShared() async {
    _preferences = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    _getShared();
    // Provider.of<ChangePasswordProvider>(context, listen: false).context =
    //     context;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ListView(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          children: <Widget>[
            // InputFieldArea(
            //   hint: 'كلمة المرور القديمه',
            //   border: false,
            //   show: true,
            //   textInputType: TextInputType.text,
            //   changedFunction: (v) {
            //     Provider.of<ChangePasswordProvider>(context, listen: false)
            //         .oldPassword = v;
            //   },
            //   hegt: 45,
            // ),
            // InputFieldArea(
            //   changedFunction: (v) {
            //     Provider.of<ChangePasswordProvider>(context, listen: false)
            //         .password = v;
            //   },
            //   hint: 'كلمة المرور الجديده',
            //   border: false,
            //   show: true,
            //   textInputType: TextInputType.text,
            //   hegt: 45,
            // ),
            // InputFieldArea(
            //   changedFunction: (v) {
            //     Provider.of<ChangePasswordProvider>(context, listen: false)
            //         .passwordConfirmation = v;
            //   },
            //   hint: 'تاكيد كلمة المرور الجديده',
            //   border: false,
            //   show: true,
            //   textInputType: TextInputType.text,
            //                   hegt: 45,

            // ),
            RegisterSecureTextField(
              icon: Icons.lock,
              label: "كلمة المرور",
              onChange: (v) {
                Provider.of<ChangePasswordProvider>(context, listen: false)
                    .oldPassword = v;
              },
            ),
            SizedBox(height: 20),
            RegisterSecureTextField(
              icon: Icons.lock,
              label: 'كلمة المرور الجديده',
              onChange: (v) {
                Provider.of<ChangePasswordProvider>(context, listen: false)
                    .password = v;
              },
            ),
            SizedBox(height: 20),
            RegisterSecureTextField(
              icon: Icons.lock,
              label: 'تاكيد كلمة المرور الجديده',
              onChange: (v) {
                Provider.of<ChangePasswordProvider>(context, listen: false)
                    .passwordConfirmation = v;
              },
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: SignInButton(
                txtColor: Colors.white,
                onPressSignIn: () {
                  Provider.of<ChangePasswordProvider>(context, listen: false)
                      .changePassword(_preferences.get("token"), context);
                },
                btnWidth: MediaQuery.of(context).size.width - 40,
                btnHeight: 45,
                btnColor: Theme.of(context).primaryColor,
                buttonText: 'تعديل',
              ),
            ),
            SizedBox(
              height: 40,
            ),
          ],
        ),
      ],
    );
  }
}
