import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomOptionCard {
  Widget optionCard({String label, final icon, Function onTap,BuildContext context}) {
    return Padding(
      padding: EdgeInsets.only(top:10,right: 10,left: 10),
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[600]),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(
                    label,
                    textAlign: TextAlign.end,
                    style: TextStyle(color: Colors.black87, fontSize: 17),
                  ),
                ),
              ),
              Visibility(
                visible: icon != null,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(100))),
                    child: Image.asset(icon),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
