import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

import 'customBtn.dart';

class CustomDialog {
  Future<dynamic> showWarningDialog(
      {BuildContext context, String msg, Function btnOnPress}) {
    return AwesomeDialog(
            context: context,
            animType: AnimType.SCALE,
            dialogType: DialogType.WARNING,
            body: Center(child: Text(msg)),
            btnOkOnPress: btnOnPress,
            btnOkText: 'موافق')
        .show();
  }
  show({String msg, String btnMsg, Function onClick, BuildContext context}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            backgroundColor: Colors.white,
            elevation: 5,
            contentPadding: EdgeInsets.all(10),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  msg,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(right: 10, left: 20),
                child: Container(
                  height: 40,
                  child: CustomBtn(onTap: onClick, text: btnMsg,
                  color: Theme.of(context).primaryColor,
                  txtColor: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 10),
            ],
          );
        });
  }
}
