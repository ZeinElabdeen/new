
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haat/src/MainWidgets/app_empty.dart';
import 'package:haat/src/MainWidgets/app_loader.dart';
import 'package:haat/src/MainWidgets/custom_app_bar.dart';
import 'package:haat/src/MainWidgets/list_animator.dart';
import 'package:haat/src/Screens/DriverHome/Apis/App/app_event.dart';
import 'package:haat/src/Screens/DriverHome/Apis/App/app_state.dart';
import 'package:haat/src/Screens/DriverHome/Apis/BLoCs/OrdersBLoCs/orders_bloc.dart';
import 'package:haat/src/Screens/DriverHome/Apis/Models/all_orders_model.dart';
import 'package:haat/src/Screens/DriverHome/Orders/Widgets/ended_order_card.dart';
// import 'package:haat/src/Screens/HomePages/Apis/App/app_event.dart';
// import 'package:haat/src/Screens/HomePages/Apis/App/app_state.dart';
// import 'package:haat/src/Screens/HomePages/Apis/BLoCs/OrderBLoCs/orders_bloc.dart';
// import 'package:haat/src/Screens/HomePages/Apis/Models/all_orders_model.dart';
// import 'package:haat/src/Screens/HomePages/Orders/Widgets/ended_order_card.dart';
import 'package:haat/src/Screens/HomePages/Settings/Internal/Payment/Widgets/total_card.dart';


class DriverPayments extends StatefulWidget {
  final String title;

  const DriverPayments({Key key, this.title}) : super(key: key);
  @override
  _DriverPaymentsState createState() => _DriverPaymentsState();
}

class _DriverPaymentsState extends State<DriverPayments> {
  @override
  void initState() {
    super.initState();
    ordersBloc.updateOrderType(3);
    ordersBloc.add(Click());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: CustomAppBar(
            label: widget.title ?? "مدفوعاتي",
            onTap: () => Navigator.pop(context),
            iconData: Icons.arrow_back_ios,
          ),
        ),
        body: Directionality(
          textDirection: TextDirection.ltr,
          child: BlocBuilder<OrdersBloc, AppState>(
            bloc: ordersBloc,
            builder: (_, state) {
              if (state is Done) {
                AllOrdersModel _res = state.model;
                List<Widget> _cards = [];
                for (int i = 0; i < _res.data.length; i++) {
                  _cards.add(EndedOrderCard(order: _res.data[i]));
                }
                return ListView(
                  shrinkWrap: true,
                  children: [
                    ListAnimator(data: _cards),
                    TotalCard(total: ordersBloc.total)
                  ],
                );
              } else if (state is Empty) {
                return AppEmpty(text: 'ليس لديك ${widget.title} حتى الآن');
              }
              return AppLoader();
            },
          ),
        ));
  }
}

