
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haat/src/MainWidgets/custom_alert.dart';
import 'package:haat/src/MainWidgets/custom_app_bar.dart';
import 'package:haat/src/MainWidgets/details_text_field_no_img%20copy.dart';
import 'package:haat/src/MainWidgets/loader_btn.dart';
import 'package:haat/src/MainWidgets/register_text_field.dart';
import 'package:haat/src/Screens/DriverHome/Apis/App/app_event.dart';
import 'package:haat/src/Screens/DriverHome/Apis/App/app_state.dart';
import 'package:haat/src/Screens/DriverHome/Apis/BLoCs/OrdersBLoCs/send_offer_bloc.dart';
import 'package:haat/src/Screens/DriverHome/mainPageDriver.dart';
// import 'package:haat/src/Screens/HomePages/main_page.dart';

class SendOffer extends StatefulWidget {
  final int orderID;

  const SendOffer({Key key, this.orderID}) : super(key: key);

  @override
  _SendOfferState createState() => _SendOfferState();
}

class _SendOfferState extends State<SendOffer> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    sendOfferBloc.updateKey(_globalKey);
    sendOfferBloc.updateOrderID(widget.orderID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomAppBar(
          onTap: () => Navigator.pop(context),
          iconData: Icons.arrow_back_ios,
          label: 'تقدم بعرض سعر',
        ),
      ),
      body: BlocListener<SendOfferBloc, AppState>(
        bloc: sendOfferBloc,
        listener: (_, state) {
          if (state is Done) {
            CustomAlert().toast(
                context: context,
                title: 'تم إرسال عرض السعر وسيتم الرد عليه في خلال خمس دقائق');
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => MainPageDriver()));
          }
        },
        child: BlocBuilder<SendOfferBloc, AppState>(
          bloc: sendOfferBloc,
          builder: (_, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RegisterTextField(
                  label: 'عرض السعر',
                  icon: Icons.monetization_on,
                  type: TextInputType.number,
                  onChange: (v) => sendOfferBloc.updatePrice(int.parse(v)),
                  errorText: state is PriceError ? 'السعر مطلوب' : null,
                ),
                SizedBox(height: 20),
                DetailsTextFieldNoImg(
                  label: 'تفاصيل العرض',
                  onChange: sendOfferBloc.updateDetails,
                  hint: 'مثال.. وقت التجهيز وطريقة التغليف',
                ),
                Padding(
                  padding: EdgeInsets.all(50),
                  child: LoaderButton(
                    load: state is Loading ? true : false,
                    onTap: () => sendOfferBloc.add(Click()),
                    color: Theme.of(context).primaryColor,
                    text: 'إرسال',
                    txtColor: Colors.white,
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
