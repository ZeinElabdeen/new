import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haat/src/MainWidgets/buttonSignIn.dart';
import 'package:haat/src/Helpers/sharedPref_helper.dart';
import 'package:haat/src/MainWidgets/custom_app_bar.dart';
import 'package:haat/src/MainWidgets/details_text_field.dart';
import 'package:haat/src/MainWidgets/register_text_field.dart';
import 'package:haat/src/Screens/HomePages/Orders/internal/orderFinish.dart';
import 'package:haat/src/provider/post/createOrderProvider.dart';
import 'package:provider/provider.dart';

class MapOrder extends StatefulWidget {
  @override
  _MapOrderState createState() => _MapOrderState();
}

class _MapOrderState extends State<MapOrder> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    Provider.of<CreateOrderProvider>(context, listen: false).latitude =
        Provider.of<SharedPref>(context, listen: false).lat.toString();
    Provider.of<CreateOrderProvider>(context, listen: false).longitude =
        Provider.of<SharedPref>(context, listen: false).long.toString();
    super.initState();
  }

  final _form = GlobalKey<FormState>();
  bool autoError = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomAppBar(
          onTap: () => Navigator.pop(context),
          label: "طلب من الخريطة",
          iconData: Icons.arrow_back_ios,
        ),
      ),
      body: Form(
        key: _form,
        autovalidate: autoError,
        child: ListView(
          children: <Widget>[
            SizedBox(height: 20),
            RegisterTextField(
              label: 'اسم المكان',
              type: TextInputType.text,
              icon: Icons.location_city,
              onChange: (v) {
                Provider.of<CreateOrderProvider>(context, listen: false)
                    .placeName = v;
              },
              // hint: 'اسم كافيه او مطعم او بقاله ...',
            ),
            SizedBox(height: 20),
            DetailsTextField(
              hint: 'اكتب تفاصيل طلبك هنا',
              onImg: (v) {
                Provider.of<CreateOrderProvider>(context, listen: false).photo =
                    v;
              },
              onChange: (v) {
                Provider.of<CreateOrderProvider>(context, listen: false)
                    .orderDetails = v;
              },
              label: 'اكتب طلبك',
            ),
            SizedBox(height: 20),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SignInButton(
                textSize: 15,
                btnWidth: MediaQuery.of(context).size.width - 20,
                btnHeight: 50,
                onPressSignIn: () {
                  setState(() {
                    autoError = true;
                  });
                  final isValid = _form.currentState.validate();
                  if (!isValid) {
                    return;
                  }
                  _form.currentState.save();
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => FinishOrder(
                        bag: 0,
                        type: 0,
                      )));
                },
                txtColor: Colors.white,
                btnColor: Theme.of(context).primaryColor,
                buttonText: "اعتماد الطلب",
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SignInButton(
                textSize: 15,
                btnWidth: MediaQuery.of(context).size.width - 20,
                btnHeight: 50,
                onPressSignIn: () {
                  setState(() {
                    autoError = true;
                  });
                  final isValid = _form.currentState.validate();
                  if (!isValid) {
                    return;
                  }
                  _form.currentState.save();
                  Provider.of<CreateOrderProvider>(context, listen: false).cart =
                      1.toString();

                  Provider.of<CreateOrderProvider>(context, listen: false)
                      .createOrder(
                          Provider.of<SharedPref>(context, listen: false).token,
                          0,
                          context);
                },
                txtColor: Colors.black,
                btnColor: Colors.grey[400],
                buttonText: "اضافة للسلة",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
