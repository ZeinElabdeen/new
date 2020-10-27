import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:haat/src/provider/get/MyAddressProvider.dart';
import 'package:haat/src/provider/get/deletePlaceProvider.dart';
import 'package:provider/provider.dart';

import '../../../../../../Helpers/sharedPref_helper.dart';

class MyPlacesCard extends StatefulWidget {
  final int index;

  const MyPlacesCard({Key key, this.index}) : super(key: key);

  @override
  _MyPlacesCardState createState() => _MyPlacesCardState();
}

class _MyPlacesCardState extends State<MyPlacesCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
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
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text(
                          Provider.of<MyAddressProvider>(context,listen: false).adress[widget.index].placeName ?? "",
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                    ),
                    SizedBox(height: 10),
                    Text(
                        Provider.of<MyAddressProvider>(context,listen: false).adress[widget.index].placeDetails ??"",
                        textAlign: TextAlign.right,
                        style: TextStyle(fontSize: 13)),
                  ],
                ),
              ),
            ),
          ),
          secondaryActions: <Widget>[
            InkWell(
              onTap: (){
                Provider.of<DeletePlaceProvider>(context,listen: false).deletePlace( 
                  Provider.of<SharedPref>(context,listen: false).token,
                  Provider.of<MyAddressProvider>(context, listen: false).adress[widget.index].id.toString(),
                  context).then((v){
                    if(v == true)
                     Provider.of<MyAddressProvider>(context, listen: false).getPlaces(
                       Provider.of<SharedPref>(context,listen: false).token);
                  });
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
