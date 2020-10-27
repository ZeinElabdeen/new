import 'package:flutter/material.dart';
import 'package:haat/src/Repository/appLocalization.dart';

class LocationTextField extends StatefulWidget {
  final Function onChange;

  const LocationTextField({Key key, this.onChange}) : super(key: key);

  @override
  _LocationTextFieldState createState() => _LocationTextFieldState();
}

class _LocationTextFieldState extends State<LocationTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(right: 10, left: 10),
        child: Directionality(
          textDirection: localization.currentLanguage == "ar"
              ? TextDirection.rtl
              : TextDirection.ltr,
          child: TextField(
            minLines: 2,
            onChanged: widget.onChange,
            maxLines: 2,
            textAlign: localization.currentLanguage == "ar"
                ? TextAlign.right
                : TextAlign.left,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: 'تفاصيل العنوان (إختياري)',
              hintText: 'اسم البرج السكني، رقم الدور، رقم الشقة',
              contentPadding: EdgeInsets.only(top: 20, right: 10, left: 10),
              border: new OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
            ),
          ),
        ));
  }
}
