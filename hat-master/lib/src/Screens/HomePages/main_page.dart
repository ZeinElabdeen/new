import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:haat/src/Screens/HomePages/Chat/chats.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'MasterPage/master_screen.dart';
import 'Orders/orders.dart';
import 'Settings/more.dart';
import 'myBag/myBag.dart';

class MainPage extends StatefulWidget {
  // static final String homePage = "home";
  final index;

  const MainPage({Key key, this.index}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
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

  @override
  void initState() {
    if (widget.index != null) {
      _selectedIndex = widget.index;
    }
    _getLocation();
    getShared();
    super.initState();
  }

  int _selectedIndex = 2;
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      initialIndex: _selectedIndex,
      child: Scaffold(
        bottomNavigationBar: TabBar(
          tabs: [
            Tab(
              icon: Icon(
                Icons.message,
              ),
            ),
            Tab(
              icon: Icon(
                Icons.settings,
              ),
            ),
            Tab(
              icon: Icon(
                Icons.home,
              ),
            ),
            Tab(
              icon: Icon(
                Icons.shopping_cart,
              ),
            ),
            Tab(
              icon: Icon(
                FontAwesomeIcons.shoppingBasket,
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
            Chats(),
            More(),
            MasterScreen(),
            MyBag(),
            MyOrders(),
          ],
        ),
      ),
    );
  }
}
