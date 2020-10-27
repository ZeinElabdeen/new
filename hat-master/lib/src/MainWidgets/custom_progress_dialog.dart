import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:progress_dialog/progress_dialog.dart';

class CustomProgressDialog {
  final context;

  ProgressDialog pr;

  CustomProgressDialog({this.context, this.pr});

  void showProgressDialog() {
    pr = new ProgressDialog(
        context,
        isDismissible: false, 
        type: ProgressDialogType.Normal);
    pr.style(message: 'Showing some progress...');
    pr.style(
      message: '              يرجى الانتظار',
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      progressWidget: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SpinKitThreeBounce(
          color: Theme.of(context).primaryColor,
          size: 25,
        ),
      ),
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
      progressTextStyle: TextStyle(
          color: Theme.of(context).primaryColor,
          fontSize: 8.0,
          fontFamily: 'cairo',
          fontWeight: FontWeight.w400),
      messageTextStyle: TextStyle(
          color: Theme.of(context).primaryColor,
          fontSize: 15.0,
          fontFamily: 'cairo',
          fontWeight: FontWeight.w600),
    );
  }

  showPr() {
    pr.show();
  }

  hidePr() {
    pr.hide();
  }
}
