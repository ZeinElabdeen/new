import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:haat/src/Helpers/sharedPref_helper.dart';
import 'package:haat/src/Screens/HomePages/Settings/EditData/editDriverProfile.dart';
import 'package:haat/src/Screens/HomePages/Settings/Internal/myPlaces/myPlaces.dart';
import 'package:haat/src/provider/auth/logOutProvider.dart';
import 'package:haat/src/provider/auth/loginProvider.dart';
import 'package:haat/src/provider/get/setting.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:haat/src/MainWidgets/custom_option_card.dart';
import 'package:haat/src/Screens/HomePages/MasterPage/Widgets/user_data.dart';
import 'package:haat/src/Screens/Registeration/sign_in_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import 'EditData/carData.dart';
import 'EditData/editProfile.dart';
import 'Internal/Payment/myPayments.dart';
import 'Internal/Wallet/internal/history.dart';
import 'Internal/Wallet/wallet.dart';
import 'Internal/about.dart';
import 'Internal/terms.dart';

class More extends StatefulWidget {
  @override
  _MoreState createState() => _MoreState();
}

class _MoreState extends State<More> {
  SharedPreferences _prefs;

  _getShared() async {
    var _instance = await SharedPreferences.getInstance();
    setState(() {
      _prefs = _instance;
    });
  }

  CustomOptionCard _optionCard = CustomOptionCard();

  // ignore: unused_element
  _launchURL() async {
    const url = 'https://tqnee.com.sa';
    launch(url);
  }

  _sendWhatsApp() async {
    var url =
        "https://wa.me/${Provider.of<SettingProvider>(context, listen: false).centerPhone}";
    await canLaunch(url) ? launch(url) : print('No WhatsAPP');
  }

  FirebaseMessaging _fcm = FirebaseMessaging();
  String _deviceToken;
  @override
  void initState() {
    super.initState();
    _fcm.getToken().then((response) {
      setState(() {
        _deviceToken = response;
      });
      print('The device Token is :' + _deviceToken);
    });
    _getShared();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(null),
        title: Text(
          "الاعدادات",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 7,
            color: Theme.of(context).primaryColor,
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: UserData(),
            ),
          ),
          _optionCard.optionCard(
              onTap: () {
                if (Provider.of<SharedPref>(context, listen: false).type == 1) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => EditProfile()));
                } else
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditDriverProfile()));
              },
              label: 'تعديل البيانات ',
              icon: "assets/images/001.png",
              context: context),
          Visibility(
            visible:
                Provider.of<LoginProvider>(context, listen: false).type == 1,
            child: _optionCard.optionCard(
                icon: "assets/images/002.png",
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyPayments())),
                label: 'مدفوعاتي',
                context: context),
          ),
          Visibility(
            visible:
                Provider.of<LoginProvider>(context, listen: false).type == 1,
            child: _optionCard.optionCard(
                icon: "assets/images/002.png",
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyPlaces())),
                label: 'عناويني',
                context: context),
          ),
          Visibility(
            visible:
                Provider.of<LoginProvider>(context, listen: false).type == 1,
            child: _optionCard.optionCard(
                icon: "assets/images/002.png",
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyWallet())),
                label: 'محفظتي',
                context: context),
          ),
          _optionCard.optionCard(
              icon: "assets/images/002.png",
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => History())),
              label: 'سجل العمليات',
              context: context),
          Visibility(
            visible:
                Provider.of<LoginProvider>(context, listen: false).type == 2,
            child: _optionCard.optionCard(
                icon: "assets/images/002.png",
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CarData())),
                label: 'بيانات سيارتي',
                context: context),
          ),
          _optionCard.optionCard(
              onTap: () {
                Theme.of(context).platform != TargetPlatform.iOS
                    ? shareTheApp()
                    : shareTheAppIOS();
              },
              label: 'مشاركة التطبيق',
              icon: "assets/images/003.png",
              context: context),
          _optionCard.optionCard(
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AboutApp())),
              label: 'عن التطبيق   ',
              icon: "assets/images/004.png",
              context: context),
          _optionCard.optionCard(
              icon: "assets/images/005.png",
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => TermsApp())),
              label: 'الشروط و الاحكام',
              context: context),
          _optionCard.optionCard(
              icon: "assets/images/008.png",
              onTap: _sendWhatsApp,
              label: 'تواصل معنا',
              context: context),
          _optionCard.optionCard(
              icon: "assets/images/006.png",
              onTap: () {
                Provider.of<LogOutProvider>(context, listen: false).logOut(
                    _deviceToken,
                    Provider.of<SharedPref>(context, listen: false).token);
                _prefs.clear();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignInScreen(),
                  ),
                  (Route<dynamic> route) => false,
                );
              },
              label: 'خروج',
              context: context),
        ],
      ),
    );
  }

  shareTheApp() async {
    try {
      String _msg;
      StringBuffer _sb = new StringBuffer();
      setState(() {
        _sb.write("لتنزيل التطبيق اضغط على الرابط\n");
        _sb.write("");
        _msg = _sb.toString();
      });
      final ByteData bytes = await rootBundle.load('assets/images/newLogo.png');
      await Share.file(
          'esys image', 'esys.png', bytes.buffer.asUint8List(), 'image/png',
          text: _msg);
    } catch (e) {
      print('error: $e');
    }
  }

  shareTheAppIOS() async {
    try {
      String _msg;
      StringBuffer _sb = new StringBuffer();
      setState(() {
        _sb.write("لتنزيل التطبيق اضغط على الرابط\n");
        _sb.write("");
        _msg = _sb.toString();
      });
      final ByteData bytes = await rootBundle.load('assets/images/newLogo.png');
      await Share.file(
          'esys image', 'esys.png', bytes.buffer.asUint8List(), 'image/png',
          text: _msg);
    } catch (e) {
      print('error: $e');
    }
  }
}
