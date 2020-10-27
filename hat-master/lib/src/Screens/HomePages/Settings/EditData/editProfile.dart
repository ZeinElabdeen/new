import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:haat/src/Helpers/sharedPref_helper.dart';
import 'package:haat/src/MainWidgets/register_text_field.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:haat/src/MainWidgets/buttonSignIn.dart';
import 'package:haat/src/Screens/HomePages/Settings/EditData/editPassword.dart';
import 'package:haat/src/Widgets/ImagePicker/image_picker_handler.dart';
import 'package:haat/src/provider/changeData/changePhoneProvider.dart';
import 'package:haat/src/provider/changeData/editAcountProvider.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile>
    with TickerProviderStateMixin, ImagePickerListener {
  SharedPreferences _preferences;
  getShared() async {
    _preferences = await SharedPreferences.getInstance();
  }

  ImageProvider imageProvider = AssetImage("assets/avatar.jpg");

  File _image;

  AnimationController _controller;
  ImagePickerHandler imagePicker;

  @override
  void initState() {
    getShared();

    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    imagePicker = new ImagePickerHandler(
        this, _controller, Color.fromRGBO(12, 169, 149, 1));
    imagePicker.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text(
              "تعديل البيانات",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        child: Container(
          child: Container(
            child: ListView(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            InkWell(
                              onTap: () => imagePicker.showDialog(context),
                              child: _image == null
                                  ? CachedNetworkImage(
                                      imageUrl: Provider.of<SharedPref>(context,
                                                      listen: false)
                                                  .photo !=
                                              null
                                          ? Provider.of<SharedPref>(context,
                                                  listen: false)
                                              .photo
                                          : "",
                                      fadeInDuration: Duration(seconds: 2),
                                      placeholder: (context, url) =>
                                          CircleAvatar(
                                              radius: 60,
                                              backgroundImage: AssetImage(
                                                  'assets/images/avatar.jpeg')),
                                      imageBuilder: (context, provider) {
                                        return CircleAvatar(
                                            radius: 60,
                                            backgroundImage: provider);
                                      },
                                    )
                                  : Container(
                                      child: CircleAvatar(
                                        radius: 60,
                                        backgroundImage:
                                            Image.file(_image).image,
                                      ),
                                    ),
                            ),
                            Positioned(
                              bottom: 5,
                              right: 10,
                              child: InkWell(
                                onTap: () => imagePicker.showDialog(context),
                                child: CircleAvatar(
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.black,
                                    size: 15,
                                  ),
                                  radius: 10,
                                  backgroundColor: Colors.white,
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    RegisterTextField(
                      icon: Icons.person,
                      onChange: (v) {
                        Provider.of<EditUserDataProvider>(context,
                                listen: false)
                            .name = v;
                      },
                      init:
                          Provider.of<SharedPref>(context, listen: false).name,
                      label: "اسم المستخدم",
                      type: TextInputType.text,
                    ),
                    SizedBox(height: 20),
                    RegisterTextField(
                      icon: Icons.mail,
                      onChange: (v) {
                        Provider.of<EditUserDataProvider>(context,
                                listen: false)
                            .email = v;
                      },
                      init:
                          Provider.of<SharedPref>(context, listen: false).email,
                      label: 'الايميل',
                      type: TextInputType.text,
                    ),
                    SizedBox(height: 10),
                    SignInButton(
                      txtColor: Colors.white,
                      onPressSignIn: () {
                        Provider.of<EditUserDataProvider>(context,
                                listen: false)
                            .changeUserData(
                                Provider.of<SharedPref>(context, listen: false)
                                    .token,
                                context)
                            .then((v) {
                          if (v == true) {
                            Provider.of<SharedPref>(context, listen: false)
                                .getSharedHelper(_preferences);
                          }
                        });
                      },
                      btnWidth: MediaQuery.of(context).size.width - 40,
                      btnHeight: 45,
                      btnColor: Theme.of(context).primaryColor,
                      buttonText: "تعديل بيانات المستخدم",
                    ),
                    SizedBox(height: 10),
                    RegisterTextField(
                      hint: 'رقم الجوال',
                      icon: Icons.phone,
                      onChange: (v) {
                        Provider.of<ChangeMobileProvider>(context,
                                listen: false)
                            .phone = v;
                      },
                      init:
                          Provider.of<SharedPref>(context, listen: false).phone,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SignInButton(
                      txtColor: Colors.white,
                      onPressSignIn: () {
                        Provider.of<ChangeMobileProvider>(context,
                                listen: false)
                            .changeMobile(
                                Provider.of<SharedPref>(context, listen: false)
                                    .token,
                                context);
                      },
                      btnWidth: MediaQuery.of(context).size.width - 40,
                      btnHeight: 45,
                      btnColor: Theme.of(context).primaryColor,
                      buttonText: 'تعديل رقم الجوال',
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                EditPassword()
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  userImage(File _image) {
    setState(() {
      this._image = _image;
      Provider.of<EditUserDataProvider>(context, listen: false).image = _image;
    });
  }
}
