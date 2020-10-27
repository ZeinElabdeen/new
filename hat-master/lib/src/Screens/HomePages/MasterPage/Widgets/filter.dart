import 'package:flutter/material.dart';
import 'package:haat/src/Helpers/sharedPref_helper.dart';
import 'package:haat/src/provider/get/departmentsProvider.dart';
import 'package:haat/src/provider/get/restourantProvider.dart';
import 'package:provider/provider.dart';

class Filter extends StatefulWidget {
  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter>  {


  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height / 12,
      height: 70,
      width: MediaQuery.of(context).size.width,
      color: Colors.grey[400],
      child: Center(

        child: ListView(
          reverse: true,
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Provider.of<RestourantsProvider>(context, listen: false)
                      .getRestourants(
                          Provider.of<SharedPref>(context, listen: false).lat,
                          Provider.of<SharedPref>(context, listen: false).long,
                          0,null);
                  setState(() {
                    selectAll = true;

                    for (int i = 0;
                        i < Provider.of<DepartMentProvider>(context,listen: false).departments.length;i++) {
                      Provider.of<DepartMentProvider>(context, listen: false) .departments[i].selected = false;
                    }
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: selectAll == true
                        ? Theme.of(context).primaryColor
                        : Colors.white,
                  ),
                  height: MediaQuery.of(context).size.height / 8,
                  width: MediaQuery.of(context).size.width / 8,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.home,
                        color: Colors.black,
                        size: 20,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "الكل",
                        style: TextStyle(color: Colors.black, fontSize: 10),
                      )
                    ],
                  ),
                ),
              ),
            ),
            ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount:
                    Provider.of<DepartMentProvider>(context, listen: true)
                        .departments
                        .length,
                itemBuilder: (c, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        Provider.of<RestourantsProvider>(context, listen: false).getRestourants(
                                Provider.of<SharedPref>(context, listen: false)
                                    .lat,
                                Provider.of<SharedPref>(context, listen: false)
                                    .long,
                                Provider.of<DepartMentProvider>(context,listen: false).departments[index].id,null);
                        setState(() {
                          selectAll = false;
                          Provider.of<DepartMentProvider>(context,listen: false).departments[index].selected = true;
                          for (int i = 0;
                              i < Provider.of<DepartMentProvider>(context,listen: false).departments.length; i++) {
                            if (i != index) {
                              Provider.of<DepartMentProvider>(context,listen: false).departments[i].selected = false;
                            }
                          }
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Provider.of<DepartMentProvider>(context,listen: false).departments[index].selected == true
                              ? Theme.of(context).primaryColor
                              : Colors.white,
                        ),
                        // height: MediaQuery.of(context).size.height / 8,
                        width: MediaQuery.of(context).size.width / 5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              height: 27,
                              width: 27,
                              child: Image.network(
                                Provider.of<DepartMentProvider>(context,listen: false).departments[index].photo,
                              ),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              Provider.of<DepartMentProvider>(context,listen: false).departments[index].name,
                              style: TextStyle(color: Colors.black, fontSize: 10),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }


  bool selectAll = false;
}
