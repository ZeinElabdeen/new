
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haat/src/MainWidgets/app_empty.dart';
import 'package:haat/src/MainWidgets/app_loader.dart';
import 'package:haat/src/MainWidgets/list_animator.dart';
import 'package:haat/src/Screens/DriverHome/Apis/App/app_state.dart';
import 'package:haat/src/Screens/DriverHome/Apis/BLoCs/OrdersBLoCs/orders_bloc.dart';
import 'package:haat/src/Screens/DriverHome/Apis/Models/all_orders_model.dart';
import 'package:haat/src/Screens/DriverHome/Orders/Widgets/new_order_card.dart';

class PinnedOrders extends StatefulWidget {
  @override
  _PinnedOrdersState createState() => _PinnedOrdersState();
}

class _PinnedOrdersState extends State<PinnedOrders> {
  @override
  void initState() {
    super.initState();
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
            _cards.add(NewOrderCard(order: _res.data[i], state: 1));
          }
          return ListAnimator(data: _cards);
        } else if (state is Empty) {
          return AppEmpty(text: 'ليس لديك طلبات معلقة');
        }
        return AppLoader();
      },
    );
  }
}
