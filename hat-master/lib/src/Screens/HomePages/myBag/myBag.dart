import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:haat/src/Helpers/sharedPref_helper.dart';
import 'package:haat/src/MainWidgets/app_empty.dart';
import 'package:haat/src/MainWidgets/app_loader.dart';
import 'package:haat/src/Screens/HomePages/Orders/internal/orderFinish.dart';
import 'package:haat/src/provider/get/cartsProvider.dart';
import 'package:haat/src/provider/get/clearBagProvider.dart';
import 'package:provider/provider.dart';

import '../main_page.dart';
import 'internal/cartOrders.dart';

class MyBag extends StatefulWidget {
  @override
  _MyBagState createState() => _MyBagState();
}

class _MyBagState extends State<MyBag> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 150), () {
      Provider.of<CartsProvider>(context, listen: false)
          .getCarsType(Provider.of<SharedPref>(context, listen: false).token);
    });
    Provider.of<CartsProvider>(context, listen: false)
        .getCarsType(Provider.of<SharedPref>(context, listen: false).token);
    super.initState();
  }

  bool selected = false;
  bool deletOrders = false;
  @override
  Widget build(BuildContext context) {
    List<Function> ontap = [
      () {
        print("object");
        if (Provider.of<CartsProvider>(context, listen: false).carts.length ==
            0) {
          Fluttertoast.showToast(
              msg: "لا يوجد طلبات",
              toastLength: Toast.LENGTH_SHORT,
              timeInSecForIosWeb: 1,
              fontSize: 16.0,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.black,
              textColor: Colors.white);
        } else
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => FinishOrder(
                        bag: 1,
                        type: 3,
                      )));
      },
      () {
        Provider.of<ClearBagProvider>(context, listen: false)
            .clearBag(
                Provider.of<SharedPref>(context, listen: false).token, context)
            .then((v) {
          if (v == true)
            Provider.of<CartsProvider>(context, listen: false).getCarsType(
                Provider.of<SharedPref>(context, listen: false).token);
        });
      },
      () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => MainPage(
                      index: 2,
                    )));
      },
    ];
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(
          "السلة",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: Icon(null),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text("الطلبات",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              ],
            ),
          ),
          Provider.of<CartsProvider>(context, listen: true).cartsModel == null
              ? Container(
                  height: MediaQuery.of(context).size.height / 1.7,
                  child: AppLoader())
              : Provider.of<CartsProvider>(context, listen: true)
                          .carts
                          .length ==
                      0
                  ? Container(
                      height: MediaQuery.of(context).size.height / 1.7,
                      child: AppEmpty(text: "لا يوجد طلبات في السلة"))
                  : CartOrders(),
          SizedBox(
            height: 40,
          ),
          Center(
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width / 1.1,
              child: Center(
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    reverse: true,
                    itemCount: 3,
                    itemBuilder: (c, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: ontap[index],
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Theme.of(context).primaryColor),
                            width: MediaQuery.of(context).size.width / 4,
                            child: Center(
                                child: Text(
                              title[index],
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            )),
                          ),
                        ),
                      );
                    }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<String> title = [
    "اعتماد الطلب",
    "افراغ السلة",
    "اكمال التسويق",
  ];
  List<bool> selectfilter = [
    true,
    false,
    false,
  ];
}
