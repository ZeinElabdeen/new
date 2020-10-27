import 'dart:io';

import 'package:flutter/material.dart';
import 'package:haat/src/provider/auth/signUpProvider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:haat/src/MainWidgets/custom_image_getter.dart';
import 'package:provider/provider.dart';

class Documents extends StatefulWidget {
  @override
  _DocumentsState createState() => _DocumentsState();
}

class _DocumentsState extends State<Documents> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: 20),
        GetImage().showMainImg(
          context: context,
          deleteImage: () {
            setState(() {
              _mainImg = null;
            });
          },
          cameraBtn: _cameraBtn(
              onTap: () => _getMainImg(ImageSource.gallery, 0),
              icon: Icons.camera_alt,
              label: "الهوية او الاقامة"),
          mainImg: _mainImg,
        ),
        SizedBox(height: 20),
        GetImage().showMainImg(
          context: context,
          deleteImage: () {
            setState(() {
              _idImg = null;
            });
          },
          cameraBtn: _cameraBtn(
              onTap: () => _getMainImg(ImageSource.gallery, 1),
              icon: Icons.camera_alt,
              label: "رخصة القياة"),
          mainImg: _idImg,
        ),
        SizedBox(height: 20),
        GetImage().showMainImg(
          context: context,
          deleteImage: () {
            setState(() {
              _carFormImg = null;
            });
          },
          cameraBtn: _cameraBtn(
              onTap: () => _getMainImg(ImageSource.gallery, 2),
              icon: Icons.camera_alt,
              label: "استمارة السيارة"),
          mainImg: _carFormImg,
        ),
        SizedBox(height: 20),
        GetImage().showMainImg(
          context: context,
          deleteImage: () {
            setState(() {
              _forwardCarImg = null;
            });
          },
          cameraBtn: _cameraBtn(
              onTap: () => _getMainImg(ImageSource.gallery, 3),
              icon: Icons.camera_alt,
              label: "بطاقة التشغيل او بطاقة المواصلات"),
          mainImg: _forwardCarImg,
        ),
        SizedBox(height: 20),
        GetImage().showMainImg(
          context: context,
          deleteImage: () {
            setState(() {
              _carImg = null;
            });
          },
          cameraBtn: _cameraBtn(
              onTap: () => _getMainImg(ImageSource.gallery, 4),
              icon: Icons.camera_alt,
              label: "تأمين السيارة"),
          mainImg: _carImg,
        ),
      ],
    );
  }

  _getMainImg(ImageSource source, int currentImage) async {
    var image = await ImagePicker.pickImage(source: source);
    setState(() {
      switch (currentImage) {
        case 0:
          return setState(() {
            _mainImg = image;
            Provider.of<SignUpProvider>(context, listen: false).identity =
                _mainImg;
          });
        case 1:
          return setState(() {
            _idImg = image;
            Provider.of<SignUpProvider>(context, listen: false).license =
                _idImg;
          });
        case 2:
          return setState(() {
            _carFormImg = image;
            Provider.of<SignUpProvider>(context, listen: false).carForm =
                _carFormImg;
          });
        case 3:
          return setState(() {
            _forwardCarImg = image;
            Provider.of<SignUpProvider>(context, listen: false)
                .transportationCard = _forwardCarImg;
          });
        case 4:
          return setState(() {
            _carImg = image;
            Provider.of<SignUpProvider>(context, listen: false).insurance =
                _carImg;
          });
          break;
      }
    });
  }

  Widget _cameraBtn({Function onTap, String label, IconData icon}) {
    return Padding(
      padding: const EdgeInsets.only(right: 5, left: 5),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.grey)),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(icon),
                Expanded(
                    child: Text(
                  label,
                  textAlign: TextAlign.end,
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  File _mainImg;
  File _carFormImg;
  File _forwardCarImg;
  File _idImg;
  File _carImg;
}
