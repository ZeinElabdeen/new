import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:haat/src/Screens/HomePages/MasterPage/internal/CreateOrder/pickupOrder.dart';
import 'package:haat/src/Screens/HomePages/MasterPage/internal/CreateOrder/restourantOrder.dart';
import 'package:haat/src/Screens/HomePages/MasterPage/internal/mapScreen.dart';

class PickupAndMap extends StatefulWidget {
  @override
  _PickupAndMapState createState() => _PickupAndMapState();
}

class _PickupAndMapState extends State<PickupAndMap>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Function> ontap = [
      () {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => PickUpOrder()));
      },
      () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => MapScreen()));
      },
      () {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => RestourantOrder()));
      }
    ];
    return Container(
      // height: MediaQuery.of(context).size.height / 8,
      height: 100,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Center(
        child: ListView.builder(
            shrinkWrap: true,
            reverse: true,
            scrollDirection: Axis.horizontal,
            itemCount: 2,
            itemBuilder: (c, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: ontap[index],
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Theme.of(context).primaryColor,
                    ),
                    height: MediaQuery.of(context).size.height / 8,
                    width: MediaQuery.of(context).size.width / 3.5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          iconPage[index],
                          color: Colors.white,
                          size: 40,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          filter[index],
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }

  List<String> filter = [
    "اطلب بيك اب",
    "اطلب من الخريطة",
    "طلبات اخري",
  ];

  List<IconData> iconPage = [
    FontAwesomeIcons.truck,
    Icons.location_on,
    Icons.description,
  ];
}
