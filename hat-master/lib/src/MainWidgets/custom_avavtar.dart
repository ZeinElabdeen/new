import 'dart:io';

// import 'package:haat_provider/Helpers/image_picker_dialog.dart';
import 'package:flutter/material.dart';
import 'package:haat/src/Helpers/image_picker_dialog.dart';

class CustomAvatar extends StatefulWidget {
  final ValueChanged<File> onGet;

  const CustomAvatar({Key key, this.onGet}) : super(key: key);

  @override
  _CustomAvatarState createState() => _CustomAvatarState();
}

class _CustomAvatarState extends State<CustomAvatar> {
  ImageProvider _provider = AssetImage('assets/images/avatar.jpeg');

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(children: <Widget>[
        CircleAvatar(radius: 50, backgroundImage: _provider),
        InkWell(
            onTap: () => ImagePickerDialog().show(
                context: context,
                onGet: (value) {
                  print('Image:' + value.toString());
                  setState(() {
                    _provider = Image.file(value).image;
                  });
                  widget.onGet(value);
                }),
            child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 70, 0, 0),
                child: Container(
                    height: 30,
                    width: 30,
                    child: Material(
                        color: Theme.of(context).primaryColor,
                        shape: CircleBorder(),
                        child: Icon(Icons.camera_alt,
                            color: Colors.white, size: 20)))))
      ]),
    );
  }
}
