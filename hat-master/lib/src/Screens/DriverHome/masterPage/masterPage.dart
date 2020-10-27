import 'package:flutter/material.dart';
import 'package:haat/src/Helpers/sharedPref_helper.dart';
import 'package:haat/src/Screens/DriverHome/Orders/orders.dart';
import 'package:haat/src/Screens/HomePages/Apis/App/app_event.dart';
import 'package:haat/src/Screens/HomePages/Apis/BLoCs/balance_bloc.dart';
import 'package:haat/src/Screens/HomePages/Chat/chats.dart';
import 'package:haat/src/Screens/HomePages/Settings/Internal/Wallet/wallet.dart';
import 'package:haat/src/Screens/DriverHome/masterPage/widget/user_data.dart';
import 'package:haat/src/provider/post/avibalatyProvider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'DriverPayments.dart';
import 'widget/driverCard.dart';

class MasterPage extends StatefulWidget {
  @override
  _MasterPageState createState() => _MasterPageState();
}

class _MasterPageState extends State<MasterPage> {
  SharedPreferences _prefs;

  _getShared() async {
    balanceBloc.add(Click());

    var _instance = await SharedPreferences.getInstance();
    setState(() {
      _prefs = _instance;
    });
  }

  @override
  void initState() {
    super.initState();
    _getShared();
  }

  bool selected = false;
  @override
  Widget build(BuildContext context) {
    List<Function> ontap = [
      () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => Orders()));
      },
      () {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => DriverPayments(
              title: "عمولاتي",
            )));
      },
      () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => MyWallet()));
      },
      () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => Chats()));
      },
    ];
    return Scaffold(
      appBar: AppBar(
        leading: Icon(null),
        title: Text(
          "الرئيسية",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 3.5,
            color: Theme.of(context).primaryColor,
            child: UserData(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Switch(
                  onChanged: (v) {
                    Provider.of<AvailabilityProvider>(context, listen: false)
                        .changeAvailable(
                      token:
                          Provider.of<SharedPref>(context, listen: false).token,
                      available: Provider.of<SharedPref>(context, listen: false)
                                  .avalable ==
                              true
                          ? 0
                          : 1,
                      context: context,
                      lat: Provider.of<SharedPref>(context, listen: false).lat,
                      long:
                          Provider.of<SharedPref>(context, listen: false).long,
                    )
                        .then((value) {
                      if (value == true) {
                        setState(() {
                          // selected = !selected;
                          _prefs.setBool("avalable", v);
                          Provider.of<SharedPref>(context, listen: false)
                              .getSharedHelper(_prefs);
                        });
                      }
                    });
                  },
                  value:
                      Provider.of<SharedPref>(context, listen: false).avalable),
              Text(  Provider.of<SharedPref>(context, listen: false).avalable ? "متاح" : "غير متاح"),
            ],
          ),
          Container(
            height: MediaQuery.of(context).size.height / 2,
            child: GridView.count(
              crossAxisCount: 2,
              scrollDirection: Axis.vertical,
              physics: NeverScrollableScrollPhysics(),
              children: List.generate(4, (index) {
                return DriverCard(
                  ontap: ontap[index],
                  index: index,
                );
              }),
            ),
          )
        ],
      ),
    );
  }
}
