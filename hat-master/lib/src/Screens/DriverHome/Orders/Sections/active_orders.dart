
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haat/src/MainWidgets/app_empty.dart';
import 'package:haat/src/MainWidgets/app_loader.dart';
import 'package:haat/src/MainWidgets/list_animator.dart';
import 'package:haat/src/Screens/DriverHome/Apis/App/app_state.dart';
import 'package:haat/src/Screens/DriverHome/Apis/BLoCs/OrdersBLoCs/orders_bloc.dart';
import 'package:haat/src/Screens/DriverHome/Apis/Models/all_orders_model.dart';
import 'package:haat/src/Screens/DriverHome/Orders/Widgets/acvtive_order_card.dart';

class ActiveOrders extends StatefulWidget {
  @override
  _ActiveOrdersState createState() => _ActiveOrdersState();
}

class _ActiveOrdersState extends State<ActiveOrders> {
  @override
  void initState() {
    super.initState();
    // ordersBloc.updateOrderType(2);
    // ordersBloc.add(Click());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersBloc, AppState>(
      bloc: ordersBloc,
      builder: (_, state) {
        if (state is Done) {
          AllOrdersModel _res = state.model;
          List<Widget> _cards = [];
          for (int i = 0; i < _res.data.length; i++) {
            _cards.add(ActiveOrderCard(order: _res.data[i]));
          }
          return ListAnimator(data: _cards);
        } else if (state is Empty) {
          return AppEmpty(text: 'ليس لديك طلبات نشطة');
        }
        return AppLoader();
      },
    );
  }
}
