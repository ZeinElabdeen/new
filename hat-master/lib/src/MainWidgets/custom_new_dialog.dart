import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:haat/src/Repository/appLocalization.dart';

class CustomDialog {
  Future<dynamic> showWarningDialog(
      {BuildContext context, String msg, Function btnOnPress}) {
    return AwesomeDialog(
            headerAnimationLoop: false,
            btnOkColor: Theme.of(context).primaryColor,
            context: context,
            animType: AnimType.SCALE,
            dialogType: DialogType.NO_HEADER,
            body: Center(child: Text(msg)),
            btnOkOnPress: btnOnPress,
            btnOkText: 'موافق')
        .show();
  }

  Future<dynamic> showErrorDialog(
      {String msg,
      String ok,
      BuildContext context,
      Function btnOnPress,
      int code}) {
    return AwesomeDialog(
            headerAnimationLoop: false,
            btnOkColor: Theme.of(context).primaryColor,
            context: context,
            animType: AnimType.SCALE,
            dialogType: DialogType.NO_HEADER,
            body: Directionality(
                textDirection: localization.currentLanguage.toString() == "en"
                    ? TextDirection.ltr
                    : TextDirection.rtl,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      msg,
                      style: TextStyle(),
                    ),
                  ),
                )),
            btnOkOnPress: btnOnPress,
            btnOkText: ok)
        .show();
  }

  Future<dynamic> showSuccessDialog(
      {BuildContext context, String msg, String btnMsg, Function btnOnPress}) {
    return AwesomeDialog(
            headerAnimationLoop: false,
            btnOkColor: Theme.of(context).primaryColor,
            context: context,
            animType: AnimType.SCALE,
            dialogType: DialogType.NO_HEADER,
            body: Directionality(
                textDirection: localization.currentLanguage.toString() == "en"
                    ? TextDirection.ltr
                    : TextDirection.rtl,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      msg,
                      style: TextStyle(),
                    ),
                  ),
                )),
            btnOkOnPress: btnOnPress,
            btnOkText: btnMsg,
            aligment: Alignment.center)
        .show();
  }

  Future<dynamic> showOptionDialog(
      {BuildContext context,
      String msg,
      String okMsg,
      Function okFun,
      String cancelMsg,
      Function cancelFun}) {
    return AwesomeDialog(
            headerAnimationLoop: false,
            context: context,
            btnOkColor: Theme.of(context).primaryColor,
            animType: AnimType.SCALE,
            dialogType: DialogType.NO_HEADER,
            body: Center(child: Text(msg)),
            btnOkOnPress: okFun,
            btnOkText: okMsg,
            btnCancelOnPress: cancelFun,
            btnCancelText: cancelMsg)
        .show();
  }

  Future<dynamic> showWidgetDialog({
    BuildContext context,
    String okMsg,
    Function okFun,
    Widget body,
  }) {
    return AwesomeDialog(
      headerAnimationLoop: false,
      context: context,
      btnOkColor: Theme.of(context).primaryColor,
      animType: AnimType.SCALE,
      dialogType: DialogType.NO_HEADER,
      body: body,
      btnOkOnPress: okFun,
      btnOkText: okMsg,
    ).show();
  }
}
