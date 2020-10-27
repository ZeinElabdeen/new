import 'package:flutter/material.dart';
import 'package:haat/src/MainWidgets/customAppBar.dart';
import 'package:haat/src/Helpers/sharedPref_helper.dart';
import 'package:haat/src/MainWidgets/app_empty.dart';
import 'package:haat/src/MainWidgets/app_loader.dart';
import 'package:haat/src/provider/get/departmentsProvider.dart';
import 'package:haat/src/provider/get/restourantProvider.dart';
import 'package:provider/provider.dart';
import 'Categoris/PickUpAndMap/pickAndMap.dart';
import 'Categoris/Restourant/Restourants.dart';
import 'Widgets/filter.dart';

class MasterScreen extends StatefulWidget {
  @override
  _MasterScreenState createState() => _MasterScreenState();
}

class _MasterScreenState extends State<MasterScreen> {
  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 150), () {
      Provider.of<DepartMentProvider>(context, listen: false).getDepartements();
      Provider.of<RestourantsProvider>(context, listen: false).getRestourants(
          Provider.of<SharedPref>(context, listen: false).lat,
          Provider.of<SharedPref>(context, listen: false).long,
          0,
          null);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomAppBar(),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 00.0),
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            children: <Widget>[
              PickupAndMap(),
              Filter(),
              Provider.of<RestourantsProvider>(context, listen: true)
                          .restourant ==
                      null
                  ? AppLoader()
                  : Provider.of<RestourantsProvider>(context, listen: true)
                              .restourants
                              .length ==
                          0
                      ? AppEmpty(
                          text: "لا يوجد مطاعم",
                        )
                      : RestourantsCards()
            ],
          ),
        ),
      ),
    );
  }
}
