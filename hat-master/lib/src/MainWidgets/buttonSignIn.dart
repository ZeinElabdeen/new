import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SignInButton extends StatelessWidget {
  final Function onPressSignIn;
  final String buttonText;
  final IconData iconData;
  final Color btnColor;
  final Color txtColor;
  final Color iColor;
  final double btnWidth;
  final double textSize;
  final double btnHeight;
  final bool load;

  SignInButton(
      {this.onPressSignIn,
      this.buttonText,
      this.iconData,
      this.btnColor,
      this.iColor,
      this.txtColor,
      this.btnHeight,
      this.btnWidth,
      this.textSize,
      this.load = false});

  @override
  Widget build(BuildContext context) {
    if (load) {
      return Center(
        child: SpinKitFadingCircle(
          size: 30,
          color: Theme.of(context).primaryColor,
        ),
      );
    } else
      return InkWell(
        onTap: onPressSignIn,
        child: Container(
            width: btnWidth,
            height: btnHeight,
            alignment: FractionalOffset.center,
            decoration: new BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: btnColor != null
                      ? [btnColor, btnColor]
                      : [
                          Theme.of(context).primaryColor,
                          Theme.of(context).accentColor
                        ]),
              borderRadius: new BorderRadius.circular(20.0),
            ),
            child: Stack(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    MaterialButton(
                      onPressed: onPressSignIn,
                      elevation: 2,
                      child: Text(
                        buttonText,
                        style: TextStyle(
                          fontFamily: 'cairo',
                          color: txtColor,
                          fontSize: textSize != null ? textSize : 16.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: iconData != null,
                      child: Icon(
                        iconData,
                        color: iColor,
                      ),
                    )
                  ],
                )
              ],
            )),
      );
  }
}
