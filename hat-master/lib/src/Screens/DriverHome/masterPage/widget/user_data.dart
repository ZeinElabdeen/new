import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:haat/src/Helpers/sharedPref_helper.dart';
import 'package:haat/src/Screens/HomePages/Apis/App/app_state.dart';
import 'package:haat/src/Screens/HomePages/Apis/BLoCs/balance_bloc.dart';
import 'package:haat/src/Screens/HomePages/Apis/Models/palance_model.dart';
import 'package:provider/provider.dart';

class UserData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3.5,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 5,
            ),
            Text(
              "مرحبا بك",
              style: TextStyle(color: Colors.white),
            ),
            Text(Provider.of<SharedPref>(context, listen: false).name ?? "",
                style: TextStyle(color: Colors.white)),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RatingBar(
                  itemCount: 5,
                  itemSize: 20,
                  allowHalfRating: false,
                  initialRating: Provider.of<SharedPref>(context,listen: false).rate.toDouble()?? 0.0,
                  itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: null,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 100,
                  width: 100,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CachedNetworkImage(
                      imageUrl: Provider.of<SharedPref>(context, listen: false)
                              .photo ??
                          "",
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
              ],
            ),
            Text(
              "كابتن / بيك اب",
              style: TextStyle(
                color: Colors.white,
                //  fontSize: 20
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "ر.س",
                  style: TextStyle(
                    color: Colors.white,
                    //  fontSize: 20
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                BlocBuilder<BalanceBloc, AppState>(
                  bloc: balanceBloc,
                  builder: (context, state) {
                    if (state is Done) {
                      BalanceModel _res = state.model;
                      return Text(
                        _res.data[0].value.toString() ?? "0",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      );
                    } else
                      return Container(
                        height: 10,
                        width: 10,
                        child: CircularProgressIndicator(
                          strokeWidth: 1,
                        ));                  },
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "الرصيد المتاح",
                  style: TextStyle(
                    color: Colors.white,
                    //  fontSize: 20
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
