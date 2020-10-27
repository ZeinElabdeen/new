import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:haat/src/Helpers/sharedPref_helper.dart';
import 'package:haat/src/MainWidgets/buttonSignIn.dart';
import 'package:haat/src/MainWidgets/customImageNetworkGetter.dart';
import 'package:haat/src/Intro/waitingScreen.dart';
import 'package:haat/src/Repository/appLocalization.dart';
import 'package:haat/src/provider/post/editCarDataProvider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CarDocuments extends StatefulWidget {
  final String token;
  final SharedPreferences pref;

  const CarDocuments({Key key, this.token, this.pref}) : super(key: key);
  @override
  _CarDocumentsState createState() => _CarDocumentsState();
}

class _CarDocumentsState extends State<CarDocuments> {
  String _mainImgNetwork;
  String _carFormImgNetwork;
  String _forwardCarImgNetwork;
  String _idImgNetwork;
  String _carImgNetwork;

  @override
  void initState() {
    _mainImgNetwork = Provider.of<SharedPref>(context, listen: false).identity;
    _carFormImgNetwork =
        Provider.of<SharedPref>(context, listen: false).license;
    _forwardCarImgNetwork =
        Provider.of<SharedPref>(context, listen: false).transportationCard;
    _idImgNetwork = Provider.of<SharedPref>(context, listen: false).carForm;
    _carImgNetwork = Provider.of<SharedPref>(context, listen: false).insurance;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: 20),
        GetImageNetwork().showMainImg(
          context: context,
          deleteImage: () {
            setState(() {
              _mainImg = null;
              _mainImgNetwork = null;
            });
          },
          mainImgNetwork: _mainImgNetwork,
          cameraBtn: _cameraBtn(
            onTap: () => _getMainImg(ImageSource.gallery, 0),
            icon: Icons.camera_alt,
            label: "الهوية او الاقامة",
            // "الهوية او الاقامة"
          ),
          mainImg: _mainImg,
        ),
        SizedBox(height: 20),
        GetImageNetwork().showMainImg(
          context: context,
          deleteImage: () {
            setState(() {
              _idImg = null;
              _carFormImgNetwork = null;
            });
          },
          cameraBtn: _cameraBtn(
            onTap: () => _getMainImg(ImageSource.gallery, 1),
            icon: Icons.camera_alt,
            label: "رخصة القياة",
          ),
          mainImg: _idImg,
          mainImgNetwork: _carFormImgNetwork,
        ),
        SizedBox(height: 20),
        GetImageNetwork().showMainImg(
            context: context,
            deleteImage: () {
              setState(() {
                _carFormImg = null;
                _forwardCarImgNetwork = null;
              });
            },
            cameraBtn: _cameraBtn(
              onTap: () => _getMainImg(ImageSource.gallery, 2),
              icon: Icons.camera_alt,

              label: "استمارة السيارة",
              //  "استمارة السيارة"
            ),
            mainImg: _carFormImg,
            mainImgNetwork: _forwardCarImgNetwork),
        SizedBox(height: 20),
        GetImageNetwork().showMainImg(
            context: context,
            deleteImage: () {
              setState(() {
                _forwardCarImg = null;
                _idImgNetwork = null;
              });
            },
            cameraBtn: _cameraBtn(
              onTap: () => _getMainImg(ImageSource.gallery, 3),
              icon: Icons.camera_alt,
              label: "بطاقة التشغيل او بطاقة المواصلات",
              // "بطاقة التشغيل او بطاقة المواصلات"
            ),
            mainImg: _forwardCarImg,
            mainImgNetwork: _idImgNetwork),
        SizedBox(height: 20),
        GetImageNetwork().showMainImg(
            context: context,
            deleteImage: () {
              setState(() {
                _carImg = null;
                _carImgNetwork = null;
              });
            },
            cameraBtn: _cameraBtn(
              onTap: () => _getMainImg(ImageSource.gallery, 4),
              icon: Icons.camera_alt,
              label: "تأمين السيارة",
              // "تأمين السيارة"
            ),
            mainImg: _carImg,
            mainImgNetwork: _carImgNetwork),
        SizedBox(
          height: 20,
        ),
        SignInButton(
          txtColor: Colors.white,
          onPressSignIn: () {
            if (_mainImg == null &&
                _idImg == null &&
                _carFormImg == null &&
                _forwardCarImg == null &&
                _carImg == null) {
              Fluttertoast.showToast(
                  msg: "لم يتم اضافة اي تعديل",
                  toastLength: Toast.LENGTH_LONG,
                  timeInSecForIosWeb: 1,
                  fontSize: 16.0);

              return;
            }
            _showDialog(
                "عند تعديل بيانات السيارة سيتم ايقاف الحساب لحين الموافقة من الادارة",
                context);
          },
          btnWidth: MediaQuery.of(context).size.width - 40,
          btnHeight: MediaQuery.of(context).size.height * .07,
          btnColor: Theme.of(context).primaryColor,
          buttonText: localization.text("edit"),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  _showDialog(String text, BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 3,
            backgroundColor: Colors.white,
            contentPadding: EdgeInsets.all(15),
            children: <Widget>[
              Container(
                height: 50,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Directionality(
                    textDirection:
                        localization.currentLanguage.toString() == "en"
                            ? TextDirection.ltr
                            : TextDirection.rtl,
                    child: Text(
                      text,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        Provider.of<EditCarDataProvider>(context, listen: false)
                            .changeCarData(widget.token, context);
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WaitingAccepting(),
                          ),
                          (Route<dynamic> route) => false,
                        );
                      },
                      child: Container(
                          width: 50,
                          height: 30,
                          child: Center(
                              child: Text(localization.text("ok")
                                  // "متاكد"
                                  )))),
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                          width: 50,
                          height: 30,
                          child: Center(
                              child: Text(localization.text("no")
                                  // "الغاء"
                                  ))))
                ],
              )
            ],
          );
        });
  }

  _getMainImg(ImageSource source, int currentImage) async {
    var image = await ImagePicker.pickImage(source: source);
    setState(() {
      switch (currentImage) {
        case 0:
          return setState(() {
            _mainImg = image;
            Provider.of<EditCarDataProvider>(context, listen: false).identity =
                _mainImg;
          });
        case 1:
          return setState(() {
            _idImg = image;
            Provider.of<EditCarDataProvider>(context, listen: false).license =
                _idImg;
          });
        case 2:
          return setState(() {
            _carFormImg = image;
            Provider.of<EditCarDataProvider>(context, listen: false).carForm =
                _carFormImg;
          });
        case 3:
          return setState(() {
            _forwardCarImg = image;
            Provider.of<EditCarDataProvider>(context, listen: false)
                .transportationCard = _forwardCarImg;
          });
        case 4:
          return setState(() {
            _carImg = image;
            Provider.of<EditCarDataProvider>(context, listen: false).insurance =
                _carImg;
          });
          break;
      }
    });
    // registerBloc.updatePersonalImg(image);
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
