import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haat/src/Helpers/sharedPref_helper.dart';
import 'package:haat/src/MainWidgets/app_empty.dart';
import 'package:haat/src/MainWidgets/app_loader.dart';
import 'package:haat/src/Screens/HomePages/Apis/App/app_event.dart';
import 'package:haat/src/Screens/HomePages/Apis/App/app_state.dart';
import 'package:haat/src/Screens/HomePages/Apis/BLoCs/notification_bloc.dart';
import 'package:haat/src/Screens/HomePages/Apis/Models/notification_model.dart';
import 'package:provider/provider.dart';

import 'Widgets/notificationCard.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    notificationsBloc.updateKey(_globalKey);
    notificationsBloc.add(Click());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "الاشعارات",
          style: TextStyle(color: Colors.white),
        ),
        leading: Visibility(
          visible: Provider.of<SharedPref>(context, listen: false).type == 1,
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
      body: ListView(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          BlocBuilder<NotificationsBloc, AppState>(
              bloc: notificationsBloc,
              builder: (_, state) {
                if (state is Done) {
                  NotificationModel _res = state.model;
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: _res.data.length,
                    itemBuilder: (context, index) {
                      return NotificationCard(
                        notification: _res.data[index],
                      );
                    },
                  );
                } else if (state is Empty) {
                  return AppEmpty(text: 'ليس لديك إشعارات');
                }
                return AppLoader();
              })
        ],
      ),
    );
  }
}
