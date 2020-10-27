import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haat/src/MainWidgets/app_loader.dart';
import 'package:haat/src/MainWidgets/custom_alert.dart';
import 'package:haat/src/Screens/DriverHome/Apis/App/app_event.dart';
import 'package:haat/src/Screens/DriverHome/Apis/App/app_state.dart';
import 'package:haat/src/Screens/DriverHome/Apis/BLoCs/balance_bloc.dart';
import 'package:haat/src/Screens/DriverHome/Apis/Models/palance_model.dart';
import 'package:haat/src/Screens/HomePages/Settings/Internal/Wallet/internal/history.dart';
import 'package:haat/src/provider/auth/loginProvider.dart';
import 'package:provider/provider.dart';
import 'widget/chargeScreen.dart';

class MyWallet extends StatefulWidget {
  @override
  _MyWalletState createState() => _MyWalletState();
}

class _MyWalletState extends State<MyWallet> {
  @override
  void initState() {
    super.initState();
    balanceBloc.add(Click());
  }

  String price;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text(
              "محفظتي",
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
      body: BlocListener<BalanceBloc, AppState>(
        bloc: balanceBloc,
        listener: (_, state) {
          if (state is RequestSent) {
            CustomAlert().toast(
                context: context,
                title: 'تم إرسال طلبك إلي الإدارة وسيتم التواصل معك');
          } else if (state is RequestError) {
            CustomAlert().toast(
                context: context,
                title: '  رصيدك اقل من الحد الآدني للسحب    ');
          }
        },
        child: BlocBuilder<BalanceBloc, AppState>(
          bloc: balanceBloc,
          builder: (_, state) {
            if (state is Done) {
              BalanceModel _res = state.model;
              return ListView(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height / 3,
                    color: Theme.of(context).primaryColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          _res.data[0].value.toString() ?? "0",
                          style: TextStyle(color: Colors.white, fontSize: 70),
                        ),
                        Text(
                          "ريال سعودي",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 200,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () => Navigator.push(context,
                          MaterialPageRoute(builder: (c) => ChargeScreen())),
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadiusDirectional.circular(20),
                          color: Theme.of(context).primaryColor,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                "اشحن محفظتك",
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: Icon(
                                    Icons.credit_card,
                                    color: Theme.of(context).primaryColor,
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: Provider.of<LoginProvider>(context, listen: false)
                            .type ==
                        2,
                    child: InkWell(
                      onTap: () => balanceBloc.add(RequestBalance()),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadiusDirectional.circular(20),
                            color: Theme.of(context).primaryColor,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  "سحب رصيد",
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child: Icon(
                                      Icons.credit_card,
                                      color: Theme.of(context).primaryColor,
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (c) => History()));
                      },
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[600]),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                "سجل العمليات",
                                style: TextStyle(color: Colors.black),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              CircleAvatar(
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  child: Icon(
                                    Icons.equalizer,
                                    color: Colors.white,
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              );
            }
            return AppLoader();
          },
        ),
      ),
    );
  }
}
