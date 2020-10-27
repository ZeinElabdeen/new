import 'package:flutter/cupertino.dart';

class BouncyPageRoute extends PageRouteBuilder{
final Widget widget;

  BouncyPageRoute({this.widget})
  : super(
    transitionDuration: Duration(seconds: 3),
    transitionsBuilder:(BuildContext context,Animation<double> animation,Animation<double> sanimation,Widget child){
     animation = CurvedAnimation(parent: animation,curve: Curves.elasticInOut);
      return ScaleTransition(
        scale: animation,
        alignment: Alignment.center,
        child: child,
      );
    },
    pageBuilder:(BuildContext context,Animation<double> animation,Animation<double> sanimation){
      return widget;
      }
  );
}