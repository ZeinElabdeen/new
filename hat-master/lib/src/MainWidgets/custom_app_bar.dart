import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String label;
  final GestureTapCallback onTap;
  final IconData iconData;

  CustomAppBar({this.label, this.onTap, this.iconData});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      centerTitle: true,
      backgroundColor: Theme.of(context).primaryColor,
      leading: iconData != null
          ? Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: InkWell(
                onTap: onTap,
                child: Icon(
                  iconData,
                  size: 23,
                  color: Colors.white,
                ),
              ),
            )
          : SizedBox(
              height: 20,
              width: 20,
            ),
      title: Text(
        label,
        style: TextStyle(color: Colors.white, fontSize: 18),
        textAlign: TextAlign.center,
      ),
      actions: <Widget>[
//        Padding(
//          padding: const EdgeInsets.only(right: 10),
//          child: Image.asset('assets/sign.png',
//              height: 30, width: 30, fit: BoxFit.contain),
//        ),
      ],
    );
  }
}
