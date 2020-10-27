import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:haat/src/MainWidgets/custom_alert.dart';
import 'package:haat/src/MainWidgets/custom_app_bar.dart';
import 'package:haat/src/MainWidgets/custom_btn.dart';
import 'package:haat/src/MainWidgets/details_text_field_no_img%20copy.dart';
import 'package:haat/src/MainWidgets/loader_btn.dart';
import 'package:haat/src/Screens/HomePages/Apis/App/app_event.dart';
import 'package:haat/src/Screens/HomePages/Apis/App/app_state.dart';
import 'package:haat/src/Screens/HomePages/Apis/BLoCs/rate_bloc.dart';
import 'package:haat/src/Screens/HomePages/Settings/Internal/help.dart';

import '../../main_page.dart';

class Rating extends StatefulWidget {
  final int driverID;
  final int orderID;

  const Rating({Key key, this.driverID, this.orderID}) : super(key: key);

  @override
  _RatingState createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    rateBloc.updateKey(_globalKey);
    rateBloc.updateDriverID(widget.driverID);
    rateBloc.updateOrderID(widget.orderID);
  }

  final _form = GlobalKey<FormState>();
  bool autoError = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _globalKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomAppBar(label: 'التقييم'),
      ),
      body: BlocListener<RateBloc, AppState>(
        bloc: rateBloc,
        listener: (_, state) {
          if (state is Done) {
            CustomAlert()
                .toast(context: context, title: 'تم إسال تققيمك للسائق');
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (_) => MainPage(
                          index: 2,
                        )));
          }
        },
        child: BlocBuilder<RateBloc, AppState>(
          bloc: rateBloc,
          builder: (_, state) {
            return Form(
              key: _form,
              autovalidate: autoError,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: RatingBar(
                      onRatingUpdate: (value) =>
                          rateBloc.updateRate(value.toInt()),
                      itemCount: 5,
                      itemSize: 30,
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      allowHalfRating: true,
                      initialRating: 2,
                    ),
                  ),
                  SizedBox(height: 20),
                  DetailsTextFieldNoImg(
                    label: 'تقييم الخدمة',
                    hint: 'برجاء كتابة تقييم للخدمة (إختياري)',
                    onChange: rateBloc.updateRateText,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        right: 50, left: 50, top: 20, bottom: 20),
                    child: LoaderButton(
                      onTap: () {
                        setState(() {
                          autoError = true;
                        });
                        final isValid = _form.currentState.validate();
                        if (!isValid) {
                          return;
                        }
                        _form.currentState.save();
                        rateBloc.add(Click());
                      },
                      load: state is Loading ? true : false,
                      color: Theme.of(context).primaryColor,
                      text: 'إرسال التقييم',
                      txtColor: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 50, left: 50),
                    child: CustomBtn(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HelpCenter())),
                      color: Theme.of(context).primaryColor,
                      text: 'تقديم شكوى',
                      txtColor: Colors.white,
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
