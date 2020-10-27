import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:haat/src/Screens/HomePages/Apis/App/app_event.dart';
import 'package:haat/src/Screens/HomePages/Apis/BLoCs/notification_bloc.dart';
import 'package:haat/src/Screens/HomePages/Apis/Models/notification_model.dart' as model;

class NotificationCard extends StatefulWidget {
  final model.Notification notification;

  const NotificationCard({Key key,this.notification}) : super(key: key);

  @override
  _NotificationCardState createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {

  @override
  Widget build(BuildContext context) {
     return InkWell(
      onTap: (){},
      child: Padding(
        padding: const EdgeInsets.only(right: 20, left: 20),
        child: Slidable(
          actionPane: SlidableDrawerActionPane(),
          actionExtentRatio: 0.25,
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                            "${widget.notification.createdAt.day}/${widget.notification.createdAt.month}/${widget.notification.createdAt.year}",
                            style:
                                TextStyle(fontSize: 13, color: Colors.black)),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Text(widget.notification.title,
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(widget.notification.message,
                        textAlign: TextAlign.right,
                        style: TextStyle(fontSize: 13)),
                  ],
                ),
              ),
            ),
          ),
          secondaryActions: <Widget>[
            InkWell(
              onTap: () {
                notificationsBloc.updateNotificationID(widget.notification.id);
                notificationsBloc.add(Delete());
              },
              child: Material(
                shape: CircleBorder(),
                color: Colors.redAccent,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Icon(Icons.delete, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
