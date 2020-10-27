import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haat/src/MainWidgets/app_empty.dart';
import 'package:haat/src/MainWidgets/app_loader.dart';
import 'package:haat/src/MainWidgets/list_animator.dart';
import 'package:haat/src/Screens/HomePages/Apis/App/app_event.dart';
import 'package:haat/src/Screens/HomePages/Apis/App/app_state.dart';
import 'package:haat/src/Screens/HomePages/Apis/BLoCs/history_bloc.dart';
import 'package:haat/src/Screens/HomePages/Apis/Models/history_model.dart';
import 'package:haat/src/Screens/HomePages/Settings/Internal/Wallet/widget/history_card.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  void initState() {
    super.initState();
    historyBloc.add(Click());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text(
              "سجل العمليات",
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
        body: BlocBuilder<HistoryBloc, AppState>(
        bloc: historyBloc,
        builder: (_, state) {
          if (state is Done) {
            HistoryModel _res = state.model;
            List<Widget> _cards = [];
            for (int i = 0; i < _res.data.length; i++) {
              _cards.add(HistoryCard(history: _res.data[i]));
            }
            return ListAnimator(data: _cards);
          } else if (state is Error) {
            return AppEmpty(text: 'سجل عملياتك خالي حتى الآن');
          }
          return AppLoader();
        },
      ),
    );
  }
}
