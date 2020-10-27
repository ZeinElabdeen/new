import 'package:flutter/material.dart';
import 'package:haat/src/provider/post/editOrderCartProvider.dart';
import 'package:provider/provider.dart';

import '../../../../MainWidgets/buttonSignIn.dart';
import '../../../../Helpers/sharedPref_helper.dart';
import '../../../../MainWidgets/details_text_field.dart';
import '../../../../provider/get/cartsProvider.dart';

class EditCartOrder extends StatefulWidget {
  final int index;

  const EditCartOrder({Key key, this.index}) : super(key: key);
  @override
  _EditCartOrderState createState() => _EditCartOrderState();
}

class _EditCartOrderState extends State<EditCartOrder> {
  final _form = GlobalKey<FormState>();
  bool autoError = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "تعديل الطلب",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
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
      body: Form(
        key: _form,
        autovalidate: autoError,
        child: ListView(
          children: [
            SizedBox(
              height: 40,
            ),
            DetailsTextField(
              hint: 'اكتب تفاصيل طلبك هنا',
              onChange: (v) {
                Provider.of<EditCartOrderProvider>(context, listen: false)
                    .orderDetails = v;
              },
              label: 'اكتب طلبك',
              onImg: (v) {
                Provider.of<EditCartOrderProvider>(context, listen: false)
                    .photo = v;
              },
              init: Provider.of<CartsProvider>(context, listen: false)
                  .carts[widget.index]
                  .orderDetails,
            ),
            SizedBox(
              height: 30,
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
                  Provider.of<EditCartOrderProvider>(context, listen: false)
                      .editCartOrder(
                          Provider.of<SharedPref>(context, listen: false).token,
                          Provider.of<CartsProvider>(context, listen: false)
                              .carts[widget.index]
                              .id,
                          context);
                },
                txtColor: Colors.white,
                btnColor: Theme.of(context).primaryColor,
                buttonText: "حفظ التعديل",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
