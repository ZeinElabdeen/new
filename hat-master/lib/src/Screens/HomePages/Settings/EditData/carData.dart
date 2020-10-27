import 'package:flutter/material.dart';
import 'package:haat/src/Helpers/sharedPref_helper.dart';
import 'package:provider/provider.dart';

import 'widget/carDocument.dart';

class CarData extends StatefulWidget {
  @override
  _CarDataState createState() => _CarDataState();
}

class _CarDataState extends State<CarData> {
  // SharedPreferences _pref;

  // getShared() async {
  //   _pref = await SharedPreferences.getInstance();
  //   setState(() {
  //     _pref = _pref;
  //   });
  // }

  @override
  void initState() {
    // getShared();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          "تعديل بيانات السيارة",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          CarDocuments(
            token: Provider.of<SharedPref>(context, listen: false).token,
          )
        ],
      ),
    );
  }
}
