import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:haat/src/Helpers/sharedPref_helper.dart';
import 'package:provider/provider.dart';

class UserData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 100,
            width: 100,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CachedNetworkImage(
                imageUrl: Provider.of<SharedPref>(context, listen: false).photo  ?? "" ,
                errorWidget: (context, url, error) => ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset('assets/images/avatar.jpeg',
                        fit: BoxFit.cover)),
                fadeInDuration: Duration(seconds: 2),
                placeholder: (context, url) => ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset('assets/images/avatar.jpeg',
                        fit: BoxFit.cover)),
                imageBuilder: (context, provider) {
                  return ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image(
                        image: provider,
                        fit: BoxFit.cover,
                      ));
                },
              ),
            ),
          ),
          Text(Provider.of<SharedPref>(context, listen: false).name,
              style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
