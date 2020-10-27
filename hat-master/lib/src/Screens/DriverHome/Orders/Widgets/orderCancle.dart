
import 'package:flutter/material.dart';
import 'package:haat/src/MainWidgets/customBtn.dart';
import 'package:haat/src/MainWidgets/custom_bottom_sheet.dart';
import 'package:haat/src/MainWidgets/register_text_field.dart';

import '../../Apis/App/app_event.dart';
import '../../Apis/BLoCs/OrdersBLoCs/orders_bloc.dart';

class OrderCancelBtn extends StatefulWidget {
  final BuildContext context;

  const OrderCancelBtn({Key key, this.context}) : super(key: key);

  @override
  _OrderCancelBtnState createState() => _OrderCancelBtnState();
}

class _OrderCancelBtnState extends State<OrderCancelBtn> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(30),
      child: CustomBtn(
        color: Colors.red,
        onTap: () => CustomBottomSheet().show(
            context: widget.context,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  RegisterTextField(
                    onChange: ordersBloc.updateReason,
                    label: 'سبب الإلغاء',
                    icon: Icons.label,
                    type: TextInputType.text,
                  ),
                  SizedBox(height: 20),
                  CustomBtn(
                    text: 'إلغاء',
                    color: Colors.red,
                    onTap: () {
                      Navigator.pop(widget.context);
                      ordersBloc.add(CancelOrder());
                    },
                    txtColor: Colors.white,
                  )
                ],
              ),
            )),
        text: 'إلغاء الطلب',
        txtColor: Colors.white,
      ),
    );
  }
}
