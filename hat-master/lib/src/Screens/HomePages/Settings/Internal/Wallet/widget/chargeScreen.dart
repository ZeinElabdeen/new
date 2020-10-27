import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haat/src/MainWidgets/custom_alert.dart';
import 'package:haat/src/MainWidgets/loader_btn.dart';
import 'package:haat/src/MainWidgets/register_text_field.dart';

import '../bankPayment.dart';

import 'package:haat/src/Screens/DriverHome/Apis/App/app_event.dart';
import 'package:haat/src/Screens/DriverHome/Apis/App/app_state.dart';
import 'package:haat/src/Screens/DriverHome/Apis/BLoCs/payment_bloc.dart';
import 'package:haat/src/Screens/DriverHome/Apis/Models/paument_models.dart';

import '../online_payment.dart';

class ChargeScreen extends StatefulWidget {
  @override
  _ChargeScreenState createState() => _ChargeScreenState();
}

class _ChargeScreenState extends State<ChargeScreen> {
  String price;
  final _form = GlobalKey<FormState>();
  bool autoError = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "شحن المحفظة",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
        ),
        body: Form(
            key: _form,
            autovalidate: autoError,
            child: BlocListener<PaymentBloc, AppState>(
              bloc: paymentBloc,
              listener: (_, state) {
                if (state is Error) {
                  CustomAlert().toast(context: context, title: state.msg);
                } else if (state is Done) {
                  PaymentModel _res = state.model;
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => OnlinePaymentScreen(
                              url: _res.data[0].paymentUrl)));
                }
              },
              child: BlocBuilder<PaymentBloc, AppState>(
                bloc: paymentBloc,
                builder: (_, state) {
                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 100,
                        ),
                        RegisterTextField(
                          onChange: (v) {
                            paymentBloc.updateCash(int.parse(v));
                            price = v;
                          },
                          label: 'قيمة الشحن',
                          icon: Icons.attach_money,
                          type: TextInputType.number,
                        ),
                        SizedBox(height: 20),
                        LoaderButton(
                          load: state is Loading ? true : false,
                          text: 'شحن الآن',
                          color: Theme.of(context).primaryColor,
                          onTap: () {
                            setState(() {
                              autoError = true;
                            });
                            final isValid = _form.currentState.validate();
                            if (!isValid) {
                              return;
                            }
                            _form.currentState.save();
                            paymentBloc.add(Click());
                          },
                          txtColor: Colors.white,
                        ),
                        SizedBox(height: 20),
                        LoaderButton(
                          load: false,
                          text: 'الشحن عن طريق تحويل للحساب البنكي',
                          color: Theme.of(context).primaryColor,
                          onTap: () {
                            setState(() {
                              autoError = true;
                            });
                            final isValid = _form.currentState.validate();
                            if (!isValid) {
                              return;
                            }
                            _form.currentState.save();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (c) => BankingPay(
                                          price: price,
                                        )));
                          },
                          txtColor: Colors.white,
                        ),
                      ],
                    ),
                  );
                },
              ),
            )));
  }
}
