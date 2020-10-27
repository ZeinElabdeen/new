import 'package:flutter/material.dart';
import 'package:haat/src/MainWidgets/custom_app_bar.dart';
import 'package:haat/src/Screens/HomePages/Apis/App/app_event.dart';
import 'package:haat/src/Screens/HomePages/Apis/BLoCs/OrderBLoCs/orders_bloc.dart';

import 'Sections/active_orders.dart';
import 'Sections/ended_orders.dart';
import 'Sections/new_orders.dart';

class MyOrders extends StatefulWidget {
  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders>
    with SingleTickerProviderStateMixin {
  TabController _tabBarController;
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    ordersBloc.updateKey(_globalKey);
    _tabBarController = new TabController(vsync: this, length: 3);
    ordersBloc.updateOrderType(0);
    ordersBloc.add(Click());
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        key: _globalKey,
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: CustomAppBar(
            label: 'طلباتي',
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
                        ordersBloc.updateOrderType(0);
                        ordersBloc.add(Click());
                        break;
                      case 1:
                        ordersBloc.updateOrderType(1);
                        ordersBloc.add(Click());
                        break;
                      default:
                        ordersBloc.updateOrderType(2);
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
                  new ActiveOrders(),
                  new EndedOrders()
                ],
              ),
            ),
          ],
        ),
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
