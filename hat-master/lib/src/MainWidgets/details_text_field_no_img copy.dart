import 'package:flutter/material.dart';

class DetailsTextFieldNoImg extends StatefulWidget {
  final String label;
  final String hint;
  final Function onChange;
  final String errorText;

  const DetailsTextFieldNoImg(
      {Key key, this.label, this.hint, this.onChange, this.errorText})
      : super(key: key);

  @override
  _DetailsTextFieldNoImgState createState() => _DetailsTextFieldNoImgState();
}

class _DetailsTextFieldNoImgState extends State<DetailsTextFieldNoImg> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(right: 10, left: 10),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: TextFormField(
            minLines: 4,
            onChanged: widget.onChange,
            maxLines: 4,
            validator: (value) {
              if (value.isEmpty) {
                return "${widget.hint == null ? widget.label : widget.hint} مطلوب";
              }
              return null;
            },
            textAlign: TextAlign.right,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: widget.hint,
              errorText: widget.errorText ?? null,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              labelText: widget.label,
              contentPadding: EdgeInsets.only(top: 20, right: 10),
              border: new OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
            ),
          ),
        ));
  }
}
