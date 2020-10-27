import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String lable;
  final String photo;
  final String details;

  const CustomCard({Key key, this.lable, this.photo, this.details})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, right: 8, left: 8),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 12,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height / 12,
                    width: MediaQuery.of(context).size.width / 4,
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10))),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(photo, fit: BoxFit.cover),
                    ),
                  ),
                  SizedBox(width: 10),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          lable.length > 20 ? lable.substring(0,20) + "..." : lable,
                          style: TextStyle(color: Colors.black),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        // Text(
                        //   "نور الشريف",
                        //   style: TextStyle(color: Colors.grey),
                        // ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            // Icon(
                            //   Icons.location_on,
                            //   size: 10,
                            //   color: Theme.of(context).primaryColor,
                            // ),
                            // SizedBox(
                            //   width: 5,
                            // ),
                            Text(
                              details.length > 20 ? details.substring(0,20) + "..." : details,
                              style:
                                  TextStyle(fontSize: 10, color: Colors.grey),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: (){

                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: Theme.of(context).primaryColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.location_on,
                          size: 17,
                          color: Colors.white,
                        ),
                        // Text(
                        //   "15 كم",
                        //   style: TextStyle(color: Colors.white, fontSize: 12),
                        // )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
