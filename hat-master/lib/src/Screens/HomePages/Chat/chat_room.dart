import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:haat/src/MainWidgets/image_bg.dart';
import 'package:haat/src/Screens/HomePages/Apis/App/app_event.dart';
import 'package:haat/src/Screens/HomePages/Apis/BLoCs/chat_bloc.dart';
import 'package:haat/src/Screens/HomePages/Apis/Models/AppModels/msg_model.dart';

import 'Widgets/chat_field.dart';
import 'Widgets/msg_card.dart';
import 'Widgets/popup_menu.dart';

class ChatRoom extends StatefulWidget {
  final int uniqueId;
  final int secondUserID;
  final String phone;
  final String deleviryPrice;
  final String orderPrice;

  const ChatRoom(
      {Key key,
      this.uniqueId,
      this.secondUserID,
      this.phone,
      this.deleviryPrice,
      this.orderPrice})
      : super(key: key);

  @override
  _ChatPageState createState() => new _ChatPageState();
}

class _ChatPageState extends State<ChatRoom> with TickerProviderStateMixin {
  List<MsgModel> _messages = [];

  @override
  void initState() {
    chatBloc.add(Init());
    super.initState();
    chatBloc.updateChatID(widget.uniqueId);
    chatBloc.updateSecondUserID(widget.secondUserID);
    chatBloc.messages.listen((event) {
      setState(() {
        _messages.insert(0, event);
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    chatBloc.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'محادثة',
              style: TextStyle(color: Colors.white),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'قيمة التوصيل',
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
                Text(
                  widget.deleviryPrice ?? "0",
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'قيمة الطلب',
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
                Text(
                  widget.orderPrice ?? "0",
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
              ],
            ),
          ],
        ),
        leading: InkWell(
          child: Icon(Icons.arrow_back_ios, color: Colors.white),
          onTap: () => Navigator.pop(context),
        ),
        actions: <Widget>[
          PopupWidget(
            phone: widget.phone,
            orderID: widget.uniqueId,
            driverID: widget.secondUserID,
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          ImageBG(),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                child: ListView.builder(
                    shrinkWrap: true,
                    reverse: true,
                    itemCount: _messages.length,
                    padding: new EdgeInsets.all(6.0),
                    itemBuilder: (_, int index) {
                      return MsgCard(
                        model: _messages[index],
                      );
                    }),
              ),
              ChatField()
            ],
          ),
        ],
      ),
    );
  }
}
