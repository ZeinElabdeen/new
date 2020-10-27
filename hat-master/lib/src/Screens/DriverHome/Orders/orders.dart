import 'package:flutter/material.dart';
import 'package:haat/src/MainWidgets/custom_app_bar.dart';
import 'package:haat/src/Screens/DriverHome/Apis/App/app_event.dart';
import 'package:haat/src/Screens/DriverHome/Orders/Sections/active_orders.dart';
import 'package:haat/src/Screens/DriverHome/Orders/Sections/ended_orders.dart';
import 'package:haat/src/Screens/DriverHome/Orders/Sections/new_orders.dart';
import 'package:haat/src/Screens/DriverHome/Orders/Sections/pinned_orders.dart';
import 'package:haat/src/Screens/DriverHome/Apis/BLoCs/OrdersBLoCs/orders_bloc.dart';
import 'package:haat/src/provider/getMapImageProvider.dart';
import 'package:provider/provider.dart';

class Orders extends StatefulWidget {
  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> with SingleTickerProviderStateMixin {
  TabController _tabBarController;
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    ordersBloc.updateKey(_globalKey);
    _tabBarController = new TabController(vsync: this, length: 4);
    Provider.of<GetMapImage>(context,listen: false).setCustomMapPin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomAppBar(
          label: 'طلباتي',
          iconData: Icons.arrow_back_ios,
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: 50,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TabBar(
                onTap: (v) {
                  switch (v) {
                    case 0:
                      // ordersBloc.updateOrderType(0);
                      // ordersBloc.add(Click());
                      break;
                    case 1:
                      ordersBloc.updateOrderType(1);
                      ordersBloc.add(Click());
                      break;
                    case 2:
                      ordersBloc.updateOrderType(2);
                      ordersBloc.add(Click());
                      break;
                    default:
                      ordersBloc.updateOrderType(3);
                      ordersBloc.add(Click());
                  }
                },
                unselectedLabelColor: Colors.redAccent,
                indicatorSize: TabBarIndicatorSize.label,
                controller: _tabBarController,
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Theme.of(context).primaryColor),
                labelColor: Theme.of(context).primaryColor,
                tabs: <Widget>[
                  tapCard("جديدة"),
                  tapCard("مُعلقة"),
                  tapCard("نشطة"),
                  tapCard("منتهية"),
                ],
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height - 180,
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: _tabBarController,
              children: <Widget>[
                new NewOrders(),
                new PinnedOrders(),
                new ActiveOrders(),
                new EndedOrders(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget tapCard(String title) {
    return Tab(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border:
                Border.all(color: Theme.of(context).primaryColor, width: 1)),
        child: Align(
            alignment: Alignment.center,
            child: Text(title, style: TextStyle(color: Colors.black))),
      ),
    );
  }
}
