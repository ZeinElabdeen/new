import 'package:flutter/material.dart';

class RegisterTextField extends StatefulWidget {
  final String label;
  final IconData icon;
  final TextInputType type;
  final String hint;
  final String errorText;
  final Function onChange;
  final Function error;
  final String init;

  const RegisterTextField(
      {Key key,
      this.icon,
      this.label,
      this.type,
      this.hint,
      this.errorText,
      this.onChange,
      this.error, this.init})
      : super(key: key);

  @override
  _RegisterTextFieldState createState() => _RegisterTextFieldState();
}

class _RegisterTextFieldState extends State<RegisterTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(right: 10, left: 10),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: TextFormField(
            initialValue: widget.init,
            textAlign: TextAlign.right,
            keyboardType:widget.hint ==  'رقم الجوال'? TextInputType.number : widget.type,
            onChanged: widget.onChange,
            validator: (value) {
              if (value.isEmpty) {
                return "${widget.hint == null ? widget.label : widget.hint } مطلوب";
              }
              return null;
            },
            decoration: InputDecoration(
              prefixIcon: widget.icon != null
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 1,
                        child: Icon(
                          widget.icon,
                          size: 15,
                          color: Colors.white,
                        ),
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                    )
                  : null,
              labelText: widget.label,
              // errorText: widget.errorText ?? null,
              hintText: widget.hint == null ? '' : widget.hint,
              contentPadding: EdgeInsets.only(top: 20, right: 10),
              border: new OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
              ),
            ),
          ),
        ));
  }
}
