import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:haat/src/provider/aboutUsProvider.dart';

import 'package:url_launcher/url_launcher.dart';

class AboutApp extends StatefulWidget {
  @override
  _AboutAppState createState() => _AboutAppState();
}

class _AboutAppState extends State<AboutApp> {
  _launchURL() async {
    const url = 'https://tqnee.com.sa';
    launch(url);
  }

  @override
  void initState() {
    super.initState();
    Provider.of<AboutUsProvider>(context, listen: false).getAboutUs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text(
              "عن التطبيق",
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
      body: Provider.of<AboutUsProvider>(
                context,
              ).content ==
              null
          ? SpinKitThreeBounce(
              color: Theme.of(context).primaryColor,
              size: 22,
            )
          : Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 40.0,
                  ),
                  child: ListView(
                    children: <Widget>[
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "${Provider.of<AboutUsProvider>(context, listen: false).content}",
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    child: InkWell(
                      onTap: _launchURL,
                      child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            'تصميم وتنفيذ تقني لتقنية المعملومات',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.blueAccent, fontSize: 12),
                          )),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
