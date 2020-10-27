import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'custom_btn.dart';

class LoaderButton extends StatelessWidget {
  final bool load;
  final String text;
  final Function onTap;
  final Color color;
  final Color txtColor;

  const LoaderButton(
      {Key key, this.load, this.text, this.onTap, this.color, this.txtColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (load) {
      return Center(
        child: SpinKitFadingCircle(
          size: 30,
          color: Theme.of(context).primaryColor,
        ),
      );
    } else {
      return CustomBtn(
        color: color,
        onTap: onTap,
        text: text,
        txtColor: txtColor,
      );
    }
  }
}
