import 'dart:async';
import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:haat/src/Helpers/map_helper.dart';
import 'package:haat/src/Helpers/sharedPref_helper.dart';
import 'package:haat/src/MainWidgets/BouncyPageRoute.dart';
import 'package:haat/src/Screens/DriverHome/mainPageDriver.dart';
import 'package:haat/src/Screens/Registeration/sign_in_screen.dart';
import 'package:haat/src/provider/auth/loginProvider.dart';
import 'package:haat/src/provider/get/getUserDataProvider.dart';
import 'package:haat/src/provider/get/setting.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../MainWidgets/custom_new_dialog.dart';
import '../Repository/firebaseNotifications.dart';
import '../Screens/HomePages/main_page.dart';
import '../Widgets/Connection/check_connection_screen.dart';
import 'waitingScreen.dart';

class Splash extends StatefulWidget {
  final GlobalKey<NavigatorState> navigator;

  const Splash({Key key, this.navigator}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  AnimationController controller;

  Animation animation;

  SharedPreferences _preferences;

  _getShared() async {
    _preferences = await SharedPreferences.getInstance();
    if (_preferences.get("token") != null) {
      Provider.of<GetUserDataProvider>(context, listen: false)
          .getUserData(_preferences.get("token"))
          .then((res) {
        if (res.code == 401) {
          print('----- clear ----');
          _preferences.clear();
          _onDoneLoading();
        } else
          _onDoneLoading();
      });
    } else
      _onDoneLoading();
  }

  Future<Timer> _loadData() async {
    return Timer(Duration(seconds: 3), checkConnection);
  }

  CustomDialog dialog = CustomDialog();

  checkConnection() async {
    final result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (_) => CheckConnectionScreen(
                    state: false,
                  )),
          (Route<dynamic> route) => false);
    } else if (result == ConnectivityResult.mobile) {
      _getShared();
    } else if (result == ConnectivityResult.wifi) {
      _getShared();
    }
  }

  _onDoneLoading() async {
    Provider.of<SharedPref>(context, listen: false).getSharedHelper(_preferences);
    print("device token shared  : ${await _preferences.get('device_token')}");
    if (await _preferences.get('token') == null) {
      print('go to login');
      Navigator.of(context).pushReplacement(BouncyPageRoute(
          // builder: (context) => SignInScreen()
          widget: SignInScreen()));
    } else {
      if (await _preferences.get('active') == 0) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => WaitingAccepting()),
            (Route<dynamic> route) => false);
      } else {
        if (_preferences.get('type') == 1) {
          Provider.of<LoginProvider>(context, listen: false).type =
              _preferences.get('type');
          Navigator.pushAndRemoveUntil(
            context,
            BouncyPageRoute(widget: MainPage()),
            (Route<dynamic> route) => false,
          );
        } else {
          Provider.of<LoginProvider>(context, listen: false).type =
              _preferences.get('type');

          Navigator.pushAndRemoveUntil(
            context,
            BouncyPageRoute(widget: MainPageDriver()),
            (Route<dynamic> route) => false,
          );
        }
      }
    }
  }

  _initPlatformState() async {
    bool res = await FlutterAppBadger.isAppBadgeSupported();
    if (res) {
      print('Supported');
    } else {
      print('Not supported');
    }
    if (!mounted) return;
  }

  @override
  void initState() {
    Provider.of<SettingProvider>(context, listen: false).getUserData(context);

    Provider.of<MapHelper>(context, listen: false).getLocation();
    _initPlatformState();
    _loadData();
    FirebaseNotifications().setUpFirebase(widget.navigator);
    super.initState();
  }

  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var height = 150.0;
    return Scaffold(
        key: _globalKey,
        backgroundColor: Colors.white,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Container(
            height: height,
            width: height,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  padding: EdgeInsets.all(50),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Platform.isIOS
                          ? CupertinoActivityIndicator(
                              radius: 60,
                            )
                          : Container(
                              width: 60,
                              height: 60,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                backgroundColor: Theme.of(context).primaryColor,
                                // valueColor: An,
                              ),
                            ),
                      Image.asset(
                        'assets/images/newLoga.png',
                        height: 55,
                        width: 55,
                      )
                    ],
                  ),
                ),
                Text(Provider.of<SettingProvider>(context, listen: true).splashMsg ?? "")
              ],
            ),
          ),
        ));
    //   Stack(
    //     children: <Widget>[
    //       ImageBG(),
    //       Container(
    //         margin:
    //             EdgeInsets.only(top: MediaQuery.of(context).size.height * .2),
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: <Widget>[
    //             Image.asset(
    //               'assets/images/newLoga.png',
    //               height: 150,
    //               fit: BoxFit.cover,
    //             ),
    //           ],
    //         ),
    //       ),
    //       Center(
    //         child: Container(
    //           margin:
    //               EdgeInsets.only(top: MediaQuery.of(context).size.height * .8),
    //           child: Shimmer.fromColors(
    //               child: Row(
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 children: <Widget>[
    //                   Text(
    //                     "hat",
    //                     style: TextStyle(fontSize: 18),
    //                   ),
    //                   Text(
    //                     " مرحبا بكم في تطبيق ",
    //                     style: TextStyle(fontSize: 18),
    //                   ),
    //                 ],
    //               ),
    //               baseColor: Colors.black,
    //               highlightColor: Colors.white),
    //         ),
    //       )
    //     ],
    //   ),

    // );
  }
}
