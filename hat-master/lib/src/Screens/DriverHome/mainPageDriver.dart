import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:haat/src/Screens/HomePages/Notifications/notificationPage.dart';
import 'package:haat/src/Widgets/Connection/dialogs.dart';
import 'package:haat/src/Widgets/Connection/internet_connectivity.dart';
import '../HomePages/Settings/more.dart';
import 'masterPage/masterPage.dart';

class MainPageDriver extends StatefulWidget {
  final index;

  const MainPageDriver({Key key, this.index}) : super(key: key);

  @override
  _MainPageDriverState createState() => _MainPageDriverState();
}

class _MainPageDriverState extends State<MainPageDriver>
    with SingleTickerProviderStateMixin {
  TabController controller;
  SharedPreferences _preferences;

  getShared() async {
    _preferences = await SharedPreferences.getInstance();
  }

  Position _startPosition;
  Geolocator _geoLocator = Geolocator();

  Future<Position> _getLocation() async {
    var currentLocation;
    try {
      currentLocation = await _geoLocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      setState(() {
        _startPosition = currentLocation;
        print("can i get my position");
        _preferences.setDouble("long", _startPosition.longitude);
        _preferences.setDouble("lat", _startPosition.latitude);
      });
    } catch (e) {
      currentLocation = null;
    }
    return currentLocation;
  }

  static final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    if (widget.index != null) {
      _selectedIndex = widget.index;
    }

    _getLocation();
    controller = TabController(vsync: this, length: 4);
    MyConnectivity.instance.initialise();
    MyConnectivity.instance.myStream.listen((onData) {
      if (MyConnectivity.instance.isIssue(onData)) {
        if (MyConnectivity.instance.isShow == false) {
          MyConnectivity.instance.isShow = true;
          showDialogNotInternet(context).then((onValue) {
            MyConnectivity.instance.isShow = false;
          });
        }
      } else {
        if (MyConnectivity.instance.isShow == true) {
          Navigator.of(context).pop();
          MyConnectivity.instance.isShow = false;
        }
      }
    });

    getShared();
    super.initState();
  }

  int _selectedIndex = 1;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: _selectedIndex,
      child: Scaffold(
        key: _globalKey,
        bottomNavigationBar: TabBar(
          tabs: [
            Tab(
              icon: Icon(
                Icons.notifications,
              ),
            ),
            Tab(
              icon: Icon(
                Icons.home,
              ),
            ),
            Tab(
              icon: Icon(
                Icons.settings,
              ),
            ),
          ],
          labelColor: Theme.of(context).primaryColor,
          unselectedLabelColor: Colors.blueGrey,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorPadding: EdgeInsets.all(8.0),
          indicatorColor: Colors.red,
        ),
        body: TabBarView(
          children: [
            NotificationPage(),
            MasterPage(),
            More(),
          ],
        ),
      ),
    );
  }
}
