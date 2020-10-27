import 'dart:io';

import 'package:flutter/material.dart';
import 'package:haat/src/Helpers/image_picker_dialog.dart';
import 'package:haat/src/Repository/appLocalization.dart';

class DetailsTextField extends StatefulWidget {
  final String label;
  final String hint;
  final String errorText;
  final Function onChange;
  final ValueChanged<File> onImg;
  final String init;

  const DetailsTextField(
      {Key key,
      this.label,
      this.hint,
      this.errorText,
      this.onChange,
      this.onImg, this.init})
      : super(key: key);

  @override
  _DetailsTextFieldState createState() => _DetailsTextFieldState();
}

class _DetailsTextFieldState extends State<DetailsTextField> {
  File _mainImg;

  Widget _showMainImg() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Stack(
        children: <Widget>[
          Container(
            height: 200,
            width: MediaQuery.of(context).size.width,
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.file(
                  _mainImg,
                  alignment: Alignment.center,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            child: InkWell(
              onTap: () {
                setState(() {
                  _mainImg = null;
                });
              },
              child: Icon(
                Icons.delete,
                color: Colors.red,
                size: 30,
              ),
            ),
            bottom: 10,
            left: 10,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10, left: 10),
      child: ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Directionality(
              textDirection: localization.currentLanguage == "ar"
                  ? TextDirection.rtl
                  : TextDirection.ltr,
              child: TextFormField(
                minLines: 4,
                onChanged: widget.onChange,
                maxLines: 4,
                initialValue: widget.init,
                textAlign: localization.currentLanguage == "ar"
                    ? TextAlign.right
                    : TextAlign.left,
                validator: (value) {
                  if (value.isEmpty) {
                    return "${widget.label} مطلوب";
                  }
                  return null;
                },
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: widget.hint,
                  errorText: widget.errorText,
                  labelText: widget.label,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  suffixIcon: InkWell(
                    onTap: () => ImagePickerDialog().show(
                        context: context,
                        onGet: (v) {
                          widget.onImg(v);
                          setState(() {
                            _mainImg = v;
                          });
                        }),
                    child: Icon(Icons.camera_alt),
                  ),
                  contentPadding: EdgeInsets.only(top: 20, right: 10, left: 20),
                  border: new OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          _mainImg == null ? Container() : _showMainImg()
        ],
      ),
    );
  }
}
