import 'package:flutter/material.dart';
import 'package:haat/src/Helpers/sharedPref_helper.dart';
import 'package:haat/src/Repository/appLocalization.dart';
import 'package:haat/src/Screens/HomePages/Notifications/notificationPage.dart';
import 'package:haat/src/provider/get/departmentsProvider.dart';
import 'package:haat/src/provider/get/restourantProvider.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatefulWidget {
  final String label;
  final GestureTapCallback onTap;
  final IconData iconData;

  CustomAppBar({this.label, this.onTap, this.iconData});

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

String searchKey = "";
TextEditingController controller;

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    controller.clear();
    searchKey = "";
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Row(
            textDirection: localization.currentLanguage.toString() == "en"
                ? TextDirection.ltr
                : TextDirection.rtl,
            children: <Widget>[
              Expanded(
                child: TextFormField(
                  controller: controller,
                  textDirection: localization.currentLanguage.toString() == "en"
                      ? TextDirection.ltr
                      : TextDirection.rtl,
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.text,
                  textAlign: localization.currentLanguage.toString() == "en"
                      ? TextAlign.left
                      : TextAlign.right,
                  textInputAction: TextInputAction.search,
                  onFieldSubmitted: (v) {
                    // searchandNavigate();
                    Provider.of<DepartMentProvider>(context, listen: false)
                        .getDepartements();
                    Provider.of<RestourantsProvider>(context, listen: false)
                        .getRestourants(
                            Provider.of<SharedPref>(context, listen: false).lat,
                            Provider.of<SharedPref>(context, listen: false)
                                .long,
                            0,
                            searchKey);
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 15),
                    hintText: localization.text("shearch"),
                  ),
                  onChanged: (v) {
                    setState(() {
                      searchKey = v;
                    });
                    Future.delayed(Duration(seconds: 1), () {
                      Provider.of<DepartMentProvider>(context, listen: false)
                          .getDepartements();
                      Provider.of<RestourantsProvider>(context, listen: false)
                          .getRestourants(
                              Provider.of<SharedPref>(context, listen: false)
                                  .lat,
                              Provider.of<SharedPref>(context, listen: false)
                                  .long,
                              0,
                              searchKey);
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                child: InkWell(
                    onTap: () {
                      setState(() {
                        searchKey = "";
                        controller.clear();
                      });
                    },
                    child: Icon(searchKey.length == 0
                        ? Icons.search
                        : Icons.delete_forever)),
              ),
            ],
          ),
        ),
      ),
      leading: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (c) => NotificationPage(),
                ));
          },
          child: Icon(
            Icons.notifications,
            color: Colors.white,
          )),
    );
  }
}
