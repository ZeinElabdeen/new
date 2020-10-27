import 'package:flutter/material.dart';
import 'package:haat/src/Screens/HomePages/MasterPage/Widgets/restourantCard.dart';
import 'package:haat/src/Screens/HomePages/MasterPage/internal/CreateOrder/restourantOrder.dart';
import 'package:haat/src/provider/get/restourantProvider.dart';
import 'package:provider/provider.dart';

class RestourantsCards extends StatefulWidget {
  @override
  _RestourantsCardsState createState() => _RestourantsCardsState();
}

class _RestourantsCardsState extends State<RestourantsCards> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 1.7,
      color: Colors.white,
      child: ListView(
        children: <Widget>[
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: Provider.of<RestourantsProvider>(context, listen: true).restourants.length,
              itemBuilder: (c, index) {
                return RestourantCard(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => RestourantOrder(index: index)));
                  },
                  title: Provider.of<RestourantsProvider>(context, listen: true).restourants[index].name,
                  photo: Provider.of<RestourantsProvider>(context, listen: true).restourants[index].photo,
                  distant: Provider.of<RestourantsProvider>(context, listen: true).restourants[index].distance.toString().substring(0, 3),
                  department: Provider.of<RestourantsProvider>(context, listen: true).restourants[index].department );
              }),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
