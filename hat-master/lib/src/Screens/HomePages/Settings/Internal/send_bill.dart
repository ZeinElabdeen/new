import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Helpers/image_picker_dialog.dart';
import '../../../../MainWidgets/custom_alert.dart';
import '../../../../MainWidgets/custom_app_bar.dart';
import '../../../../MainWidgets/custom_btn.dart';
import '../../../../MainWidgets/loader_btn.dart';
import '../../../../MainWidgets/register_text_field.dart';
import '../../../DriverHome/Apis/App/app_event.dart';
import '../../../DriverHome/Apis/App/app_state.dart';
import '../../../DriverHome/Apis/BLoCs/OrdersBLoCs/send_offer_bloc.dart';
import '../../../DriverHome/Orders/orders.dart';

class SendBill extends StatefulWidget {
  final int orderID;

  const SendBill({Key key, this.orderID}) : super(key: key);

  @override
  _SendBillState createState() => _SendBillState();
}

class _SendBillState extends State<SendBill> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  File _img;

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
          label: 'إرفاق الفاتورة',
        ),
      ),
      body: BlocListener<SendOfferBloc, AppState>(
        bloc: sendOfferBloc,
        listener: (_, state) {
          if (state is BillSent) {
            CustomAlert().toast(context: context, title: 'تم إرسال الفاتورة');
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => Orders()));
          }
          if (state is BillImgError) {
            CustomAlert()
                .toast(context: context, title: 'يجب عليك إرفاق الفاتورة');
          }
        },
        child: BlocBuilder<SendOfferBloc, AppState>(
          bloc: sendOfferBloc,
          builder: (_, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RegisterTextField(
                  onChange: sendOfferBloc.updateBill,
                  label: 'قيمة الفاتورة',
                  errorText: state is BillError ? 'قيمة الفاتورة مطلوبة' : null,
                  icon: Icons.attach_money,
                  type: TextInputType.number,
                ),
                SizedBox(height: 10),
                _img != null
                    ? Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        child: Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(
                              _img,
                              alignment: Alignment.center,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      )
                    : Container(),
                SizedBox(height: 20),
                CustomBtn(
                  onTap: () => ImagePickerDialog().show(
                      context: context,
                      onGet: (f) {
                        sendOfferBloc.updateBillImg(f);
                        setState(() {
                          _img = f;
                        });
                      }),
                  text: _img == null ? 'إختيار صورة' : 'تعديل الصورة',
                  color: Theme.of(context).primaryColor,
                  txtColor: Colors.white,
                ),
                SizedBox(height: 20),
                LoaderButton(
                  load: state is Loading ? true : false,
                  text: 'إرسال',
                  color: Theme.of(context).primaryColor,
                  onTap: () => sendOfferBloc.add(Bill()),
                  txtColor: Colors.white,
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
