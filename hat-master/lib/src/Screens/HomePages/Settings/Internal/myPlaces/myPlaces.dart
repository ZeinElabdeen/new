import 'package:flutter/material.dart';
import 'package:haat/src/Helpers/sharedPref_helper.dart';
import 'package:haat/src/MainWidgets/app_empty.dart';
import 'package:haat/src/MainWidgets/app_loader.dart';
import 'package:haat/src/provider/get/MyAddressProvider.dart';
import 'package:provider/provider.dart';
import 'pickPlace.dart';
import 'widget/myPlaceCard.dart';

class MyPlaces extends StatefulWidget {
  @override
  _MyPlacesState createState() => _MyPlacesState();
}

class _MyPlacesState extends State<MyPlaces> {
  @override
  void initState() {
    Provider.of<MyAddressProvider>(context, listen: false)
        .getPlaces(Provider.of<SharedPref>(context, listen: false).token);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text(
              "عناويني",
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (c) => PickPlace()));
        },
        child: Icon(
          Icons.add_location,
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Provider.of<MyAddressProvider>(context, listen: true).categoriesModel == null
          ? AppLoader()
          : Provider.of<MyAddressProvider>(context, listen: true).adress .length == 0
              ? AppEmpty(text: 'ليس لديك عناوين سابقة')
              : ListView(
                  physics: ScrollPhysics(),
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount:
                          Provider.of<MyAddressProvider>(context, listen: false)
                              .adress
                              .length,
                      itemBuilder: (context, index) {
                        return MyPlacesCard(
                          index: index,
                        );
                      },
                    ),
                      SizedBox(
                      height: 70,
                    ),
                  ],
                ),
    );
  }
}

class Places {
  final String title;

  final String message;

  final DateTime createdAt;

  Places(this.title, this.message, this.createdAt);
}
