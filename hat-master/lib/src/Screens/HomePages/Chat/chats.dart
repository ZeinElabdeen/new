import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haat/src/Helpers/sharedPref_helper.dart';
import 'package:haat/src/MainWidgets/app_empty.dart';
import 'package:haat/src/MainWidgets/app_loader.dart';
import 'package:haat/src/MainWidgets/list_animator.dart';
import 'package:haat/src/Screens/HomePages/Apis/App/app_event.dart';
import 'package:haat/src/Screens/HomePages/Apis/App/app_state.dart';
import 'package:haat/src/Screens/HomePages/Apis/BLoCs/my_chats_bloc.dart';
import 'package:haat/src/Screens/HomePages/Apis/BLoCs/shared_bloc.dart';
import 'package:haat/src/Screens/HomePages/Apis/Models/my_chats_model.dart';
import 'package:provider/provider.dart';

import 'Widgets/chat_card.dart';

class Chats extends StatefulWidget {
  @override
  _ChatsState createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  @override
  void initState() {
    super.initState();
    myChatBloc.add(Click());
    sharedBloc.add(Click());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text("المحادثات",style: TextStyle(color: Colors.white),),
        leading: Visibility(
          visible: Provider.of<SharedPref>(context, listen: false).type == 2,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: BlocBuilder<MyChatBloc, AppState>(
        bloc: myChatBloc,
        builder: (_, state) {
          if (state is Done) {
            MyChatsModel _res = state.model;
            List<Widget> _cards = [];
            for (int i = 0; i < _res.data.length; i++) {
              _cards.add(ChatCard(chat: _res.data[i]));
            }
            return ListAnimator(data: _cards);
          } else if (state is Empty) {
            return AppEmpty(text: 'ليس لديك محادثات');
          }
          return AppLoader();
        },
      ),
    );
  }
}
