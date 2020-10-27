import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:haat/src/Helpers/text_helper.dart';
import 'package:haat/src/Screens/HomePages/Apis/BLoCs/shared_bloc.dart';
import 'package:haat/src/Screens/HomePages/Apis/Models/my_chats_model.dart';

import '../chat_room.dart';

class ChatCard extends StatelessWidget {
  final Chat chat;

  const ChatCard({Key key, this.chat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      children: <Widget>[
        InkWell(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => ChatRoom(
                      uniqueId: chat.orderId,
                      phone: chat.phone,
                      secondUserID: chat.secondUserId,
                      deleviryPrice:chat.orderPrice.toString(), 
                      orderPrice: chat.price.toString(),
                      
                      ))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      height: 50,
                      width: 50,
                      child: CachedNetworkImage(
                        imageUrl: chat.photo ?? "",
                        fadeInDuration: Duration(seconds: 2),
                        placeholder: (context, url) => CircleAvatar(
                            radius: 60,
                            backgroundImage:
                                AssetImage('assets/images/avatar.jpeg')),
                        imageBuilder: (context, provider) {
                          return CircleAvatar(
                              radius: 60, backgroundImage: provider);
                        },
                      ),
                    ),
                    SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            sharedBloc.data.id == chat.userId
                                ? chat.secondUser
                                : chat.user,
                            style: TextStyle(fontSize: 15)),
                        Text(
                          chat.lastMessage ?? 'لا توجد رسائل في المحادثة بعد',
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
                Text(
                  TextHelper().formatDate(date: chat.createdAt),
                  style: TextStyle(fontSize: 12),
                  textAlign: TextAlign.end,
                ),
              ],
            ),
          ),
        ),
        Divider(height: 1, color: Colors.grey)
      ],
    );
  }
}
